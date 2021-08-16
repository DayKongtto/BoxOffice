//
//  Movie.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import Foundation

//{
//     order_type:1,
//     movies: [
//         {
    //         grade: 12,
    //         thumb:
    //        "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
    //        jpg?type=m99_141_2",
    //         reservation_grade: 1,
    //         title: "신과함께-죄와벌",
    //         reservation_rate: 35.5,
    //         user_rating: 7.98,
    //         date: "2017-12-20",
    //         id: "5a54c286e8a71d136fb5378e"
//         },
//         {
    //         grade: 12,
    //         thumb:
    //        "http://movie2.phinf.naver.net/20170925_296/150631600340898aUX_JPEG/movie_image
    //        .jpg?type=m99_141_2",
    //         reservation_grade: 2,
    //         title: "저스티스 리그",
    //         reservation_rate: 12.63,
    //         user_rating: 7.8,
    //         date: "2017-11-15",
    //         id: "5a54c1e9e8a71d136fb5376c"
//         }
//     ]
//}

struct MovieAPIResponse: Codable {
    let order_type: Int
    let movies: [Movie]
}

struct Movie: Codable {
    let grade: Int
    let thumb: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String
    
    var info: String {
        return "평점:\(self.user_rating) 예매순위:\(self.reservation_grade) 예매율:\(self.reservation_rate)"
    }

    var dateInfo: String {
        return "개봉일: \(self.date)"
    }

    var gradeName: String {
        switch self.grade {
        case 0:
            return "ic_allages"
        default:
            return "ic_\(self.grade)"
        }
    }
}
