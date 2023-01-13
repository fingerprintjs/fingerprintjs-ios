import Foundation

public protocol SystemControlValuesRetrieving {
    func getSystemValue<T: SystemControlValueDefining>(_ definition: T) throws -> T.ValueType
}

public struct SystemControl: SystemControlValuesRetrieving {
    public init() {}

    public func getSystemValue<T: SystemControlValueDefining>(_ definition: T) throws -> T.ValueType {
        var size = 0

        var sysctlFlags = definition.flags
        let flagCount = u_int(sysctlFlags.count)

        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        guard errno == ERR_SUCCESS else {
            throw SystemControlError.genericError(errno: errno)
        }

        return try T.ValueType.withRawMemory(of: size) {
            var mutableMemPtr = $0
            errno = sysctl(
                &sysctlFlags,
                flagCount,
                &mutableMemPtr,
                &size,
                nil,
                0
            )

            guard errno == ERR_SUCCESS else {
                throw SystemControlError.genericError(errno: errno)
            }

            return T.ValueType.loadValue(&mutableMemPtr)
        }
    }
}
