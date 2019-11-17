import UIKit

class RatesCoordinator: NavigationCoordinator {
    let fromCurrencyKey: CurrencyKey
    let toCurrencyKeys: [CurrencyKey]

    init(coordinator: NavigationCoordinator, fromCurrencyKey: CurrencyKey, toCurrencyKeys: [CurrencyKey]) {
        self.fromCurrencyKey = fromCurrencyKey
        self.toCurrencyKeys = toCurrencyKeys
        super.init(coordinator: coordinator)
    }

    override func start(animated _: Bool) {
        let ratesViewModel = RatesViewModel(context: context,
                                            flowDelegate: self,
                                            fromCurrencyKey: fromCurrencyKey,
                                            toCurrencyKeys: toCurrencyKeys,
                                            title: "Rates & converter")
        let ratesViewController = RatesViewController(with: ratesViewModel)
        push(ratesViewController, animated: true)
    }
}

extension RatesCoordinator: RatesCoordinatorDelegate {
    func addButtonAction() {
        pop(animated: true)
    }
}
