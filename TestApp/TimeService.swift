import Foundation

// sourcery:begin: AutoMockable
protocol TimeServiceProtocol {
    init(duration: Float)
    func startTime(output: TimeServiceOutputProtocol)
    func stopTime()
}

protocol TimeServiceOutputProtocol {
    func didTriggerTimer()
}

class TimeService: TimeServiceProtocol {
    var timer: Timer?
    var duration: Float = 0.0

    required init(duration: Float) {
        self.duration = duration
    }

    func startTime(output: TimeServiceOutputProtocol) {
        stopTime()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: true) { _ in
            output.didTriggerTimer()
        }
    }

    func stopTime() {
        timer?.invalidate()
    }
}
