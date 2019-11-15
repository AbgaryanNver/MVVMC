import UIKit

struct CountryItem: TableViewItem {
    let country: Country

    var cellClassIdentifier: AnyClass = CountryCell.self

    init(country: Country) {
        self.country = country
    }
}

struct Country: Hashable {
    let cur: String
    let currency: String
    let imageName: String
}

// enum Countryss: Cou, CaseIterable {
//    case gbp = "Great Britain Pound"
//    case sek = "Swedish Krona"
//    case dkk = "Danish Krone"
//    case pln = "Polish Zloty"
//    case eur = "Euro"
//    case nok = "Norwegian Krone"
//    case huf = "Hungarian Forint"
//    case czk = "Czech Koruna"
//    case usd = "United States Dollar"
//    case sgd = "Singapore Dollar"
//    case hkd = "Hong Kong Dollar"
// }

struct Countrys {
    static let greatBritain = Country(cur: "GBP", currency: "Great Britain Pound", imageName: "UK")
    static let swedish = Country(cur: "SEK", currency: "Swedish Krona", imageName: "Sweden")
    static let danish = Country(cur: "DKK", currency: "Danish Krone", imageName: "Denmark")
    static let polish = Country(cur: "PLN", currency: "Polish Zloty", imageName: "Poland")
    static let europ = Country(cur: "EUR", currency: "Euro", imageName: "EU")
    static let norwegian = Country(cur: "NOK", currency: "Norwegian Krone", imageName: "Norway")
    static let hungary = Country(cur: "HUF", currency: "Hungarian Forint", imageName: "Hungary")
    static let czech = Country(cur: "CZK", currency: "Czech Koruna", imageName: "Czech")
    static let unitedStates = Country(cur: "USD", currency: "United States Dollar", imageName: "US")
    static let singapore = Country(cur: "SGD", currency: "Singapore Dollar", imageName: "Singapore")
    static let hongKong = Country(cur: "HKD", currency: "Hong Kong Dollar", imageName: "HK")

    static var allCountrys: Set<Country> {
        [greatBritain, swedish, danish, polish, europ, norwegian, hungary, czech, unitedStates, singapore, hongKong]
    }
}
