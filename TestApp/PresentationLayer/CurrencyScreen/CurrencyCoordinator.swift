import UIKit

class CurrencyCoordinator: NavigationCoordinator {
    override func start(animated: Bool) {
        let viewModel = CurrencyViewModel(context: context, flowDelegate: self, title: "Add Currency")
        let viewController = CurrencyViewController(with: viewModel)
        push(viewController, animated: animated)
    }
}

extension CurrencyCoordinator: CurrencyCoordinatorDelgate {
    func didTapedCell() {
        let coordinator = RatesCoordinator(coordinator: self)
        coordinator.start(animated: true)
    }
}
