import Foundation

public protocol SystemControlValuesRetrieving {
    func getSystemValue<T: SystemControlValueDefining>(_ definition: T) throws -> T.ValueType
}

public struct SystemControlValuesRetriever: SystemControlValuesRetrieving {
    public init() {}

    public func getSystemValue<T: SystemControlValueDefining>(_ definition: T) throws -> T.ValueType {
        var size = 0

        var sysctlFlags = definition.flags
        let flagCount = u_int(sysctlFlags.count)

        var errno = sysctl(&sysctlFlags, flagCount, nil, &size, nil, 0)
        guard errno == ERR_SUCCESS else {
            throw SystemControlError.osError(errno)
        }

        guard size > 0 else { throw SystemControlError.valueHasZeroSize }

        return try T.ValueType.withRawMemory(of: size) { mem in
            errno = sysctl(
                &sysctlFlags,
                flagCount,
                mem,
                &size,
                nil,
                0
            )

            guard errno == ERR_SUCCESS else {
                throw SystemControlError.osError(errno)
            }

            return T.ValueType.loadValue(mem, of: size)
        }
    }
}
