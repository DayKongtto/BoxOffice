//
//  MovieDetailModel.swift
//  BoxOffice
//
//  Created by PSJ on 2021/10/03.
//

import ObjectMapper

class MovieDetailModel: Mappable {
    var audience: Double?
    var grade: Int?
    var actor: String?
    var duration: Int?
    var reservationGrade: Int?
    var title: String?
    var reservationRate: Double?
    var userRating:Double?
    var date: String?
    var director: String?
    var id: String?
    var image: String?
    var synopsis: String?
    var genre: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audience <- map["audience"]
        grade <- map["grade"]
        actor <- map["actor"]
        duration <- map["duration"]
        reservationGrade <- map["reservation_grade"]
        title <- map["title"]
        reservationRate <- map["reservation_rate"]
        userRating <- map["user_rating"]
        date <- map["date"]
        director <- map["director"]
        id <- map["id"]
        image <- map["image"]
        synopsis <- map["synopsis"]
        genre <- map["genre"]
    }
    
    
}
