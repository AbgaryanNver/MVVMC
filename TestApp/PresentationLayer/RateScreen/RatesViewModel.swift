import Foundation

protocol RatesCoordinatorDelegate: AnyObject {
    func addButtonAction()
}

class RatesViewModel: BaseViewModel {
    let fromCurrencyKey: CurrencyKey
    let toCurrencyKeys: [CurrencyKey]
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
        getRates()
        timeService.startTime(output: self)
    }

    func stopTime() {
        timeService.stopTime()
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
                        self.setItems(self.rateService.rate)
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }

    private func setItems(_: [String: Double]) {
        let items = rateService.convertor.reateItems
        let sortedItems = items.compactMap { $0 }.sorted { $0.toCurrencyKey.rawValue < $1.toCurrencyKey.rawValue }
        rateItems.value = sortedItems
    }
}

extension RatesViewModel: TimeServiceOutputProtocol {
    func didTriggerTimer() {
        getRates()
    }
}
