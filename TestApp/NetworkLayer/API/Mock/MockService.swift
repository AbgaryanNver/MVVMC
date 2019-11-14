import Foundation

class MockService {
    func createSession(response: Data?, completion: @escaping (URLSession) -> Void) {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), response ?? Data())
        }

        completion(urlSession)
    }
}
