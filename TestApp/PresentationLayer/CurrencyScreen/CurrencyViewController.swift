import UIKit

class CurrencyViewController: BaseViewController<CurrencyViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private lazy var tableView = UITableView()
    private lazy var nextBarButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonAction))
    private lazy var backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .red
        navigationItem.rightBarButtonItem = nextBarButton
        navigationItem.leftBarButtonItem = backButton
        nextBarButton.isEnabled = false
        tableViewDataProvider.configure(tableView: tableView, onTapCell: { [weak self] indexPath in
            self?.viewModel.didTapedCell(at: indexPath)
        })

        view.addSubview(tableView)
        tableView.makeAnchors {
            $0.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        navigationItem.rightBarButtonItem = nextBarButton
    }

    override func bind(viewModel _: CurrencyViewModel) {
        super.bind(viewModel: viewModel)
        viewModel.dataSource.addObserver { [weak self] items in
            self?.setDataSourceForTableView(items)
        }

        viewModel.isNextButtonActive.addObserver { [weak self] isNextButtonActive in
            self?.nextBarButton.isEnabled = isNextButtonActive
        }
    }

    private func setDataSourceForTableView(_ dataSource: [TableViewItem]) {
        tableViewDataProvider.dataSource = dataSource
    }

    @objc private func nextButtonAction() {
        viewModel.nextButtonAction()
    }
}
