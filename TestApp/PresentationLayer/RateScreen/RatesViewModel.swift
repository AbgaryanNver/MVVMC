import Foundation

protocol RatesCoordinatorDelegate: AnyObject {
    func addButtonAction()
}

class RatesViewModel: BaseViewModel {
    let fromCountry: Country
    let toCountries: [Country]
    let timeService: TimeServiceProtocol

    var rateItems = Observable<[TableViewItem]>([])
    weak var flowDelegate: RatesCoordinatorDelegate?

    private let context: CoordinatorContext

    init(context: CoordinatorContext,
         flowDelegate: RatesCoordinatorDelegate?,
         fromCountry: Country, toCountries: [Country],
         timeService: TimeServiceProtocol = TimeService(duration: 1),
         title: String = "") {
        self.flowDelegate = flowDelegate
        self.context = context
        self.fromCountry = fromCountry
        self.toCountries = toCountries
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
        let ratePair = toCountries.map { fromCountry.cur + $0.cur }
        context.restAPI.getRates(ratePair: ratePair) { [weak self] result in
            switch result {
                case let .success(response):
                    if let response = response {
                        self?.setItems(response)
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }

    private func setItems(_ pairs: [String: Double]) {
        rateItems.value = pairs.map { key, value in
            RateItem(formCountry: Country(cur: key, currency: key, imageName: ""),
                     toCountry: Country(cur: key, currency: key, imageName: ""),
                     rateValue: "\(value)")
        }
    }
}

extension RatesViewModel: TimeServiceOutputProtocol {
    func didTriggerTimer() {
        getRates()
    }
}
