//
//  PostModel.swift
//  CleanProtocolTableView
//
//  Created by Emincan on 13.09.2022.
//

import Foundation

struct PostModel: Codable {
    let userID: Int?
    let id: Int?
    let title: String?
    let body: String?
}
