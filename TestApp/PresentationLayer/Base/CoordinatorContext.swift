import Foundation

class CoordinatorContext {
    var restAPI: APIProvider

    init(restAPI: APIProvider) {
        self.restAPI = restAPI
    }
}
