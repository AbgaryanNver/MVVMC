import UIKit

class CurrencyCoordinator: NavigationCoordinator {
    override func start(animated _: Bool) {
        let viewModel = CurrencyViewModel(context: context, flowDelegate: self, title: "Add Currency")
        let viewController = CurrencyViewController(with: viewModel)
        push(viewController, animated: true)
    }
}

extension CurrencyCoordinator: CurrencyCoordinatorDelgate {
    func didTapedCell() {
        let coordinator = RatesCoordinator(coordinator: self)
        coordinator.start(animated: true)
    }
}
