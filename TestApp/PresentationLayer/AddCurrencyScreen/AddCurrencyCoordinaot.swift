import UIKit

class AddCurrencyCoordinator: NavigationCoordinator {
    override func start(animated _: Bool) {
        let viewModel = AddCurrencyViewModel(context: context, flowDelegate: self, title: "Add Currency")
        let viewController = AddCurrencyViewController(with: viewModel)
        push(viewController, animated: true)
    }
}

extension AddCurrencyCoordinator: AddCurrencyCoordinatorDelgate {
    func didTapedCell(fromCurrencyKey: CurrencyKey, toCurrencyKeys: [CurrencyKey]) {
        let coordinator = RatesCoordinator(coordinator: self, fromCurrencyKey: fromCurrencyKey, toCurrencyKeys: toCurrencyKeys)
        coordinator.start(animated: true)
    }
}
