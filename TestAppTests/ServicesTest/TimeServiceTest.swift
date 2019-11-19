@testable import TestApp
import XCTest

class TimeSeviceTest: XCTestCase {
    // swiftlint:disable all

    let sut = TimeService(duration: 1)

    func testTimer() {}

//
//    func test200Response() {
//        let sampleResponse =
//            """
//            {
//              "CZKUSD" : 0.0448,
//              "CZKHUF" : 12.426399999999999,
//              "CZKNOK" : 0.38629999999999998
//            }
//            """
//        let jsonData = sampleResponse.data(using: .utf8)!
//
//        XCTAssertNoThrow(try sut.parseResponse(data: jsonData))
//        do {
//            let response = try sut.parseResponse(data: jsonData)
//            XCTAssertEqual(response, ["CZKUSD": 0.0448, "CZKHUF": 12.426399999999999, "CZKNOK": 0.38629999999999998])
//        } catch {
//            XCTFail()
//        }
//    }
//
//    func testUnknownError() {
//        let sampleResponse =
//            """
//            {
//                "dummy text"
//            }
//            """
//        let jsonData = sampleResponse.data(using: .utf8)!
//
//        do {
//            _ = try sut.parseResponse(data: jsonData)
//            XCTFail()
//        } catch let error as UnknownParseError {
//            XCTAssertNotNil(error)
//        } catch {
//            XCTFail()
//        }
//    }
}
