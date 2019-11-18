import Foundation

protocol RatesCoordinatorDelegate: AnyObject {
    func addButtonAction()
}

class RatesViewModel: BaseViewModel {
    lazy var fromCurrencyKey: CurrencyKey = rateService.key!
    lazy var toCurrencyKeys: [CurrencyKey] = rateService.keys
    let timeService: TimeServiceProtocol
    let rateService = RateService()

    var rateItems = Observable<[TableViewItem]>([])
    weak var flowDelegate: RatesCoordinatorDelegate?

    private let context: CoordinatorContext

    init(context: CoordinatorContext,
         flowDelegate: RatesCoordinatorDelegate?,
         fromCurrencyKey _: CurrencyKey,
         toCurrencyKeys _: [CurrencyKey],
         timeService: TimeServiceProtocol = TimeService(duration: 11),
         title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
//        self.fromCurrencyKey = fromCurrencyKey
//        self.toCurrencyKeys = toCurrencyKeys
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
                rateService.rate = [:]
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
        rateItems.value = items.compactMap { $0 }
    }
}

extension RatesViewModel: TimeServiceOutputProtocol {
    func didTriggerTimer() {
        getRates()
    }
}
