import UIKit

class AppCoordinator: NavigationCoordinator {
    let window: UIWindow?
    private let navigationController = BaseNavigationVC()

    init(context: CoordinatorContext, window: UIWindow?) {
        self.window = window
        super.init(context: context, root: navigationController)
    }

    override func start(animated _: Bool) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let storyboard = UIStoryboard(storyboard: .first)
        let firstViewController: FirstViewController = storyboard.instantiateViewController()
        firstViewController.flowDelegate = self
        push(firstViewController, animated: false)
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func addCurrencyAction() {
        let addcurrencyCoordinator = AddCurrencyCoordinator(context: context, root: navigationController)
        addcurrencyCoordinator.start(animated: true)
    }
}
