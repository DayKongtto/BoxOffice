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
    
    var collectionInfo: String {
        return "\(self.reservation_grade)위(\(self.reservation_rate)) \(self.reservation_rate)%"
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

//{
//audience: 11676822,
//grade: 12,
//actor: "하정우(강림), 차태현(자홍), 주지훈(해원맥), 김향기(덕춘)", duration: 139,
//reservation_grade: 1,
//title: "신과함께-죄와벌",
//reservation_rate: 35.5,
//user_rating: 7.98,
//date: "2017-12-20",
//director: "김용화",
//id: "5a54c286e8a71d136fb5378e",
//image:
//"http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
//jpg",
//synopsis: "저승 법에 의하면, (중략) 고난과 맞닥뜨리는데... 누구나 가지만 아무도 본 적 없는 곳, 새 로운 세계의 문이 열린다!",
//genre: "판타지, 드라마" }

struct MovieDetail {
    let audien: Double
    let grade: Int
    let actor: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rationg:Double
    let date: String
    let director: String
    let id: String
    let image: String
    let synopsis: String
    let genre: String
}


//{
//comments: [
//{
//id: "5d5e09241b865e00110ab5eb",
//rating: 10,
//timestamp: 1515748870.80631,
//writer: "두근반 세근반",
//movie_id: "5a54c286e8a71d136fb5378e",
//contents:"정말 다섯 번은 넘게 운듯 ᅲᅲᅲ 감동 쩔어요.꼭 보셈 두 번 보셈"
//},
//{
//id: "5d5e08f41b865e00110ab5ea",
//timestamp: 1511332885,
//movie_id: "5a54c286e8a71d136fb5378e",
//writer: "zkfm",
//rating: 9.1,
//contents: "한국형 영화입니다~이런류좋아하시는분은무조건재밌다합니다~전요번년도 세손가락에꼽히는 영화네요~굿잡~"
//} ]
//}

struct CommentAPIReponse {
    let comments: [CommentReceive]
}

struct CommentReceive {
    let id: String
    let rating: Double
    let writer: String
    let movie_id: String
    let contents: String
}

struct CommentSend {
    let id: String
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
}
