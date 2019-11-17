import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {
    func didTapedCell(fromCurrencyKey: CurrencyKey, toCurrencyKeys: [CurrencyKey])
}

class AddCurrencyViewModel: BaseViewModel {
    let context: CoordinatorContext
    weak var flowDelegate: AddCurrencyCoordinatorDelgate?
    var dataSource = Observable<[CountryItem]>([])
    var isLoading = Observable<Bool>(false)
    var isNextButtonActive = Observable<Bool>(false)
    private var rateService = RateService()

    init(context: CoordinatorContext, flowDelegate: AddCurrencyCoordinatorDelgate?, title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
        super.init(title: title)
        setItems()
    }

    func setItems() {
        let keys = CurrencyKey.allCases
        let items = keys.map { key -> CountryItem in
            let isMainItem = rateService.key != nil && rateService.key == key
            isNextButtonActive.value = !rateService.keys.isEmpty
            let isSelected = rateService.keys.contains(key)
            return CountryItem(key: key, isMainItem: isMainItem, isSelected: isSelected)
        }

        dataSource.value = items
    }

    func nextButtonAction() {
        flowDelegate?.didTapedCell(fromCurrencyKey: rateService.key, toCurrencyKeys: rateService.keys)
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
                guard let fromCurrencyKey = fromRateMainItem?.key else {
                    return
                }
                rateService.storeState(fromCurrencyKey, toCurrencyKeys)
                getRates(fromCurrencyKey, toCurrencyKeys)
            }
        }
    }

    private func getRates(_ fromCurrencyKey: CurrencyKey, _ toCurrencyKeys: [CurrencyKey]) {
        let ratePair = toCurrencyKeys.map { fromCurrencyKey.rawValue.uppercased() + $0.rawValue.uppercased() }
        isLoading.value = true
        context.restAPI.getRates(ratePair: ratePair) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading.value = false
            switch result {
                case let .success(response):
                    if let response = response {
                        self.rateService.rate = response
                        DispatchQueue.main.async {
                            self.flowDelegate?.didTapedCell(fromCurrencyKey: fromCurrencyKey, toCurrencyKeys: toCurrencyKeys)
                        }
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }
}
