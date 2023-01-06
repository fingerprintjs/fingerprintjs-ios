import Foundation

public protocol RawPointerConvertible {
    static func loadValue(_ from: UnsafeMutableRawPointer, bytes: size_t) -> Self?
    static func withMemoryInput(
        of size: Int,
        body: ((UnsafeMutableRawPointer) throws -> Self?)
    ) rethrows -> Self?
}

extension RawPointerConvertible {
    public static func withMemoryInput(
        of size: size_t,
        body: (UnsafeMutableRawPointer) throws -> Self?
    ) rethrows -> Self? {
        let mem = UnsafeMutableRawPointer.allocate(
            byteCount: size,
            alignment: MemoryLayout<Self>.alignment
        )

        defer {
            mem.deallocate()
        }

        return try body(mem)
    }

    public static func loadValue(_ from: UnsafeMutableRawPointer, bytes: size_t) -> Self? {
        from.load(as: Self.self)
    }
}

extension timeval: RawPointerConvertible {}
extension loadavg: RawPointerConvertible {}
extension Int32: RawPointerConvertible {}
extension Int64: RawPointerConvertible {}

extension String: RawPointerConvertible {
    public static func withMemoryInput(
        of size: size_t,
        body: (UnsafeMutableRawPointer) throws -> Self?
    ) rethrows -> Self? {
        var mem = [CChar](repeating: 0, count: size)
        return try withUnsafeMutablePointer(to: &mem) { ptr in
            return try body(ptr)
        }
    }

    public static func loadValue(_ from: UnsafeMutableRawPointer, bytes: size_t) -> String? {
        let chars = from.assumingMemoryBound(to: CChar.self)
        return String(cString: chars)
    }
}
