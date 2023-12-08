//
//  BaseResponse.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let status: Bool?
    let message: String?
    let data: T?
    let code: Int?
}
