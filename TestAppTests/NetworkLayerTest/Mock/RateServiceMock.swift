import Foundation
@testable import TestApp

class RateServiceMock: RateService {
    var rate: [String: Double] = [:]
    var key: CurrencyKey?
    var keys: [CurrencyKey] = []

    // MARK: - getItems

    var getItemsCallsCount = 0
    var getItemsCalled: Bool {
        getItemsCallsCount > 0
    }

    var getItemsReturnValue: [RateItem]!
    var getItemsClosure: (() -> [RateItem])?

    func getItems() -> [RateItem] {
        getItemsCallsCount += 1
        return getItemsClosure.map { $0() } ?? []
    }

    // MARK: - removeItem

    var removeItemByCallsCount = 0
    var removeItemByCalled: Bool {
        removeItemByCallsCount > 0
    }

    var removeItemByReceivedKey: CurrencyKey?
    var removeItemByReceivedInvocations: [CurrencyKey] = []
    var removeItemByClosure: ((CurrencyKey) -> Void)?

    func removeItem(by key: CurrencyKey) {
        removeItemByCallsCount += 1
        removeItemByReceivedKey = key
        removeItemByClosure?(key)
    }

    // MARK: - storeState

    var storeStateCallsCount = 0
    var storeStateCalled: Bool {
        storeStateCallsCount > 0
    }

    var storeStateReceivedCurrencyKey: CurrencyKey?
    var storeStateReceivedInvocations: [CurrencyKey] = []
    var storeStateClosure: ((CurrencyKey) -> Void)?

    func storeState(_ currencyKey: CurrencyKey) {
        storeStateCallsCount += 1
        storeStateReceivedCurrencyKey = currencyKey
        storeStateClosure?(currencyKey)
    }

    // MARK: - clear

    var clearCallsCount = 0
    var clearCalled: Bool {
        clearCallsCount > 0
    }

    var clearClosure: (() -> Void)?

    func clear() {
        clearCallsCount += 1
        clearClosure?()
    }

    // MARK: - setRate

    var setRateCallsCount = 0
    var setRateCalled: Bool {
        setRateCallsCount > 0
    }

    var setRateReceivedRate: [String: Double]?
    var setRateReceivedInvocations: [[String: Double]] = []
    var setRateClosure: (([String: Double]) -> Void)?

    func setRate(_ rate: [String: Double]) {
        setRateCallsCount += 1
        setRateReceivedRate = rate
        setRateClosure?(rate)
    }
}
