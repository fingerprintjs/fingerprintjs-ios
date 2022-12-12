import CoreGraphics

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "\(self.width)x\(self.height)"
    }
}
