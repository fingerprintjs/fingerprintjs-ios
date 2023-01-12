import Foundation

protocol RawPointerConvertible {
    static func loadValue(_ from: UnsafeMutableRawPointer) -> Self
    static func withRawMemory(
        of size: Int,
        body: (UnsafeMutableRawPointer) throws -> Self
    ) rethrows -> Self
}

extension RawPointerConvertible {
    static func withRawMemory(
        of size: Int,
        body: (UnsafeMutableRawPointer) throws -> Self
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

    static func loadValue(_ from: UnsafeMutableRawPointer) -> Self {
        from.load(as: Self.self)
    }
}

extension timeval: RawPointerConvertible {}
extension loadavg: RawPointerConvertible {}
extension Int32: RawPointerConvertible {}
extension Int64: RawPointerConvertible {}

extension String: RawPointerConvertible {
    static func withRawMemory(
        of size: Int,
        body: (UnsafeMutableRawPointer) throws -> Self
    ) rethrows -> Self {
        var mem = [CChar](repeating: 0, count: size)
        return try withUnsafeMutablePointer(to: &mem) { memPtr in
            return try body(memPtr)
        }
    }

    static func loadValue(_ from: UnsafeMutableRawPointer) -> String {
        let chars = from.assumingMemoryBound(to: CChar.self)
        return String(cString: chars)
    }
}
