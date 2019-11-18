import Foundation
import UIKit

extension UITableView {
    // Method for register from array of TableViewItem for displaying in UITableView
    ///
    /// - Parameters:
    ///   - dataSource: array of TableViewItem

    func register(with dataSource: [TableViewItem]) {
        dataSource.forEach { item in
            register(item.cellClassIdentifier, forCellReuseIdentifier: "\(item.cellClassIdentifier)")
        }
    }
}
