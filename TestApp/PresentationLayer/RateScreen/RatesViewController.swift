import UIKit

class RatesViewController: BaseViewController<RatesViewModel> {
    private let tableViewDataProvider = TableViewDataProvider()
    private let tableView = UITableView()
//    private lazy var addButton = UIButton {
//        $0.titleLabel?.text = "Add currency pair"
//        $0.titleLabel?.font = UIFont.sfProTextBold16
//        $0.setTitleColor(.systemBlue, for: .normal)
//        $0.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.8), for: .highlighted)
//        $0.setImage(Asset.icPlus, for: .normal)
//    }

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
        tableViewDataProvider.configure(tableView: tableView)
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
