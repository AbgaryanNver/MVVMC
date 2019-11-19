// swiftlint:disable all
// allow force unwrap only in test cases
@testable import TestApp
import XCTest

class RateServiceTest: XCTestCase {
    var sut: RateService!

    override func setUp() {
        super.setUp()
        sut = RateServiceImpl()
    }

    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }

    func testGetItems() {
        sut?.clear()
        XCTAssert(sut.getItems().isEmpty, "items array should be empty")

        // add first element
        sut.storeState(CurrencyKey.gbp)
        XCTAssert(sut.getItems().isEmpty, "items array should be empty")

        // add second elementn but rate value is empty
        sut.clear()
        sut.storeState(CurrencyKey.gbp)
        sut.storeState(CurrencyKey.sek)
        let items = sut.getItems()
        XCTAssert(!items.isEmpty, "items array should not be empty")
        let rateValue = items.first!.rateValue
        let expectedRateValue = "0.0000"
        XCTAssertEqual(rateValue, expectedRateValue, "unexpected rate value")

        // add second elementn but rate value is empty
        sut.clear()
        sut.storeState(CurrencyKey.gbp)
        sut.storeState(CurrencyKey.sek)
        sut.rate = ["GBPSEK": 0.234_342_34]
        XCTAssert(!sut.getItems().isEmpty, "items array should not be empty")
        XCTAssertEqual(sut.getItems().first!.rateValue, "0.2343", "unexpected rate value")
        sut.clear()
    }

    func testRemoveItem() {
        sut.clear()
        sut.keys = [.gbp, .sgd]
        sut.removeItem(by: .czk)
        XCTAssertEqual(sut.keys, [.gbp, .sgd], "should not remove anything")

        sut.removeItem(by: .sgd)
        XCTAssertEqual(sut.keys, [.gbp], "should remove .sgd from array")

        sut?.rate = ["GBPSEK": 0.234_342_34]
        sut.removeItem(by: .gbp)
        XCTAssertEqual(sut.keys, [], "should remove .sgd from array")
        XCTAssert(sut.key == nil, "should remove key when remve last item form keys array")
        XCTAssert(sut.rate.isEmpty, "should remove rates when remove last item form keys array")
    }

    func testStoreState() {
        sut.clear()
        sut.storeState(.sek)
        XCTAssertEqual(sut.key!, CurrencyKey.sek, "first added key should be stored")

        sut.storeState(.gbp)
        XCTAssertEqual(sut.keys.first, CurrencyKey.gbp, "second added key should be stored in array of keys")

        sut.storeState(.sek)
        XCTAssert(!sut.keys.contains(.sek), "dont allow add CurrencyKey that stored key property to keys ")

        sut.storeState(.gbp)
        let arrayOfgbp = sut.keys.filter { $0 == .gbp }
        XCTAssert(arrayOfgbp.count == 1, "dont allow have same key twice in keys array")

        XCTAssertEqual(sut.keys.first, CurrencyKey.gbp, "second added key should be stored in array of keys")
    }

    func testClear() {
        sut.key = CurrencyKey.czk
        sut.keys = [CurrencyKey.dkk]
        sut.rate = ["GBPSEK": 0.234_342_34]
        sut.clear()
        XCTAssert(sut.key == nil, "should be nil")
        XCTAssert(sut.keys.isEmpty, "should be empty")
        XCTAssert(sut.rate.isEmpty, "should be empty")
    }
}
