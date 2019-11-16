import UIKit

class FirstViewController: UIViewController {
    weak var flowDelegate: AppCoordinatorDelegate?

    @IBAction private func addCurrencyAction(_: UIButton) {
        flowDelegate?.addCurrencyAction()
    }
}
