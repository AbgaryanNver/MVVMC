import UIKit

class AddCurrencyCoordinator: NavigationCoordinator {
    override func start(animated _: Bool) {
        let viewModel = AddCurrencyViewModel(flowDelegate: self, title: "Add Currency")
        let viewController = AddCurrencyViewController(with: viewModel)
        push(viewController, animated: true)
    }
}

extension AddCurrencyCoordinator: AddCurrencyCoordinatorDelgate {
    func didTapedCell(fromCountry: Country, toCountries: [Country]) {
        let coordinator = RatesCoordinator(coordinator: self, fromCountry: fromCountry, toCountries: toCountries)
        coordinator.start(animated: true)
    }
}
