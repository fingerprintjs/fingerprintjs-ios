//
//  ScreenSizeProviding.swift
//  FingerprintJSTests
//
//  Created by Petr Palata on 11.04.2022.
//

import CoreGraphics
import Foundation

@testable import FingerprintJS

class ScreenSizeProvidingMock: ScreenSizeProviding {
    var mockNativeBounds = CGRect.zero
    var nativeBoundsCalled = false

    var nativeBounds: CGRect {
        nativeBoundsCalled = true
        return mockNativeBounds
    }
}
