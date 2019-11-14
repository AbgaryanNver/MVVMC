import Foundation

extension String {
    var isDigits: Bool {
        CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }

    /// SwifterSwift: Safely subscript string with index.
    ///
    ///        "Hello World!"[safe: 3] -> "l"
    ///        "Hello World!"[safe: 20] -> nil
    ///
    /// - Parameter i: index.
    subscript(safe idx: Int) -> Character? {
        guard idx >= 0, idx < count else {
            return nil
        }
        return self[index(startIndex, offsetBy: idx)]
    }

    /// Check if string only contains letters or/and digits.
    ///
    var isAlphaNumeric: Bool {
        let set = CharacterSet.letters.union(CharacterSet.decimalDigits)
        return set.isSuperset(of: CharacterSet(charactersIn: self))
    }

    var filterNumber: String { filter("0123456789.".contains) }

    var removeFirstZero: String {
        mutating get {
            first == "0" ? String(removeFirst()) : self
        }
    }
}
