//
// Info.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Info: Codable, JSONEncodable, Hashable {

    public var total: Int?

    public init(total: Int? = nil) {
        self.total = total
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case total
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(total, forKey: .total)
    }
}

