import UIKit

extension UIStoryboard {
    /// The uniform place where we state all the storyboard we have in our application

    enum Storyboard: String {
        case first
        case rates
        case addCurrency

        var filename: String {
            rawValue.capitalized
        }
    }

    // MARK: - Convenience Initializers

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }

    // MARK: - Class Functions

    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        UIStoryboard(name: storyboard.filename, bundle: bundle)
    }

    // MARK: - View Controller Instantiation from Generics

    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}
