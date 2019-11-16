import Foundation

struct CountryItem: TableViewItem {
    let country: Country
    var isMainItem: Bool
    var isSelected: Bool

    var cellClassIdentifier: AnyClass = CountryCell.self

    init(country: Country, isMainItem: Bool = false, isSelected: Bool = false) {
        self.isMainItem = isMainItem
        self.isSelected = isSelected
        self.country = country
    }
}
