import UIKit

struct CountryItem: TableViewItem {
    let country: Country
    
    var cellClassIdentifier: AnyClass = CountryCell.self

    init(country: Country) {
        self.country = country
    }
}

struct Country {
    let name: String
    let imageName: String
}
