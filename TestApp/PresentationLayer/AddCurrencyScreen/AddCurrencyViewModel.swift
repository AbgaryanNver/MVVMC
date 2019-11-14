import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {}

class AddCurrencyViewModel: BaseViewModel {
    weak var flowDelegate: AddCurrencyCoordinatorDelgate?

    init(flowDelegate: AddCurrencyCoordinatorDelgate?, title: String = "") {
        self.flowDelegate = flowDelegate
        super.init(title: title)
    }
}
