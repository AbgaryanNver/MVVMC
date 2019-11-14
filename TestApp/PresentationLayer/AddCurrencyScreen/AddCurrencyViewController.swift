import UIKit

class AddCurrencyViewController: BaseViewController<AddCurrencyViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private let tableView = UITableView()

    func setDataSourceForTableView(_ dataSource: [TableViewItem]) {
        tableViewDataProvider.dataSource = dataSource
    }

    func updateCell(indexPath: IndexPath) {
        tableViewDataProvider.updateCell(indexPath: indexPath)
    }
}
