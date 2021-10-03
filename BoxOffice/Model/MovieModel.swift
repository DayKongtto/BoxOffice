//
//  MovieModel.swift
//  BoxOffice
//
//  Created by PSJ on 2021/09/25.
//

import ObjectMapper

class MovieResponseModel: Mappable {
    var orderType: Int?
    var movies: [MovieModel] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        orderType <- map["order_type"]
        movies <- map["movies"]
    }
}

class MovieModel: Mappable {
    var grade: Int?
    var thumb: String?
    var reservationGrade: Int?
    var title: String?
    var reservationRate: Double?
    var userRating: Double?
    var date: String?
    var id: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        grade <- map["grade"]
        thumb <- map["thumb"]
        reservationGrade <- map["reservation_grade"]
        title <- map["title"]
        reservationRate <- map["reservation_rate"]
        userRating <- map["user_rating"]
        date <- map["date"]
        id <- map["let"]
    }
}
