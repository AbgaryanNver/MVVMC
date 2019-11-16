import UIKit

class AddCurrencyViewController: BaseViewController<AddCurrencyViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private let tableView = UITableView()

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .red
        tableViewDataProvider.configure(tableView: tableView) { [weak self] indexPath in
            self?.viewModel.didTapedCell(at: indexPath)
        }
        view.addSubview(tableView)
        tableView.makeAnchors {
            $0.edges.equalToSuperview()
        }
    }

    override func bind(viewModel _: AddCurrencyViewModel) {
        super.bind(viewModel: viewModel)
        viewModel.dataSource.addObserver { [weak self] items in
            self?.setDataSourceForTableView(items)
        }
    }

    private func setDataSourceForTableView(_ dataSource: [TableViewItem]) {
        tableViewDataProvider.dataSource = dataSource
    }

    private func updateCell(at indexPath: IndexPath) {
        tableViewDataProvider.updateCell(indexPath: indexPath)
    }
}
