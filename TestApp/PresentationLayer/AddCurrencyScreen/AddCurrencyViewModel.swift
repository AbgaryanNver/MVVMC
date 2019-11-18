import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {
    func didTapedCell()
}

class AddCurrencyViewModel: BaseViewModel {
    let context: CoordinatorContext
    var dataSource = Observable<[CountryItem]>([])
    var isLoading = Observable<Bool>(false)
    var isNextButtonActive = Observable<Bool>(false)
    weak var flowDelegate: AddCurrencyCoordinatorDelgate?

    var fromCurrencyKey: CurrencyKey? { context.rateService.key }
    var toCurrencyKeys: [CurrencyKey] { context.rateService.keys }

    init(context: CoordinatorContext, flowDelegate: AddCurrencyCoordinatorDelgate?, title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
        super.init(title: title)
    }

    func setItems() {
        let keys = CurrencyKey.allCases
        let items = keys.map { key -> CountryItem in
            let isMainItem = fromCurrencyKey != nil && fromCurrencyKey == key
            isNextButtonActive.value = !toCurrencyKeys.isEmpty
            let isSelected = toCurrencyKeys.contains(key)
            return CountryItem(key: key, isMainItem: isMainItem, isSelected: isSelected)
        }

        dataSource.value = items
    }

    func nextButtonAction() {
        getRates()
    }

    func didTapedCell(at indexPath: IndexPath) {
        if var item = dataSource.value[safe: indexPath.row] {
            let fromRateMainItem = dataSource.value.first { $0.isMainItem }
            if fromRateMainItem == nil {
                item.isMainItem = true
                dataSource.value[indexPath.row] = item
                return
            } else if !item.isSelected && !item.isMainItem {
                item.isSelected = true
                dataSource.value[indexPath.row] = item
                let toCurrencyKeys = dataSource.value.filter { $0.isSelected }.map { $0.key }
                guard let fromCurrencyKey = fromRateMainItem?.key else {
                    return
                }
                context.rateService.storeState(fromCurrencyKey, toCurrencyKeys)
                getRates()
            }
        }
    }

    private func getRates() {
        if context.rateService.rate.count == toCurrencyKeys.count {
            flowDelegate?.didTapedCell()
            return
        }

        guard let fromCurrencyKey = fromCurrencyKey else {
            return
        }

        let ratePair = CurrencyKey.allCases.map { fromCurrencyKey.rawValue.uppercased() + $0.rawValue.uppercased() }
        isLoading.value = true
        context.restAPI.getRates(ratePair: ratePair) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                self.isLoading.value = false
                switch result {
                    case let .success(response):
                        if let response = response {
                            self.context.rateService.rate = response
                            self.flowDelegate?.didTapedCell()
                        }
                    case let .failure(error):
                        print(error)
                }
            }
        }
    }
}
