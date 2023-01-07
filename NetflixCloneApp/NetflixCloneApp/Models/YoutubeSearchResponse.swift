//
//  YoutubeSearchResponse.swift
//  NetflixCloneApp
//
//  Created by Emincan on 12.06.2022.
//

import Foundation
import UIKit

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable{
    
    let id: IdVideoElement
}

struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}
