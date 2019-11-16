import UIKit

class RatesCoordinator: NavigationCoordinator {
    let fromCountry: Country
    let toCountries: [Country]

    init(coordinator: NavigationCoordinator, fromCountry: Country, toCountries: [Country]) {
        self.fromCountry = fromCountry
        self.toCountries = toCountries
        super.init(coordinator: coordinator)
    }

    override func start(animated _: Bool) {
        let ratesViewModel = RatesViewModel(context: context, flowDelegate: self, fromCountry: fromCountry, toCountries: toCountries, title: "Rates & converter")
        let ratesViewController = RatesViewController(with: ratesViewModel)
        push(ratesViewController, animated: true)
    }
}

extension RatesCoordinator: RatesCoordinatorDelegate {
    func addButtonAction() {
        pop(animated: true)
    }
}
