// swiftlint:disable all
@testable import TestApp
import XCTest

class APILoaderTests: XCTestCase {
    var loader: APILoader<RateAPI>!

    override func setUp() {
        super.setUp()

        let request = RateAPI()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        loader = APILoader(apiRequest: request, urlSession: urlSession)
    }

    override func tearDown() {
        loader = nil
        super.tearDown()
    }

    func testLoginAPISuccess() {
        let params = ["CZKUSD", "CZKHUF", "CZKNOK"] as [String]
        let sampleResponse =
            """
                  {
                      "CZKUSD" : 0.0448,
                      "CZKHUF" : 12.426399999999999,
                      "CZKNOK" : 0.386299
                  }
            """
        let mockJSONData = sampleResponse.data(using: .utf8)!
        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockJSONData)
        }
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: params) { result in
            switch result {
                case let .success(respose):
                    XCTAssertEqual(respose, ["CZKUSD": 0.044_8, "CZKHUF": 12.426_399_999_999_999, "CZKNOK": 0.386_299])
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("should success but have error = \(error.localizedDescription)")
                    expectation.fulfill()
            }

            self.wait(for: [expectation], timeout: 1)
        }
    }
}
