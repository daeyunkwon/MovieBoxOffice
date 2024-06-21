//
//  NetworkManager.swift
//  MovieBoxOffice
//
//  Created by 권대윤 on 6/20/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchBoxOfficeData(date: String, completion: @escaping (BoxOfficeData) -> Void) {
        let url = APIURL.apiURL(key: APIKey.apiKey, targetDate: date)
        AF.request(url).responseDecodable(of: BoxOfficeData.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(response.response?.statusCode ?? 0)
                print(error)
            }
        }
    }
}
