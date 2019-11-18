import UIKit

class AddCurrencyCoordinator: NavigationCoordinator {
    override func start(animated _: Bool) {
        let viewModel = AddCurrencyViewModel(context: context, flowDelegate: self, title: "Add Currency")
        let viewController = AddCurrencyViewController(with: viewModel)
        push(viewController, animated: true)
    }
}

extension AddCurrencyCoordinator: AddCurrencyCoordinatorDelgate {
    func didTapedCell() {
        let coordinator = RatesCoordinator(coordinator: self)
        coordinator.start(animated: true)
    }
}
