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
        let isPreSaved = false
        if isPreSaved {
            // push(firstViewController, animated: false)
        } else {
            let storyboard = UIStoryboard(storyboard: .first)
            let firstViewController: FirstViewController = storyboard.instantiateViewController()
            firstViewController.flowDelegate = self
            firstViewController.modalPresentationStyle = .overFullScreen
            present(firstViewController, animated: false)
        }
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func addCurrencyAction() {}
}
