// swiftlint:disable all
class APIProviderMock: APIProvider {
    // MARK: - getRates

    var getRatesRatePairCompletionCallsCount = 0
    var getRatesRatePairCompletionCalled: Bool {
        getRatesRatePairCompletionCallsCount > 0
    }

    var getRatesRatePairCompletionReceivedArguments: (ratePair: [String], completion: (Result<[String: Double]?, Error>) -> Void)?
    var getRatesRatePairCompletionReceivedInvocations: [(ratePair: [String], completion: (Result<[String: Double]?, Error>) -> Void)] = []
    var getRatesRatePairCompletionClosure: (([String], @escaping (Result<[String: Double]?, Error>) -> Void) -> Void)?

    func getRates(ratePair: [String], completion: @escaping (Result<[String: Double]?, Error>) -> Void) {
        getRatesRatePairCompletionCallsCount += 1
        getRatesRatePairCompletionReceivedArguments = (ratePair: ratePair, completion: completion)
        getRatesRatePairCompletionClosure?(ratePair, completion)
    }
}
