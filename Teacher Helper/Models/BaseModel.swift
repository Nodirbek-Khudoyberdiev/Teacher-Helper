//
//  BaseResponse.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import Foundation

let globalDefaultError: BaseError = .init(status: false, message: "Что-то пошнло не так", code: nil)

struct BaseResponse<T: Codable>: Codable {
    let status: Bool?
    let message: String?
    let data: T?
    let code: Int?
    let meta: ResponseMeta?
}

struct BaseError: Codable, Error {
    let status: Bool?
    let message: String?
    let code: Int?
}

struct ResponseMeta: Codable {
    let count: Int?
    let currentPage: Int?
    let previousPageUrl: String?
    let nextPageUrl: String?
    let total: Int?
    let totalPage: Int?
}
