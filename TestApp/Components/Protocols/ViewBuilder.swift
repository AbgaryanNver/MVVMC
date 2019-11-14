import UIKit

/// ```
/// class CustomView: UIView {
///    private  let label = UILabel {
///         $0.textAlignment = .center
///     }
///
///     private lazy var tableView = UITableView {
///         $0.dataSource = self
///     }
/// }
/// ```
protocol ViewBuilder: AnyObject {}

extension UIView: ViewBuilder {}

extension ViewBuilder where Self: UIView {
    init(builder: (Self) -> Void) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        builder(self)
    }
}
