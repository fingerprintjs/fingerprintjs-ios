import Foundation

public protocol RawPointerConvertible {
    static func loadValue(_ from: UnsafeRawPointer, of size: Int) -> Self
    static func withRawMemory(
        of size: Int,
        body: (inout UnsafeMutableRawPointer) throws -> Self
    ) rethrows -> Self
}

extension RawPointerConvertible {
    public static func withRawMemory(
        of size: Int,
        body: (inout UnsafeMutableRawPointer) throws -> Self
    ) rethrows -> Self {
        var mem = UnsafeMutableRawPointer.allocate(
            byteCount: size,
            alignment: MemoryLayout<Self>.alignment
        )

        defer {
            mem.deallocate()
        }

        return try body(&mem)
    }

    public static func loadValue(_ from: UnsafeRawPointer, of size: Int) -> Self {
        from.load(as: Self.self)
    }
}

extension timeval: RawPointerConvertible {}
extension loadavg: RawPointerConvertible {}
extension Int32: RawPointerConvertible {}
extension Int64: RawPointerConvertible {}

extension String: RawPointerConvertible {
    public static func withRawMemory(
        of size: Int,
        body: (inout UnsafeMutableRawPointer) throws -> Self
    ) rethrows -> Self {
        var mem = UnsafeMutableRawPointer.allocate(
            byteCount: size,
            alignment: MemoryLayout<CChar>.alignment
        )

        defer {
            mem.deallocate()
        }

        return try body(&mem)
    }

    public static func loadValue(_ from: UnsafeRawPointer, of size: Int) -> Self {
        let chars = from.bindMemory(to: CChar.self, capacity: size)
        return String(cString: chars)
    }
}
