import Foundation

struct APIError: Error, Codable {
    let message: String
    let description: String?
}

struct ConectionError: Error {
    let message: String
}

struct UnknownParseError: Error {}
