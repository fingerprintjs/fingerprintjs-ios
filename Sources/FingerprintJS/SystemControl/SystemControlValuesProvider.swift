import Foundation

protocol SystemControlValuesProviding {
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

struct SystemControlValuesProvider {
    private let kernel: KernelSubsystem
    private let hardware: HardwareSubsystem
    private let virtualMemory: VirtualMemorySubsystem

    init(
        kernel: KernelSubsystem = KernelSubsystem(),
        hardware: HardwareSubsystem = HardwareSubsystem(),
        virtualMemory: VirtualMemorySubsystem = VirtualMemorySubsystem()
    ) {
        self.kernel = kernel
        self.hardware = hardware
        self.virtualMemory = virtualMemory
    }
}

extension SystemControlValuesProvider: SystemControlValuesProviding {
    var hardwareModel: String? { hardware.model }

    var hardwareMachine: String? { hardware.machine }

    var osRelease: String? { kernel.osRelease }

    var osType: String? { kernel.osType }

    var osVersion: String? { kernel.osVersion }

    var kernelVersion: String? { kernel.kernelVersion }

    var osBuild: Int32? { kernel.osBuild }

    var memorySize: Int64? { hardware.memorySize }

    var physicalMemory: Int32? { hardware.physicalMemory }

    var cpuCount: Int32? { hardware.cpuCount }

    var cpuFrequency: Int32? { hardware.cpuFrequency }

    var bootTime: Date? {
        guard let bootTime = kernel.bootTime else {
            return nil
        }

        let epochTime = TimeInterval(bootTime.tv_sec)
        return Date(timeIntervalSince1970: epochTime)
    }

    var hostname: String? { kernel.hostname }
}
