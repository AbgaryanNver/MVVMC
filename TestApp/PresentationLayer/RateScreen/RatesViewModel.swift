import Foundation

class RatesViewModel: BaseViewModel {
    let timeService: TimeServiceProtocol
    let rateService = RateService()

    var fromCurrencyKey: CurrencyKey? { rateService.key }
    var toCurrencyKeys: [CurrencyKey] { rateService.keys }

    var rateItems = Observable<[TableViewItem]>([])

    private let context: CoordinatorContext

    init(context: CoordinatorContext,
         timeService: TimeServiceProtocol = TimeService(duration: 1),
         title: String = "") {
        self.context = context
        self.timeService = timeService
        super.init(title: title)
    }

    func viewDidLoad() {
        setItems()
        timeService.startTime(output: self)
    }

    func stopTime() {
        timeService.stopTime()
    }

    func didRemove(_ item: TableViewItem) {
        if let rateItem = item as? RateItem {
            rateService.removeItem(by: rateItem.toCurrencyKey)
        }
    }

    private func getRates() {
        guard let fromCurrencyKey = fromCurrencyKey else {
            return
        }

        let ratePair = toCurrencyKeys.map { fromCurrencyKey.rawValue.uppercased() + $0.rawValue.uppercased() }

        context.restAPI.getRates(ratePair: ratePair) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
                case let .success(response):
                    if let response = response {
                        self.rateService.rate = response
                        self.setItems()
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }

    private func setItems() {
        let items = rateService.getItems()
        rateItems.value = items.compactMap { $0 }
    }
}

extension RatesViewModel: TimeServiceOutputProtocol {
    func didTriggerTimer() {
        getRates()
    }
}
