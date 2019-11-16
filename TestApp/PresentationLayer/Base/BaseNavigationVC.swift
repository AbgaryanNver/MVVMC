import UIKit

@objc protocol NavigationBarAppearance: AnyObject {
    var prefersNavigationBarHidden: Bool { get }
}

extension UIViewController: NavigationBarAppearance {
    var prefersNavigationBarHidden: Bool {
        false
    }
}

class BaseNavigationVC: UINavigationController {
    var navigationBarColor: UIColor? = .white {
        didSet {
            guard isViewLoaded else {
                return
            }
            updateNavigationBarColor()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: -

    override func loadView() {
        super.loadView()
        view.tintColor = .black
        edgesForExtendedLayout = .all
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        updateNavigationBarColor()
        delegate = self
    }

    private func updateNavigationBarColor() {
        if let color = navigationBarColor {
            navigationBar.barTintColor = color
        } else {
            navigationBar.barTintColor = nil
        }
    }
}

extension BaseNavigationVC: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        setNavigationBarHidden(viewController.prefersNavigationBarHidden, animated: animated)
    }
}
