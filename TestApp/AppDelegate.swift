import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let context = CoordinatorContext(restAPI: APIProvider())
        appCoordinator = AppCoordinator(context: context, window: window)
        appCoordinator?.start(animated: true)
        return true
    }
}
