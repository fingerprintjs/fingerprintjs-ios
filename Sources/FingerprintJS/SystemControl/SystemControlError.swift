import Foundation

enum SystemControlError: Error {
    case genericError(errno: Int32)
}
