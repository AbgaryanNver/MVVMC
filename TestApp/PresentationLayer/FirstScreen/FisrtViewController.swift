import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func addCurrencyAction()
}

class FirstViewController: UIViewController {
    weak var flowDelegate: AppCoordinatorDelegate?

    @IBAction private func addCurrencyAction(_: UIButton) {
        flowDelegate?.addCurrencyAction()
    }
}
