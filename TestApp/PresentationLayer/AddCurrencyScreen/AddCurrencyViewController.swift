import UIKit

class AddCurrencyViewController: BaseViewController<AddCurrencyViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private lazy var tableView = UITableView()

    private lazy var nextBarButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonAction))

    private lazy var indicatorView = UIActivityIndicatorView {
        $0.style = .gray
        $0.hidesWhenStopped = true
    }

    private lazy var indicatorButton: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: indicatorView)
        return button
    }()

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .red
        navigationItem.rightBarButtonItem = nextBarButton
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
        viewModel.setItems()
        navigationItem.rightBarButtonItem = nextBarButton
    }

    override func bind(viewModel _: AddCurrencyViewModel) {
        super.bind(viewModel: viewModel)
        viewModel.dataSource.addObserver { [weak self] items in
            self?.setDataSourceForTableView(items)
        }

        viewModel.isLoading.addObserver { [weak self] isLoading in
            self?.tableView.isUserInteractionEnabled = !isLoading
            if isLoading {
                self?.indicatorView.startAnimating()
                self?.navigationItem.rightBarButtonItem = self?.indicatorButton
            }
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
