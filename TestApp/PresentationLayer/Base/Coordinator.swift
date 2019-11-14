import UIKit

private enum CoordinatorKey {
    static var coordinator = 0
}

/**
 Modal presentation Coordinator
 ```
 class PhotoPreviewCoordinator: Coordinator {
    private let photo: UIImage

     init(coordinator: Coordinator, photo: UIImage) {
        self.photo = photo
        super.init(coordinator: coordinator)
     }

    override func start(animated: Bool) {
        let controller = PhotoPreviewController(photo: photo)
        present(controller, animated: animated)
     }
 }

 // Start new flow from current flow
 PhotoPreviewCoordinator(coordinator: self, photo: image)
    .start(animated: true)
 ```
 */
class Coordinator {
    let context: CoordinatorContext
    private weak var controller: UIViewController?

    init(context: CoordinatorContext, root controller: UIViewController) {
        self.context = context
        self.controller = controller
    }

    init(coordinator: Coordinator) {
        context = coordinator.context
        controller = coordinator.controller
    }

    deinit {
        print("\(self) has deinited")
    }

    // MARK: -

    func start(animated _: Bool) {}

    // MARK: -

    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        controller?.present(present(presentable), animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        controller?.dismiss(animated: animated, completion: completion)
    }

    // MARK: - Private

    fileprivate func present(_ presentable: Presentable) -> UIViewController {
        let controller = presentable.present()
        controller.setAssociatedObject(value: self, key: &CoordinatorKey.coordinator, policy: .retainNonatomic)
        return controller
    }

    fileprivate func transaction(with completion: (() -> Void)?, action: () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        action()
        CATransaction.commit()
    }
}

/**
 ```
 //  Start new Navigation Flow
 class UsersCoordinator: NavigationCoordinator, Presentable {
    private let navigationVC = UINavigationController()

    init(context: CoordinatorContext) {
        super.init(coordinator: Coordinator, root: navigationVC)
        push(UsersVC(), animated: false)
     }

     func present() -> UIViewController {
        return navigationVC
     }

     func didSelectUser(_ user: User) {
         UserDrtailsCoordinator(flow: self, user: user)
            .start(animated: true)
     }
 }

 // OR reuse existing Navigation Flow
 class UserDetailsCoordinator: NavigationCoordinator {
    private let user: User

     init(coordinator: NavigationCoordinator, user: User)
        self.user = user
        super.init(coordinator: coordinator)
     }

     func start(animated: Bool) {
        push(UserDetailsVC(user: user), animated: animated)
     }
 }
 ```
 */
class NavigationCoordinator: Coordinator {
    private let rootController: UINavigationController

    init(context: CoordinatorContext, root controller: UINavigationController) {
        rootController = controller
        super.init(context: context, root: controller)
    }

    init(coordinator: NavigationCoordinator) {
        rootController = coordinator.rootController
        super.init(coordinator: coordinator)
    }

    // MARK: - Overrides

    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: animated) {
            self.set([], animated: false, completion: completion)
        }
    }

    // MARK: -

    func push(_ presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            rootController.pushViewController(present(presentable), animated: animated)
        }
    }

    func replace(with presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            rootController.setViewControllers(rootController.viewControllers.dropLast() + [present(presentable)],
                                              animated: animated)
        }
    }

    func set(_ presentables: [Presentable], animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            rootController.setViewControllers(presentables.map(present),
                                              animated: animated)
        }
    }

    func pop(animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            rootController.popViewController(animated: animated)
        }
    }

    func pop(to presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            rootController.popToViewController(presentable.present(), animated: animated)
        }
    }

    func popToRoot(animated: Bool, completion: (() -> Void)?) {
        transaction(with: completion) {
            rootController.popToRootViewController(animated: animated)
        }
    }
}

class TabsCoordinator: Coordinator {
    private let rootController: UITabBarController

    init(context: CoordinatorContext, root controller: UITabBarController) {
        rootController = controller
        super.init(context: context, root: controller)
    }

    init(coordinator: TabsCoordinator) {
        rootController = coordinator.rootController
        super.init(coordinator: coordinator)
    }

    // MARK: - Overrides

    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: animated) {
            self.setTabs([], animated: false, completion: completion)
        }
    }

    // MARK: -

    func setTabs(_ tabs: [TabPresentable], animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            let controllers: [UIViewController] = tabs.map { tab in
                let controller = present(tab)
                controller.tabBarItem = tab.presentableTabBarItem
                return controller
            }
            rootController.setViewControllers(controllers, animated: animated)
        }
    }

    var selectedIndex: Int {
        get {
            return rootController.selectedIndex
        }
        set {
            rootController.selectedIndex = newValue
        }
    }
}
