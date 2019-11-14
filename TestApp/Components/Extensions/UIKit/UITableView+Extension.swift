import Foundation
import UIKit

extension UITableView {
    /// Method for register UITableViewCell subtype with .xib for displaying in UITableView
    ///
    /// - Parameters:
    ///   - cell: UITableViewCell subtype
    ///   - bundle: Bundle where .xib located
    public func register<T: UITableViewCell>(cell: T.Type, bundle: Bundle? = nil) {
        let className = "\(cell)"
        let nib = UINib(nibName: className, bundle: bundle ?? Bundle.main)
        register(nib, forCellReuseIdentifier: className)
    }

    /// Method for register array of UITableViewCell subtypes with .xib for displaying in UITableView
    ///
    /// - Parameters:
    ///   - cells: UITableViewCell subtype
    ///   - bundle: Bundle where .xib located
    public func register<T: UITableViewCell>(cells: [T.Type], bundle: Bundle? = nil) {
        cells.forEach { register(cell: $0, bundle: bundle ?? Bundle.main) }
    }

    // Method for register from array of TableViewItem for displaying in UITableView
    ///
    /// - Parameters:
    ///   - dataSource: array of TableViewItem

    func register(with dataSource: [TableViewItem]) {
        dataSource.forEach { item in
            register(item.cellClassIdentifier, forCellReuseIdentifier: "\(item.cellClassIdentifier)")
        }
    }

    func lock() {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.75
        }
    }

    func unlock() {
        isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
}
