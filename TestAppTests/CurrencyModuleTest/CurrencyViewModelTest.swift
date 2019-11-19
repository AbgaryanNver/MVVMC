// swiftlint:disable all
// allow force unwrap only in test cases
@testable import TestApp
import XCTest

class CurrencyViewModelTest: XCTestCase {
    var sut: CurrencyViewModel!
    let flowDelegateMock = CurrencyCoordinatorDelgateMock()

    override func setUp() {
        super.setUp()
        sut = CurrencyViewModel(context: CoordinatorContextMock(), flowDelegate: flowDelegateMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSetItems() {
        sut.setItems(.nok, [.sgd])
        XCTAssert(sut.dataSource.value.count == sut.allKeys.count, "should create items from allkeys")
        sut.dataSource.value.forEach { item in
            if let item = item as? CountryItem {
                if item.key == .nok {
                    XCTAssert(item.isMainItem, "should be main item")
                }
                if item.key == .sgd {
                    XCTAssert(item.isSelected, "should be isSelected")
                }
            } else {
                XCTFail("all item should be of type CountryItem")
            }
        }
    }

    func testDidTapedCell() {
        let items = [CountryItem(key: .sgd), CountryItem(key: .usd), CountryItem(key: .sek)]
        sut.dataSource.value = items

        let indexPath = IndexPath(item: 1, section: 0)
        sut.didTapedCell(at: indexPath)
        let isStoreStateCalled = (sut.context.rateService as? RateServiceMock)!.storeStateCalled
        XCTAssertTrue(isStoreStateCalled, "should be called")

        sut.dataSource.value = []
        sut.didTapedCell(at: indexPath)
        XCTAssertFalse(!isStoreStateCalled, "should not call when items array of emtpy")
    }

    func testGoNext() {
        sut.goNext(nil, [.sek, .eur])
        let didTapedCellCalledFirst = (sut.flowDelegate as? CurrencyCoordinatorDelgateMock)!.didTapedCellCalled
        XCTAssertFalse(didTapedCellCalledFirst, "should not call when first key is nil")

        sut.goNext(.gbp, [])
        let didTapedCellCalledSecond = (sut.flowDelegate as? CurrencyCoordinatorDelgateMock)!.didTapedCellCalled
        XCTAssertFalse(didTapedCellCalledSecond, "should not call when array of key empty")

        sut.goNext(.gbp, [.sek, .eur])
        let didTapedCellCalledThird = (sut.flowDelegate as? CurrencyCoordinatorDelgateMock)!.didTapedCellCalled
        XCTAssertTrue(didTapedCellCalledThird, "should be called")
    }
}
