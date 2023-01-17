public protocol SystemControlValueDefining {
    associatedtype ValueType: RawPointerConvertible

    var flags: [Int32] { get }
}

public struct SystemControlValueDefinition<T: RawPointerConvertible>: SystemControlValueDefining {
    public typealias ValueType = T

    public let flags: [Int32]

    public init(flags: [Int32]) {
        self.flags = flags
    }
}
