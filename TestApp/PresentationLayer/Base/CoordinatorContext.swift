import Foundation

protocol CoordinatorContext {
    var restAPI: APIProvider { get }
    var rateService: RateService { get set }
}

class CoordinatorContextImpl: CoordinatorContext {
    var restAPI: APIProvider
    var rateService: RateService

    required init(restAPI: APIProvider, rateService: RateService = RateServiceImpl()) {
        self.restAPI = restAPI
        self.rateService = rateService
    }
}
