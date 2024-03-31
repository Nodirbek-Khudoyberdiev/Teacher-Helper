//
//  ResourcesBoughtResponse.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 31/03/24.
//

import Foundation

struct ResourcesBoughtResponse: Codable {
    let resourceName: String
    let grade: String
    let quarter: [String]
}
