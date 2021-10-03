//
//  CommentModel.swift
//  BoxOffice
//
//  Created by PSJ on 2021/09/25.
//

import ObjectMapper

class CommentSendModel: Mappable {
    var rating: Double?
    var writer: String?
    var movieId: String?
    var contents: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        rating <- map["rating"]
        writer <- map["writer"]
        movieId <- map["movie_id"]
        contents <- map["contents"]
    }
}

class CommentResponseModel: Mappable {
    var comments: [CommentReceiveModel] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        comments <- map["comments"]
    }
}

class CommentReceiveModel: CommentSendModel {
    var id: String?
    var timestamp: Double?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        timestamp <- map["timestamp"]
    }
}
