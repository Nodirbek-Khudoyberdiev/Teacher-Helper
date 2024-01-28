//
//  ResourcesModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 28/01/24.
//

import Foundation

struct Resources: Codable {
    let id: Int?
    let resourceName: String?
    let status: String?
    let createdAt: String?
    let media: [ResourceMedia]?
    let topic: ResourceTopic?
    enum CodingKeys: String, CodingKey {
        case id, topic, status, media
        case resourceName = "resource_name"
        case createdAt = "created_at"
    }
}

struct ResourceTopic: Codable {
    let id: Int?
    let topicName: String?
    let add: ResourceAdd?
    
    enum CodingKeys: String, CodingKey {
        case id, add
        case topicName = "topic_name"
    }
}

struct ResourceAdd: Codable {
    let grade: String?
    let quarter: String?
    let science: String?
    
    enum CodingKeys: String, CodingKey {
        case grade = "class"
        case quarter, science
    }

}

struct ResourceMedia: Codable {
    let id: Int?
    let mimeType: String?
    let size: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, size
        case mimeType = "mime_type"
    }
}

