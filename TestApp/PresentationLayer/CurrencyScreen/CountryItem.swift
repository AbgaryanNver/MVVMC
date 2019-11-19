import Foundation

struct CountryItem: TableViewItem {
    let key: CurrencyKey

    var isMainItem: Bool
    var isSelected: Bool
    var cellClassIdentifier: AnyClass = CountryCell.self

    init(key: CurrencyKey, isMainItem: Bool = false, isSelected: Bool = false) {
        self.isMainItem = isMainItem
        self.isSelected = isSelected
        self.key = key
    }
}
