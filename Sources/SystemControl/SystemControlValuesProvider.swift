import Foundation

public protocol SystemControlValuesProviding {
    var hardwareModel: String? { get }
    var hardwareMachine: String? { get }
    var osRelease: String? { get }
    var osType: String? { get }
    var osVersion: String? { get }
    var kernelVersion: String? { get }
    var osBuild: Int32? { get }
    var memorySize: Int64? { get }
    var physicalMemory: Int32? { get }
    var cpuCount: Int32? { get }
    var cpuFrequency: Int32? { get }
    var bootTime: Date? { get }
    var hostname: String? { get }
}

public struct SystemControlValuesProvider {
    private let kernel: KernelSubsystem
    private let hardware: HardwareSubsystem
    private let virtualMemory: VirtualMemorySubsystem

    public init() {
        self.init(
            kernel: KernelSubsystem(),
            hardware: HardwareSubsystem(),
            virtualMemory: VirtualMemorySubsystem()
        )
    }

    init(
        kernel: KernelSubsystem,
        hardware: HardwareSubsystem,
        virtualMemory: VirtualMemorySubsystem
    ) {
        self.kernel = kernel
        self.hardware = hardware
        self.virtualMemory = virtualMemory
    }
}

extension SystemControlValuesProvider: SystemControlValuesProviding {
    public var hardwareModel: String? { hardware.model }

    public var hardwareMachine: String? { hardware.machine }

    public var osRelease: String? { kernel.osRelease }

    public var osType: String? { kernel.osType }

    public var osVersion: String? { kernel.osVersion }

    public var kernelVersion: String? { kernel.kernelVersion }

    public var osBuild: Int32? { kernel.osBuild }

    public var memorySize: Int64? { hardware.memorySize }

    public var physicalMemory: Int32? { hardware.physicalMemory }

    public var cpuCount: Int32? { hardware.cpuCount }

    public var cpuFrequency: Int32? { hardware.cpuFrequency }

    public var bootTime: Date? {
        guard let bootTime = kernel.bootTime else {
            return nil
        }

        let epochTime = TimeInterval(bootTime.tv_sec)
        return Date(timeIntervalSince1970: epochTime)
    }

    public var hostname: String? { kernel.hostname }
}
