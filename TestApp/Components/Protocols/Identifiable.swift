import Foundation

/// A class of types whose instances hold the value of an entity with stable identity.
/// - Tag: Identifiable
protocol Identifiable {
    /// A type representing the stable identity of the entity associated with `self`.
    associatedtype IDType: Hashable

    /// The stable identity of the entity associated with `self`.
    var id: IDType { get }
}
