import Foundation

// sourcery:begin: AutoMockable
protocol CurrencyCoordinatorDelgate: AnyObject {
    func didTapedCell()
}

class CurrencyViewModel: BaseViewModel {
    let context: CoordinatorContext
    let allKeys: [CurrencyKey]

    var dataSource = Observable<[TableViewItem]>([])
    var isLoading = Observable<Bool>(false)
    var isNextButtonActive = Observable<Bool>(false)
    weak var flowDelegate: CurrencyCoordinatorDelgate?

    var fromCurrencyKey: CurrencyKey? { context.rateService.key }
    var toCurrencyKeys: [CurrencyKey] { context.rateService.keys }

    init(context: CoordinatorContext, flowDelegate: CurrencyCoordinatorDelgate?, allKeys: [CurrencyKey] = CurrencyKey.allCases, title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
        self.allKeys = allKeys
        super.init(title: title)
    }

    func setItems(_ fromKey: CurrencyKey?, _ toKeys: [CurrencyKey]) {
        let keys = CurrencyKey.allCases
        let items = keys.map { key -> CountryItem in
            let isMainItem = fromKey != nil && fromKey == key
            isNextButtonActive.value = !toKeys.isEmpty
            let isSelected = toKeys.contains(key)
            return CountryItem(key: key, isMainItem: isMainItem, isSelected: isSelected)
        }

        dataSource.value = items
    }

    func nextButtonAction() {
        goNext(fromCurrencyKey, toCurrencyKeys)
    }

    func didTapedCell(at indexPath: IndexPath) {
        if let item = dataSource.value[safe: indexPath.row] as? CountryItem {
            context.rateService.storeState(item.key)
            setItems(fromCurrencyKey, toCurrencyKeys)
            goNext(fromCurrencyKey, toCurrencyKeys)
        }
    }

    func viewWillAppear() {
        setItems(fromCurrencyKey, toCurrencyKeys)
    }

    func goNext(_ fromCurrencyKey: CurrencyKey?, _ toCurrencyKeys: [CurrencyKey]) {
        if fromCurrencyKey != nil, !toCurrencyKeys.isEmpty {
            flowDelegate?.didTapedCell()
        }
    }
}
