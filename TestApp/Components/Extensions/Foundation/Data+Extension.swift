import Foundation

extension Data {
    var prettyJSON: String {
        if let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyString = String(data: jsonData, encoding: .utf8) {
            return prettyString
        }
        return "Data \(description) is not JSON"
    }
}
