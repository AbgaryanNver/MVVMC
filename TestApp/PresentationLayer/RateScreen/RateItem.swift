import Foundation

struct RateItem: TableViewItem {
    let fromCurrencyKey: CurrencyKey
    let toCurrencyKey: CurrencyKey
    let rateValue: String

    var cellClassIdentifier: AnyClass = RateCell.self

    init(fromCurrencyKey: CurrencyKey, toCurrencyKey: CurrencyKey, rateValue: String) {
        self.fromCurrencyKey = fromCurrencyKey
        self.toCurrencyKey = toCurrencyKey
        self.rateValue = rateValue
    }
}

extension RateItem: Equatable {
    static func == (lhs: RateItem, rhs: RateItem) -> Bool {
        lhs.cellClassIdentifier == rhs.cellClassIdentifier
    }
}
