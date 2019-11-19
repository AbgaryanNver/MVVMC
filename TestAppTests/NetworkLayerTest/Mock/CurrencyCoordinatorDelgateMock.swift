@testable import TestApp

final class CurrencyCoordinatorDelgateMock: CurrencyCoordinatorDelgate {
    // MARK: - didTapedCell

    var didTapedCellCallsCount = 0
    var didTapedCellCalled: Bool {
        didTapedCellCallsCount > 0
    }

    var didTapedCellClosure: (() -> Void)?

    func didTapedCell() {
        didTapedCellCallsCount += 1
        didTapedCellClosure?()
    }
}
