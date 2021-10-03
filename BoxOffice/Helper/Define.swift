//
//  Define.swift
//  BoxOffice
//
//  Created by PSJ on 2021/09/25.
//

import Foundation

let BASE_URL: String = "https://connect-boxoffice.run.goorm.io"

func getGradeName(_ grade:Int) -> String? {
    switch grade {
    case 0:
        return "ic_allages"
    case 12,15,19:
        return "ic_\(grade)"
    default:
        return nil
    }
}


