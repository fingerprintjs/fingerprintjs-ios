import UIKit

protocol AppInfoHarvesting {
    var localeIdentifier: String { get }

    var userInterfaceStyle: UserInterfaceStyle { get }
}

struct AppInfoHarvester {

    private let localeInfoProvider: LocaleInfoProviding
    private let userInterfaceTraitsProvider: UserInterfaceTraitsProviding

    init(
        localeInfoProvider: LocaleInfoProviding,
        userInterfaceTraitsProvider: UserInterfaceTraitsProviding
    ) {
        self.localeInfoProvider = localeInfoProvider
        self.userInterfaceTraitsProvider = userInterfaceTraitsProvider
    }
}

extension AppInfoHarvester {

    init() {
        let traitCollection: UITraitCollection
        if #available(iOS 13.0, tvOS 13.0, *) {
            traitCollection = .current
        } else {
            traitCollection = .init(userInterfaceStyle: .light)
        }
        self.init(
            localeInfoProvider: Locale.current,
            userInterfaceTraitsProvider: traitCollection
        )
    }
}

extension AppInfoHarvester: AppInfoHarvesting {

    var localeIdentifier: String {
        localeInfoProvider.identifier
    }

    var userInterfaceStyle: UserInterfaceStyle {
        .init(userInterfaceTraitsProvider.userInterfaceStyle)
    }
}
