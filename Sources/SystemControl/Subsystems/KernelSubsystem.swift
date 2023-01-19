import Foundation

struct KernelSubsystem {
    private let systemControl: SystemControlValuesRetrieving

    init(systemControl: SystemControlValuesRetrieving = SystemControlValuesRetriever()) {
        self.systemControl = systemControl
    }
}

extension KernelSubsystem {
    private enum Definition {
        static var bootTime: SystemControlValueDefinition<timeval> {
            .init(flags: [CTL_KERN, KERN_BOOTTIME])
        }

        static var hostname: SystemControlValueDefinition<String> {
            .init(flags: [CTL_KERN, KERN_HOSTNAME])
        }

        static var osRelease: SystemControlValueDefinition<String> {
            .init(flags: [CTL_HW, KERN_OSRELEASE])
        }

        static var osType: SystemControlValueDefinition<String> {
            .init(flags: [CTL_KERN, KERN_OSTYPE])
        }

        static var osVersion: SystemControlValueDefinition<String> {
            .init(flags: [CTL_KERN, KERN_OSVERSION])
        }

        static var kernelVersion: SystemControlValueDefinition<String> {
            .init(flags: [CTL_KERN, KERN_VERSION])
        }

        static var osBuild: SystemControlValueDefinition<Int32> {
            .init(flags: [CTL_KERN, KERN_OSREV])
        }
    }
}

extension KernelSubsystem {
    var bootTime: timeval? {
        try? systemControl.getSystemValue(Definition.bootTime)
    }

    var hostname: String? {
        try? systemControl.getSystemValue(Definition.hostname)
    }

    var osRelease: String? {
        try? systemControl.getSystemValue(Definition.osRelease)
    }

    var osType: String? {
        try? systemControl.getSystemValue(Definition.osType)
    }

    var osVersion: String? {
        try? systemControl.getSystemValue(Definition.osVersion)
    }

    var kernelVersion: String? {
        try? systemControl.getSystemValue(Definition.kernelVersion)
    }

    var osBuild: Int32? {
        try? systemControl.getSystemValue(Definition.osBuild)
    }
}
