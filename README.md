# FingerprintKit

Lightweight iOS library for local device fingerprinting. 

# Quick Start (async/await - preferred)

```
    let fingerprinter = FingerprinterFactory.getInstance()
    async {
        // Get fingerprint for the current device
        let fingerprint = await fingerprinter.getFingerprint()
        
        // Do something awesome with the fingerprint
    }
```

# Quick Start (closures - backwards compatibility)
```
    let fingerprinter = FingerprinterFactory.getInstance()
    fingerprinter.getFingerprint { fingerprint in
        // Do something awesome with the fingerprint
    }
```

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

# Fingerprint Stability
For the purposes of FingerprintKit, fingeprint stability determines whether the value returned by the `Fingerprinter.getFingerprint()` remains the same under any circumstances. FingerprintKit does not provide 100% stable identifier but tries to employ techniques that make it more stable compared with the default system-provided identifiers.

## Keychain Usage
`FingerprintKit` uses `Keychain` to save the vendor identifier to increase the fingerprint's stability between app reinstallations.
