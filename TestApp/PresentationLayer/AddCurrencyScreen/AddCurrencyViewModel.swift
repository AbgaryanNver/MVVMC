import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {
    func didTapedCell()
}

class AddCurrencyViewModel: BaseViewModel {
    let context: CoordinatorContext
    let allKeys: [CurrencyKey]

    var dataSource = Observable<[TableViewItem]>([])
    var isLoading = Observable<Bool>(false)
    var isNextButtonActive = Observable<Bool>(false)
    weak var flowDelegate: AddCurrencyCoordinatorDelgate?

    var fromCurrencyKey: CurrencyKey? { context.rateService.key }
    var toCurrencyKeys: [CurrencyKey] { context.rateService.keys }

    init(context: CoordinatorContext, flowDelegate: AddCurrencyCoordinatorDelgate?, allKeys: [CurrencyKey] = CurrencyKey.allCases, title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
        self.allKeys = allKeys
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
        if let item = dataSource.value[safe: indexPath.row] as? CountryItem {
            context.rateService.storeState(item.key)
            setItems()
            getRates()
        }
    }

    private func getRates() {
        guard let fromCurrencyKey = fromCurrencyKey, !toCurrencyKeys.isEmpty else {
            return
        }
        flowDelegate?.didTapedCell()
//        if context.rateService.rate.count == toCurrencyKeys.count {
//
//            return
//        }
//
//        let ratePair = CurrencyKey.allCases.map { fromCurrencyKey.keyName + $0.keyName }
//        isLoading.value = true
//        context.restAPI.getRates(ratePair: ratePair) { [weak self] result in
//            DispatchQueue.main.async {
//                guard let self = self else {
//                    return
//                }
//                self.isLoading.value = false
//                switch result {
//                    case let .success(response):
//                        if let response = response {
//                            self.context.rateService.rate = response
//                            self.flowDelegate?.didTapedCell()
//                        }
//                    case let .failure(error):
//                        print(error)
//                }
//            }
//        }
    }
}
