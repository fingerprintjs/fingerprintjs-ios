import Foundation

public protocol Subsystem {
    associatedtype ValueType: RawPointerConvertible

    var flags: [Int32] { get }
}

struct SystemControlValueDefinition<T: RawPointerConvertible> {
    func load(_ from: SystemControl) -> T? {
        return try? from.getSystemValue(.custom(flags))
    }

    var flags: [Int32]
}

public struct Kernel: Subsystem {
    let systemControl = SystemControl()

    public typealias ValueType = Int32

    public var flags: [Int32] = [CTL_KERN]

    public var boottime: timeval? {
        let boottimeDefinition = SystemControlValueDefinition<timeval>(flags: [CTL_KERN, KERN_BOOTTIME])
        return boottimeDefinition.load(systemControl)
    }

    public struct Hostname: Subsystem {
        let parent = Kernel()

        public init() {}

        public typealias ValueType = String

        public var flags: [Int32] = Kernel().flags + [KERN_HOSTNAME]
    }
}

struct Network: Subsystem {
    typealias ValueType = Int32

    var flags: [Int32] = [CTL_NET]

    /*
    struct TCPStats: Subsystem {
        typealias ValueType = tcpstat

        var flags: [Int32] = Network().flags + [2, 6, 4]
    }
     */

    /*
    struct UDPStats: Subsystem {
        // typealias ValueType = udpstat

        var flags: [Int32] = Network().flags + [2, 17, 2]
    }
     */
}
