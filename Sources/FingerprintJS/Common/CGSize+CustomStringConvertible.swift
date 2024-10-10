import CoreGraphics

extension CoreGraphics.CGSize: Swift.CustomStringConvertible {
    public var description: String {
        return "\(width)x\(height)"
    }
}
