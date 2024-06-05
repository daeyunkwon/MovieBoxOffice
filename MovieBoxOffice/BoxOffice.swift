//
//  BoxOffice.swift
//  MovieBoxOffice
//
//  Created by 권대윤 on 6/6/24.
//

import UIKit

struct BoxOffice: Codable {
    let movieNm: String?
    let openDt: String?
    let rank: String?
}

struct BoxOfficeData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType: String?
    let showRange: String?
    let dailyBoxOfficeList: [BoxOffice]
}
