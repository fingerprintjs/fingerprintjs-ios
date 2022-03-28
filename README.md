# FingerprintKit

Lightweight iOS library for local device fingerprinting. 

# Installation (CocoaPods)

```ruby
# Podfile

pod 'FingerprintKit'
```

# Quick Start (async/await - preferred)

```swift
import FingerprintKit
 
let fingerprinter = FingerprinterFactory.getInstance()
async {
    // Get fingerprint for the current device
    let fingerprint = await fingerprinter.getFingerprint()
    
    // Do something awesome with the fingerprint
}
```

# Quick Start (closures - backwards compatibility)
```swift
import FingerprintKit 

let fingerprinter = FingerprinterFactory.getInstance()
fingerprinter.getFingerprint { fingerprint in
    // Do something awesome with the fingerprint
}
```

# Fingerprint vs. DeviceId

`FingerprintKit` provides two main methods that return different kinds of identifiers:

1. Device identifier retrived by calling `FingerprintKit::getDeviceId()` that internally uses the `identifierForVendor()` method which return a unique identifier for the current application (tied to the device). `FingerprintKit` further remembers this identifier in the keychain, making the identifier stable even between app reinstallations. 

2. `Fingerprinter::getFingerprint()` computes a device fingerprint by gathering device information (hardware, OS, device settings, etc.) and computing a compound hash value from available items. The fingerprint isn't currently as stable as the Device Identifier because the values might change between OS updates or when the user changes settings used to compute the previous value. Further library versions will provide an API with an option to customize the target stability of the fingerprint.

# Configuration
`Fingerprinter` instance can be configured through the `Configuration` structure that provides options to select the fingerprint version or change the algorithm that is used to compute the individual fingerprints.

```swift
// note that this example exists only to illustrate the available options
// and that its outcome mirrors the current default configuration

let configuration = Configuration(version: .v1, algorithm: .sha256)
let fingerprinter = FingerprinterFactory.getInstance(config)

// fingerprinter uses version 1 of the fingerprint and SHA256 algorithm
```

## Creating Custom Fingerprinting Function
The default hashing function which computes the fingerprint from the content data is SHA256. The `Configuration` structure offers a way to inject a custom hashing function by specifying `.custom(YourCustomFingerprintFunctionInstance)` in the `algorithm` variable:

```swift
class HitchhikersFunction: FingerprintFunction {
    func fingerprint(_ data: Data) -> String {
        return "42"
    }
}

let fingerprintFunction = HitchhikersFunction()
let config = Configuration(version: .v1, algorithm: .custom(fingerprintFunction))
let fingerprinter = FingerprinterFactory.getInstance(config)

let fingerprint = await fingerprinter.getFingerprint() // returns "42"
```

Keep in mind that the change in the supplied hashing function will inevitably lead to the change of the output fingerprint.
