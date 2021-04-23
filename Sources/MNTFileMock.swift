//
//  MNTFileMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 07/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

public class MNTFileMock: MNTBodyMock {
    public var filename: String
    public var fileExtension: String
    public var bundle: Bundle
    public var fullName: String { "\(filename).\(fileExtension)" }
    public var path: String? {
        return bundle.path(forResource: filename, ofType: fileExtension)
    }

    public init(filename: String, fileExtension: String, bundle: Bundle = .main) {
        self.filename = filename
        self.fileExtension = fileExtension
        self.bundle = bundle
    }

    public func toData() throws -> Data {
        guard let path = path, path.isEmpty == false else {
            throw MNTError.mockFail(reason: .notPresentInBundle(file: fullName))
        }
        guard let data = FileManager.default.contents(atPath: path) else {
            throw MNTError.mockFail(reason: .unreadableMockFile(file: fullName))
        }

        return data
    }
}
