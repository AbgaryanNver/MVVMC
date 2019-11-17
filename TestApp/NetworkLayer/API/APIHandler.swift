import Foundation

typealias APIHandler = RequestHandler & ResponseHandler

protocol RequestHandler {
    associatedtype RequestDataType

    func makeRequest(from data: RequestDataType) -> Request
}

protocol ResponseHandler {
    associatedtype ResponseDataType

    func parseResponse(data: Data) throws -> ResponseDataType
}

protocol RequestBuilder {
    func setHeaders(request: inout URLRequest)
}

class DefaultRequest: RequestBuilder {
    func setHeaders(request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "application/json")
    }
}

class Request {
    private var request: URLRequest

    init(urlRequest: URLRequest, requestBuilder: RequestBuilder) {
        request = urlRequest
        requestBuilder.setHeaders(request: &request)
    }

    init(urlRequest: URLRequest) {
        request = urlRequest
    }

    var urlRequest: URLRequest {
        request
    }
}

extension RequestHandler {
    func makePOSTRequest(from data: [String: Any], url: URL) -> Request {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        set(data, urlRequest: &urlRequest)
        let request = Request(urlRequest: urlRequest, requestBuilder: DefaultRequest())
        return request
    }

    func set(_ parameters: [String: Any], urlRequest: inout URLRequest) {
        if !parameters.isEmpty {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }
    }
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()

        if let body = try? jsonDecoder.decode(T.self, from: data) {
            return body
        } else if let errorResponse = try? jsonDecoder.decode(APIError.self, from: data) {
            throw errorResponse
        } else {
            throw UnknownParseError()
        }
    }
}
