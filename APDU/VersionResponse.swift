//
//  VersionResponse.swift
//  SoftU2F
//
//  Created by Benjamin P Toews on 1/25/17.
//

import Foundation

public struct VersionResponse: RawConvertible {
    let body: Data
    let trailer: ResponseStatus

    public var version: String {
        return String(data: body, encoding: .utf8) ?? ""
    }

    public init(version: String) {
        body = version.data(using: .utf8)!
        trailer = .NoError
    }
}

extension VersionResponse: Response {
    init(body: Data, trailer: ResponseStatus) {
        self.body = body
        self.trailer = trailer
    }

    func validateBody() throws {
        if version.lengthOfBytes(using: .utf8) < 1 {
            throw ResponseError.BadSize
        }

        if trailer != .NoError {
            throw ResponseError.BadStatus
        }
    }
}
