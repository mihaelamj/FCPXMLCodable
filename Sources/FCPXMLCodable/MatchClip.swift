//
//  MatchClip.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchClip: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case rule, type
    }
    
    /// Specifies the possible item types to match for a clip match.
    public enum ItemType: String, XMLRepresentable {

        /// :nodoc:
        case audition

        /// :nodoc:
        case synchronized

        /// :nodoc:
        case compound

        /// :nodoc:
        case multicam

        /// :nodoc:
        case layeredGraphic

        /// :nodoc:
        case project

    }
    
    /// A Boolean value indicating whether the clip match is enabled.
    public var isEnabled: Bool = true
    
    /// The rule to use for the clip match.
    public var rule: Rule
    
    /// The item type to match.
    public var type: ItemType
    
    /// Initializes a new clip match.
    /// - Parameter rule: The rule to use for the clip match, `isExactly` by default.
    /// - Parameter type: The item type to match.
    public init(rule: Rule = .isExactly, type: ItemType) {
        self.rule = rule
        self.type = type
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .isExactly
        type = try container.decode(ItemType.self, forKey: .type)
    }

}

extension MatchClip: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}
