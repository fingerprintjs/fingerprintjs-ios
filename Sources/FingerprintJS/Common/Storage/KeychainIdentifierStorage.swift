import Foundation

class KeychainIdentifierStorage {
    private let fingerPrintJSService = "com.fingerprintjs.keychain"

    private func getStringFromKeychain(_ key: String) -> String? {
        let loadQuery =
            [
                kSecClass: kSecClassGenericPassword as CFString,
                kSecAttrService: fingerPrintJSService as CFString,
                kSecReturnData: true as CFBoolean,
                kSecAttrAccount: key as CFString,
            ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(loadQuery, &result)

        guard let resultData = result as? Data else {
            return nil
        }

        return String(data: resultData, encoding: .utf8)
    }

    private func storeStringIntoKeychain(_ value: String, for key: String) {
        guard let stringData = value.data(using: .utf8) else {
            // cannot convert string to data, nothing to save
            return
        }

        let storeQuery =
            [
                kSecClass: kSecClassGenericPassword as CFString,
                kSecValueData: stringData,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly as CFString,
                kSecAttrService: fingerPrintJSService as CFString,
                kSecAttrAccount: key as CFString,
            ] as CFDictionary

        var result: AnyObject?
        let addStatus = SecItemAdd(storeQuery, &result)
        if addStatus == errSecDuplicateItem {
            let updateQuery = [kSecValueData: stringData] as CFDictionary
            let updateStatus = SecItemUpdate(storeQuery, updateQuery)
            if updateStatus == errSecSuccess {
                print("FingerprintJS: Updated item in the keychain")
            } else {
                print("FingerprintJS: Cannot save identifier into keychain because error \(updateStatus) occured")
            }
        } else if addStatus == errSecSuccess {
            print("Saved item in the keychain")
        } else {
            print("FingerprintJS: Cannot save identifier into keychain because error \(addStatus) occured")

        }
    }
}

extension KeychainIdentifierStorage: IdentifierStorable {
    func storeIdentifier(_ identifier: UUID, for key: String) {
        let identifierString = identifier.uuidString
        storeStringIntoKeychain(identifierString, for: key)
    }

    func loadIdentifier(for key: String) -> UUID? {
        guard let identifierString = getStringFromKeychain(key) else {
            return nil
        }

        return UUID(uuidString: identifierString)
    }
}
