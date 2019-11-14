import Foundation

@propertyWrapper
struct CodableUserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    let suitName: String?

    init(key: String, defaultValue: T, suitName: String? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        self.suitName = suitName
    }

    var wrappedValue: T {
        get {
            guard let data = defaults.data(forKey: key) else {
                return defaultValue
            }
            return (try? decoder.decode(T.self, from: data)) ?? defaultValue
        }
        set {
            let data = try? encoder.encode(newValue)
            defaults.set(data, forKey: key)
        }
    }

    private var defaults: UserDefaults {
        if let suitName = suitName {
            return UserDefaults(suiteName: suitName) ?? .standard
        } else {
            return .standard
        }
    }

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}
