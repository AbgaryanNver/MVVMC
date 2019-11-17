import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {
    func didTapedCell(fromCurrencyKey: CurrencyKey, toCurrencyKeys: [CurrencyKey])
}

class AddCurrencyViewModel: BaseViewModel {
    weak var flowDelegate: AddCurrencyCoordinatorDelgate?
    var dataSource = Observable<[CountryItem]>([])
    private var rateService = RateService()

    init(flowDelegate: AddCurrencyCoordinatorDelgate?, title: String = "") {
        self.flowDelegate = flowDelegate
        super.init(title: title)
        setItems()
    }

    func setItems() {
        let keys = CurrencyKey.allCases
        let items = keys.map { key -> CountryItem in
            var isMainItem = rateService.key != nil && rateService.key == key

            let isSelected = rateService.keys.contains(key)
            return CountryItem(key: key, isMainItem: isMainItem, isSelected: isSelected)
        }

        dataSource.value = items
    }

    func didTapedCell(at indexPath: IndexPath) {
        if var item = dataSource.value[safe: indexPath.row] {
            let fromRateMainItem = dataSource.value.first { $0.isMainItem }
            if fromRateMainItem == nil {
                item.isMainItem = true
                dataSource.value[indexPath.row] = item
                return
            } else if !item.isSelected {
                item.isSelected = true
                dataSource.value[indexPath.row] = item
                let toCurrencyKeys = dataSource.value.filter { $0.isSelected }.map { $0.key }
                rateService.storeState(currencyKey: fromRateMainItem!.key, currencyKeys: toCurrencyKeys)
                flowDelegate?.didTapedCell(fromCurrencyKey: fromRateMainItem!.key, toCurrencyKeys: toCurrencyKeys)
            }
        }
    }
}
