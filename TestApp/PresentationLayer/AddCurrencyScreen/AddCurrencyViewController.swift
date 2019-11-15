import UIKit

class AddCurrencyViewController: BaseViewController<AddCurrencyViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private let tableView = UITableView()

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .red
        tableViewDataProvider.configure(tableView: tableView)
        view.addSubview(tableView)
        tableView.makeAnchors {
            $0.edges.equalToSuperview()
        }
    }

    override func bind(viewModel _: AddCurrencyViewModel) {
        viewModel.dataSource.addObserver { [weak self] items in
            self?.setDataSourceForTableView(items)
        }
    }

    private func setDataSourceForTableView(_ dataSource: [TableViewItem]) {
        tableViewDataProvider.dataSource = dataSource
    }

    func updateCell(indexPath: IndexPath) {
        tableViewDataProvider.updateCell(indexPath: indexPath)
    }
}
