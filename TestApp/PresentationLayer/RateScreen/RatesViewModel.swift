import Foundation

protocol RatesCoordinatorDelegate: AnyObject {
    func addButtonAction()
}

class RatesViewModel: BaseViewModel {
    let fromCurrencyKey: CurrencyKey
    var toCurrencyKeys: [CurrencyKey]
    let timeService: TimeServiceProtocol
    let rateService = RateService()

    var rateItems = Observable<[TableViewItem]>([])
    weak var flowDelegate: RatesCoordinatorDelegate?

    private let context: CoordinatorContext

    init(context: CoordinatorContext,
         flowDelegate: RatesCoordinatorDelegate?,
         fromCurrencyKey: CurrencyKey,
         toCurrencyKeys: [CurrencyKey],
         timeService: TimeServiceProtocol = TimeService(duration: 1),
         title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
        self.fromCurrencyKey = fromCurrencyKey
        self.toCurrencyKeys = toCurrencyKeys
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
            toCurrencyKeys.removeAll { currencyKey -> Bool in
                currencyKey == rateItem.toCurrencyKey
            }
            rateService.keys = toCurrencyKeys
            if toCurrencyKeys.isEmpty {
                rateService.key = nil
            }
        }
    }

    private func getRates() {
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
        let sortedItems = items.compactMap { $0 }.sorted { $0.toCurrencyKey.rawValue < $1.toCurrencyKey.rawValue }
        rateItems.value = sortedItems
    }
}

extension RatesViewModel: TimeServiceOutputProtocol {
    func didTriggerTimer() {
        getRates()
    }
}
