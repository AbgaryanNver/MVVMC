// swiftlint:disable all
@testable import TestApp
import XCTest

class RateViewModelTest: XCTestCase {
    var sut: RatesViewModel!
    let timeService = TimeServiceProtocolMock(duration: 1)

    override func setUp() {
        super.setUp()
        sut = RatesViewModel(context: CoordinatorContextMock(), timeService: timeService)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewDidLoadAndSetItems() {
        sut.viewDidLoad()
        let startTimeOutputCalled = timeService.startTimeOutputCalled
        XCTAssertTrue(startTimeOutputCalled, "should be called")

        let item1 = RateItem(fromCurrencyKey: .huf, toCurrencyKey: .czk, rateValue: "123")
        let item2 = RateItem(fromCurrencyKey: .huf, toCurrencyKey: .czk, rateValue: "23")
        let rateItems = [item1, item2]
        sut.setItems(rateItems)
        guard let items = sut.rateItems.value as? [RateItem] else {
            XCTFail("sut.rateItems.value should be RateItem ")
            return
        }
        XCTAssertEqual(items, rateItems, "rateItems should be in array of sut.rateItems")
    }

    func testStopTimer() {
        sut.stopTime()
        let stopTimeCalled = timeService.stopTimeCalled
        XCTAssertTrue(stopTimeCalled, "should be called")
    }

    func testRemoveItem() {
        let item = RateItem(fromCurrencyKey: .huf, toCurrencyKey: .czk, rateValue: "123")
        sut.didRemove(item)
        let removeItemByCalled = (sut.context.rateService as? RateServiceMock)!.removeItemByCalled
        XCTAssertTrue(removeItemByCalled, "should be called")
    }

    func testGetRates() {
        let keys: [CurrencyKey] = [.sek, .gbp]

        sut.getRates(.czk, keys)
        let getRatesRatePairCompletionCalled = (sut.context.restAPI as? APIProviderMock)!.getRatesRatePairCompletionCalled
        XCTAssertTrue(getRatesRatePairCompletionCalled, "should be called")
        // (sut.context.restAPI as? APIProviderImpl).
    }
}
