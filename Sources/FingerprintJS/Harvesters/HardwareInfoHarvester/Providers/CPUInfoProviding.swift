import Foundation

protocol CPUInfoProviding {
    var processorCount: Int { get }
}

extension ProcessInfo: CPUInfoProviding {}
