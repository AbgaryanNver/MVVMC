import Foundation

class APILoader<T: APIHandler> {
    let apiRequest: T
    let urlSession: URLSession

    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }

    func loadAPIRequest(requestData: T.RequestDataType,
                        completionHandler: @escaping (Result<T.ResponseDataType?, Error>) -> Void) {
        if let connection = Reachability()?.connection, connection == .none {
            return completionHandler(.failure(ConectionError(message: "No Internet Connection")))
        }
        guard let urlRequest = apiRequest.makeRequest(from: requestData)?.urlRequest else {
            return
        }

        urlSession.dataTask(with: urlRequest) { data, response, error in
            self.log(response, with: data)
            if let data = data, data != Data() {
                do {
                    let parsedResponse = try self.apiRequest.parseResponse(data: data)

                    return completionHandler(.success(parsedResponse))
                } catch {
                    return completionHandler(.failure(error))
                }
            }

            switch (response as? HTTPURLResponse)?.statusCode {
                case .some(200...299):
                    completionHandler(.success(nil))
                default:
                    if let error = error {
                        completionHandler(.failure(error))
                    } else {
                        completionHandler(.failure(APIError(message: "somethiingUnexpectedHappenedError", description: nil)))
                    }
            }
        }.resume()
    }

    private func log(_ response: URLResponse?, with data: Data?) {
        let responseUrl = response?.url?.absoluteString ?? ""
        let message = "Endpoint:\n\(responseUrl)\nResponse:\n\(data?.prettyJSON ?? "data is nil")"
        // let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
        // print(string1)
        print(message)
    }
}
