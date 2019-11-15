import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {}

class AddCurrencyViewModel: BaseViewModel {
    weak var flowDelegate: AddCurrencyCoordinatorDelgate?
    lazy var dataSource: Observable<[CountryItem]> = {
        let items = Countrys.allCountrys.map { country -> CountryItem in
            CountryItem(country: country)
        }
        return Observable<[CountryItem]>(items)
    }()

    init(flowDelegate: AddCurrencyCoordinatorDelgate?, title: String = "") {
        self.flowDelegate = flowDelegate
        super.init(title: title)
    }
}
