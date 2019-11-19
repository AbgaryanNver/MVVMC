import Foundation

class RatesViewModel: BaseViewModel {
    let timeService: TimeServiceProtocol
    let context: CoordinatorContext

    var rateItems = Observable<[TableViewItem]>([])

    var fromCurrencyKey: CurrencyKey? { context.rateService.key }
    var toCurrencyKeys: [CurrencyKey] { context.rateService.keys }
    var itemsFromRateService: [TableViewItem] { context.rateService.getItems() }

    init(context: CoordinatorContext,
         timeService: TimeServiceProtocol = TimeService(duration: 1),
         title: String = "") {
        self.context = context
        self.timeService = timeService
        super.init(title: title)
    }

    func viewDidLoad() {
        setItems(itemsFromRateService)
        timeService.startTime(output: self)
    }

    func stopTime() {
        timeService.stopTime()
    }

    func didRemove(_ item: TableViewItem) {
        if let rateItem = item as? RateItem {
            context.rateService.removeItem(by: rateItem.toCurrencyKey)
        }
    }

    func setItems(_ items: [TableViewItem]) {
        rateItems.value = items
    }

    func getRates(_ fromCurrencyKey: CurrencyKey?, _ toCurrencyKeys: [CurrencyKey]) {
        guard let fromCurrencyKey = fromCurrencyKey else {
            return
        }

        let ratePair = toCurrencyKeys.map { fromCurrencyKey.keyName + $0.keyName }

        context.restAPI.getRates(ratePair: ratePair) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
                case let .success(response):
                    if let response = response {
                        self.context.rateService.setRate(response)
                        self.setItems(self.itemsFromRateService)
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }
}

extension RatesViewModel: TimeServiceOutputProtocol {
    func didTriggerTimer() {
        getRates(fromCurrencyKey, toCurrencyKeys)
    }
}
