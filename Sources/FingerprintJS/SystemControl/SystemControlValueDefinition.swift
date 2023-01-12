import Foundation

protocol SystemControlValueDefining {
    associatedtype ValueType: RawPointerConvertible

    var flags: [Int32] { get }
}

struct SystemControlValueDefinition<T: RawPointerConvertible>: SystemControlValueDefining {
    typealias ValueType = T

    var flags: [Int32]
}
