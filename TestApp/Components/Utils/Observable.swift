import Foundation

class Observable<T> {
    private var valueChanged: ((T) -> Void)?

    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
        valueChanged = onChange
        if fireNow {
            onChange?(value)
        }
    }

    func removeObserver() {
        valueChanged = nil
    }
}
