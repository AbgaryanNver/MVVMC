import UIKit

// sourcery:begin: AutoMockable
protocol TableViewCell: AnyObject {
    func configure(with item: TableViewItem)
}

protocol TableViewItem {
    var cellClassIdentifier: AnyClass { get }
}
