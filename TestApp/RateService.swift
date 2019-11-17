import Foundation

class RateService {
    @CodableUserDefault(key: "Rate", defaultValue: [:])

    var rate: [String: Double] {
        didSet(new) {
            convertor.dictionary = new
        }
    }

    lazy var convertor = Convertor(rate)

    @CodableUserDefault(key: "from", defaultValue: nil)
    var key: CurrencyKey
    @CodableUserDefault(key: "to", defaultValue: [])
    var keys: [CurrencyKey]

    func storeState(currencyKey: CurrencyKey, currencyKeys: [CurrencyKey]) {
        key = currencyKey
        keys = currencyKeys
    }
}

class Convertor {
    var reateItems: [RateItem?] {
        dictionary.map { pair in
            let rateVale = String(format: "%.4f", pair.value)

            guard let fromCurrencyKey = CurrencyKey(rawValue: String(pair.key.prefix(3)).lowercased()),
                let toCurrencykey = CurrencyKey(rawValue: String(pair.key.suffix(3)).lowercased()) else {
                return nil
            }

            return RateItem(fromCurrencyKey: fromCurrencyKey, toCurrencyKey: toCurrencykey, rateValue: rateVale)
        }
    }

    var dictionary: [String: Double]

    init(_ dictionary: [String: Double]) {
        self.dictionary = dictionary
    }
}

enum CurrencyKey: String, CaseIterable, Codable {
    case gbp, sek, dkk, pln, eur, nok, huf, czk, usd, sgd, hkd

    var currency: String {
        switch self {
            case .gbp:
                return "Great Britain Pound"
            case .sek:
                return "Swedish Krona"
            case .dkk:
                return "Danish Krone"
            case .pln:
                return "Polish Zloty"
            case .eur:
                return "Euro"
            case .nok:
                return "Norwegian Krone"
            case .huf:
                return "Hungarian Forint"
            case .czk:
                return "Czech Koruna"
            case .usd:
                return "United States Dollar"
            case .sgd:
                return "Singapore Dollar"
            case .hkd:
                return "Hong Kong Dollar"
        }
    }

    var imageName: String {
        switch self {
            case .gbp:
                return "UK"
            case .sek:
                return "Sweden"
            case .dkk:
                return "Denmark"
            case .pln:
                return "Poland"
            case .eur:
                return "EU"
            case .nok:
                return "Norway"
            case .huf:
                return "Hungary"
            case .czk:
                return "Czech"
            case .usd:
                return "US"
            case .sgd:
                return "Singapore"
            case .hkd:
                return "HK"
        }
    }
}
