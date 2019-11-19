// swiftlint:disable all
@testable import TestApp

class TimeServiceProtocolMock: TimeServiceProtocol {
    // MARK: - init

    var initDurationReceivedDuration: Float?
    var initDurationReceivedInvocations: [Float] = []
    var initDurationClosure: ((Float) -> Void)?
    required init(duration: Float) {
        initDurationReceivedDuration = duration
        initDurationClosure?(duration)
    }

    // MARK: - startTime

    var startTimeOutputCallsCount = 0
    var startTimeOutputCalled: Bool {
        startTimeOutputCallsCount > 0
    }

    var startTimeOutputReceivedOutput: TimeServiceOutputProtocol?
    var startTimeOutputReceivedInvocations: [TimeServiceOutputProtocol] = []
    var startTimeOutputClosure: ((TimeServiceOutputProtocol) -> Void)?

    func startTime(output: TimeServiceOutputProtocol) {
        startTimeOutputCallsCount += 1
        startTimeOutputReceivedOutput = output
        startTimeOutputClosure?(output)
    }

    // MARK: - stopTime

    var stopTimeCallsCount = 0
    var stopTimeCalled: Bool {
        stopTimeCallsCount > 0
    }

    var stopTimeClosure: (() -> Void)?

    func stopTime() {
        stopTimeCallsCount += 1
        stopTimeClosure?()
    }
}
