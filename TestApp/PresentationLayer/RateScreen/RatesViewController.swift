import UIKit

class RatesViewController: BaseViewController<RatesViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopTime()
    }

    override func setupUI() {
        super.setupUI()
        tableViewDataProvider.configure(tableView: tableView, didRemoveItem: { [weak self] item in
            self?.viewModel.didRemove(item)
        })
        view.addSubview(tableView)
        tableView.makeAnchors {
            $0.edges.equalToSuperview()
        }
    }

    override func bind(viewModel: RatesViewModel) {
        super.bind(viewModel: viewModel)
        viewModel.rateItems.addObserver { [weak self] rateItems in
            self?.tableViewDataProvider.dataSource = rateItems
        }
    }
}
