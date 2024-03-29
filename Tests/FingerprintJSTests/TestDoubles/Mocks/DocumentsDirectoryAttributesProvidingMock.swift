import Foundation

@testable import FingerprintJS

class DocumentsDirectoryAttributesProvidingMock: DocumentsDirectoryAttributesProviding {
    var mockDocumentsDirectoryPath: String?
    var mockDocumentsDirectoryAttributes: [FileAttributeKey: Any] = [:]
    var mockDocumentsDirectoryAttributesError: Error?

    var documentsDirectoryPath: String? {
        return mockDocumentsDirectoryPath
    }

    func documentsDirectoryAttributes() throws -> [FileAttributeKey: Any] {
        if let error = mockDocumentsDirectoryAttributesError {
            throw error
        }
        return mockDocumentsDirectoryAttributes
    }
}
