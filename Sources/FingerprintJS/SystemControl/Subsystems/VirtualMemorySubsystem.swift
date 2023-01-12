import Foundation

struct VirtualMemorySubsystem {
    private let systemControl: SystemControlValuesRetrieving

    init(systemControl: SystemControlValuesRetrieving = SystemControl()) {
        self.systemControl = systemControl
    }
}

extension VirtualMemorySubsystem {
    private enum Definition {
        static var loadavg: SystemControlValueDefinition<loadavg> {
            .init(flags: [CTL_VM, VM_LOADAVG])
        }
    }
}

extension VirtualMemorySubsystem {
    var vmloadavg: loadavg? {
        try? systemControl.getSystemValue(Definition.loadavg)
    }
}
