import Foundation

struct RateItem: TableViewItem {
    let formCountry: Country
    let toCountry: Country
    let rateValue: String

    var cellClassIdentifier: AnyClass = RateCell.self

    init(formCountry: Country, toCountry: Country, rateValue: String) {
        self.formCountry = formCountry
        self.toCountry = toCountry
        self.rateValue = rateValue
    }
}
