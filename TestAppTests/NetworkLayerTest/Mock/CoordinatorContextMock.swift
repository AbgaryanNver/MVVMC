import Foundation
@testable import TestApp

class CoordinatorContextMock: CoordinatorContext {
    var restAPI: APIProvider
    var rateService: RateService

    init() {
        restAPI = APIProviderMock()
        rateService = RateServiceMock()
    }
}
