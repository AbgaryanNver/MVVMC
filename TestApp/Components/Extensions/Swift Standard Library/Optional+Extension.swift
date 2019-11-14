import Foundation

extension Optional {
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else {
            throw errorExpression()
        }
        return value
    }

    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        flatMap { predicate($0) ? $0 : nil }
    }
}

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }

    var nonEmpty: Wrapped? {
        isNilOrEmpty ? nil : self
    }
}
