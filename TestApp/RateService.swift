import Foundation

class RateService {
    @CodableUserDefault(key: "Rate", defaultValue: [:])

    var rate: [String: Double]

    @CodableUserDefault(key: "from", defaultValue: nil)

    var key: CurrencyKey?

    @CodableUserDefault(key: "to", defaultValue: [])

    var keys: [CurrencyKey]

    func getItems() -> [RateItem] {
        guard let fromCurrencyKey = key else {
            return []
        }
        return keys.map { toKey in
            let dicKey = fromCurrencyKey.keyName + toKey.keyName
            let rateValue = rate.first { $0.key == dicKey }?.value
            let rateStringVale = String(format: "%.4f", rateValue ?? 0.0)

            return RateItem(fromCurrencyKey: fromCurrencyKey, toCurrencyKey: toKey, rateValue: rateStringVale)
        }
    }

    func removeItem(by key: CurrencyKey) {
        keys.removeAll { currencyKey -> Bool in
            currencyKey == key
        }
        if keys.isEmpty {
            self.key = nil
            rate = [:]
        }
    }

    func storeState(_ currencyKey: CurrencyKey) {
        if key == nil {
            key = currencyKey
            return
        }

        if !keys.contains(currencyKey), key != currencyKey {
            keys.append(currencyKey)
        }
    }

    func clear() {
        key = nil
        keys = []
        rate = [:]
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

    var keyName: String {
        rawValue.uppercased()
    }
}
