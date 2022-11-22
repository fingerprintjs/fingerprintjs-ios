import UIKit

protocol AppInfoHarvesting {
    var userInterfaceStyle: UserInterfaceStyle { get }
}

struct AppInfoHarvester {

    private let userInterfaceTraitsProvider: UserInterfaceTraitsProvidable

    init(userInterfaceTraitsProvider: UserInterfaceTraitsProvidable) {
        self.userInterfaceTraitsProvider = userInterfaceTraitsProvider
    }
}

extension AppInfoHarvester {

    init() {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(
                userInterfaceTraitsProvider: UITraitCollection.current
            )
        } else {
            self.init(
                userInterfaceTraitsProvider: UITraitCollection(userInterfaceStyle: .light)
            )
        }
    }
}

extension AppInfoHarvester: AppInfoHarvesting {

    var userInterfaceStyle: UserInterfaceStyle {
        .init(userInterfaceTraitsProvider.userInterfaceStyle)
    }
}
