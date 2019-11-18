import Foundation

struct RateAPI: APIHandler {
    func makeRequest(from parameters: [String]) -> Request? {
        var components = URLComponents(string: Path().ratesUrlStirng) ?? URLComponents()
        var queryItems = [URLQueryItem]()
        for value in parameters {
            queryItems.append(URLQueryItem(name: "pairs", value: "\(value)"))
        }

        components.queryItems = queryItems
        guard let url = components.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        let request = Request(urlRequest: urlRequest)
        return request
    }

    func parseResponse(data: Data) throws -> [String: Double] {
        try defaultParseResponse(data: data)
    }
}

class APIProvider {
    func getRates(ratePair: [String], completion: @escaping (Result<[String: Double]?, Error>) -> Void) {
        let api = RateAPI()
        APILoader(apiRequest: api).loadAPIRequest(requestData: ratePair) { result in
            completion(result)
        }
    }
}
