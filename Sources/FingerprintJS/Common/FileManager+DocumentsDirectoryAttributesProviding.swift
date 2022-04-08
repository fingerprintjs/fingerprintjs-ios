//
//  FileManager+DocumentsDirectoryAttributesProviding.swift
//  FingerprintJS
//
//  Created by Petr Palata on 08.04.2022.
//
import Foundation

protocol DocumentsDirectoryAttributesProviding {
    var documentsDirectoryPath: String? { get }
    func documentsDirectoryAttributes() throws -> [FileAttributeKey: Any]
}

enum DocumentsDirectoryError: Error {
    case documentsDirectoryNotFound
}

extension FileManager: DocumentsDirectoryAttributesProviding {
    var documentsDirectoryPath: String? {
        let paths = self.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )

        return paths.first?.path
    }

    func documentsDirectoryAttributes() throws -> [FileAttributeKey: Any] {
        guard let documentsDirectoryPath = documentsDirectoryPath else {
            throw DocumentsDirectoryError.documentsDirectoryNotFound
        }

        return try self.attributesOfFileSystem(forPath: documentsDirectoryPath)
    }
}
