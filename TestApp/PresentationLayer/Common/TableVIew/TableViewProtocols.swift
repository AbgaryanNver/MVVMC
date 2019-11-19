import UIKit

protocol TableViewCell: AnyObject {
    func configure(with item: TableViewItem)
}

protocol TableViewItem {
    var cellClassIdentifier: AnyClass { get }
}
