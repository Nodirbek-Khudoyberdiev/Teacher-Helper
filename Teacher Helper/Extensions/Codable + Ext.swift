//
//  Decodable + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import Foundation

extension Decodable {
    static func decode(_ data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}

