import Foundation

class CoordinatorContext {
    var restAPI: APIProvider
    var rateService: RateService

    init(restAPI: APIProvider, rateService: RateService = RateService()) {
        self.restAPI = restAPI
        self.rateService = rateService
    }
}
