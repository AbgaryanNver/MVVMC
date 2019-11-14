import Foundation

protocol AppCoordinatorDelegate: AnyObject {
    func addCurrencyAction()
}

class FirstViewModel: BaseViewModel {
    weak var flowDelegate: AppCoordinatorDelegate?

    init(flowDelegate: AppCoordinatorDelegate?, title: String = "") {
        self.flowDelegate = flowDelegate
        super.init(title: title)
    }

    func addCurrencyAction() {
        flowDelegate?.addCurrencyAction()
    }
}
