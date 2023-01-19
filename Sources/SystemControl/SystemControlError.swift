public enum SystemControlError: Error, Equatable {
    case osError(Int32)
    case valueHasZeroSize
}
