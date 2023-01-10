protocol Subsystem {
    associatedtype ValueType

    var flags: [Int32] { get }
}

struct Kernel: Subsystem {
    typealias ValueType = Int32

    var flags: [Int32] = [CTL_KERN]

    struct Boottime: Subsystem {
        let parent = Kernel()

        typealias ValueType = timeval

        var flags: [Int32] = Kernel().flags + [KERN_BOOTTIME]
    }
}

func getSystemValueFrom<T: Subsystem>(_ subsystem: T) {
}
