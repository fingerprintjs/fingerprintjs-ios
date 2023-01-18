import Foundation

struct HardwareSubsystem {
    private let systemControl: SystemControlValuesRetrieving

    init(systemControl: SystemControlValuesRetrieving = SystemControlValuesRetriever()) {
        self.systemControl = systemControl
    }
}

extension HardwareSubsystem {
    private enum Definition {
        static var hardwareModel: SystemControlValueDefinition<String> {
            .init(flags: [CTL_HW, HW_MODEL])
        }

        static var hardwareMachine: SystemControlValueDefinition<String> {
            .init(flags: [CTL_HW, HW_MACHINE])
        }

        static var memorySize: SystemControlValueDefinition<Int64> {
            .init(flags: [CTL_HW, HW_MEMSIZE])
        }

        static var physicalMemory: SystemControlValueDefinition<Int32> {
            .init(flags: [CTL_HW, HW_PHYSMEM])
        }

        static var cpuCount: SystemControlValueDefinition<Int32> {
            .init(flags: [CTL_HW, HW_NCPU])
        }

        static var cpuFrequency: SystemControlValueDefinition<Int32> {
            .init(flags: [CTL_HW, HW_CPU_FREQ])
        }
    }
}

extension HardwareSubsystem {
    var model: String? {
        try? systemControl.getSystemValue(Definition.hardwareModel)
    }

    var machine: String? {
        try? systemControl.getSystemValue(Definition.hardwareMachine)
    }

    var memorySize: Int64? {
        try? systemControl.getSystemValue(Definition.memorySize)
    }

    var physicalMemory: Int32? {
        try? systemControl.getSystemValue(Definition.physicalMemory)
    }

    var cpuCount: Int32? {
        try? systemControl.getSystemValue(Definition.cpuCount)
    }

    var cpuFrequency: Int32? {
        try? systemControl.getSystemValue(Definition.cpuFrequency)
    }
}
