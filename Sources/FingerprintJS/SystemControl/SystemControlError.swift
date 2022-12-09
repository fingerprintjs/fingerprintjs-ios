import Foundation

enum SystemControlError: Error {
    case wrongOutputType
    case genericError(errno: Int32)
}
