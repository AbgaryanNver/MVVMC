import Foundation

struct RateAPI: APIHandler {
    func makeRequest(from _: [String: Any]) -> Request {
        let url = URL(string: Path().ratesUrlStirng)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        let request = Request(urlRequest: urlRequest, requestBuilder: DefaultRequest())

        return request
    }

    func parseResponse(data: Data) throws -> ReteResponse {
        try defaultParseResponse(data: data)
    }
}

class APIProvider {
    func getRates(ratePair _: [String], completion: @escaping (Result<ReteResponse?, Error>) -> Void) {
        let api = RateAPI()
        APILoader(apiRequest: api).loadAPIRequest(requestData: [:]) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
