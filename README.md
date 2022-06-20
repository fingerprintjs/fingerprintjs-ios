<p align="center">
  <a href="https://fingerprintjs.com">
    <img src="images/logo.svg" alt="FingerprintJS" width="300px" />
  </a>
</p>
<p align="center">Lightweight iOS library for local device fingerprinting</p>

<p align="center">
    <a href="https://cocoapods.org/pods/FingerprintJS">
        <img src="https://img.shields.io/cocoapods/p/ios" alt="Supported platforms">
    </a>
    <a href="https://cocoapods.org/pods/FingerprintJS">
        <img src="https://img.shields.io/cocoapods/v/FingerprintJS" alt="Pod version">
    </a>
</p>

<p align="center">
  <a href="https://discord.gg/39EpE2neBg">
    <img src="https://img.shields.io/discord/852099967190433792?style=for-the-badge&label=Discord&logo=Discord&logoColor=white" alt="Discord server">
  </a>
</p>
  
<h3 align="center">Demo application on the App Store</h3>
<p align="center">
  <a href="https://apps.apple.com/us/app/fingerprintjs-showcase/id1621330481?itsct=apps_box_badge&amp;itscg=30200" style="display: inline-block; overflow: hidden; border-radius: 13px; width: 250px; height: 83px;"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1653436800&h=6f4dc95fe89ec63aa1fa67305e369224" alt="Download on the App Store" style="border-radius: 13px; width: 250px; height: 83px;"></a>
</p>

<p align="center">
  <img src="images/demoapp.gif" width="195">
  <img src="images/demoapp1.png" width="195">
  <img src="images/demoapp2.png" width="195">
  <img src="images/demoapp3.png" width="195">
</p>


# Installation (CocoaPods)

```ruby
# Podfile
pod 'FingerprintJS'
```

Note: If you've never used CocoaPods for dependency management, check out their [Using CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) guide that will walk you through the setup process.

# Quick Start (async/await - preferred)

```swift
import FingerprintJS
 
let fingerprinter = FingerprinterFactory.getInstance()
async {
    // Get fingerprint for the current device
    let fingerprint = await fingerprinter.getFingerprint()
    
    // Do something awesome with the fingerprint
}
```

# Quick Start (closures - backwards compatibility)
```swift
import FingerprintJS 

let fingerprinter = FingerprinterFactory.getInstance()
fingerprinter.getFingerprint { fingerprint in
    // Do something awesome with the fingerprint
}
```

# Fingerprint vs. DeviceId

`FingerprintJS` provides two main methods that return different kinds of identifiers:

1. Device identifier retrieved by calling `Fingerprinter::getDeviceId()` that internally uses the `identifierForVendor()` method which returns a unique identifier for the current application (tied to the device). `FingerprintJS` further remembers this identifier in the keychain, making the identifier stable even between app reinstalls. 

2. `Fingerprinter::getFingerprint()` computes a device fingerprint by gathering device information (hardware, OS, device settings, etc.) and computing a  hash value from available items. The fingerprint isn't currently as stable as the Device Identifier because the values might change between OS updates or when the user changes settings used to compute the previous value. Future library versions will provide an API with options to customize the stability of the fingerprint.

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

## License
This library is MIT licensed. Copyright FingerprintJS, Inc. 2022.
