import Foundation

protocol AddCurrencyCoordinatorDelgate: AnyObject {
    func didTapedCell(fromCountry: Country, toCountries: [Country])
}

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
                let toCountries = dataSource.value.filter { $0.isSelected }.map { $0.country }
                flowDelegate?.didTapedCell(fromCountry: fromRateMainItem!.country, toCountries: toCountries)
            }
        }
    }
}
