import UIKit

class RatesCoordinator: NavigationCoordinator {
    override func start(animated _: Bool) {
        let ratesViewModel = RatesViewModel(context: context, title: "Rates & converter")
        let ratesViewController = RatesViewController(with: ratesViewModel)
        push(ratesViewController, animated: true)
    }
}
