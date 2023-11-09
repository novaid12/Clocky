//
//  ApiCaller.swift
//  Clocky
//
//  Created by  NovA on 8.11.23.
//

import UIKit
import Alamofire

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    enum Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case faileedToGetData
    }
    
    public func getCurrentUserProfile() {
        
        
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return }
        
        var headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]

        var url = "https://api.spotify.com/v1/me"
        AF.request(url, method: .get, headers: headers)
            .response { [weak self] response in
                switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    do {
                        let value = try JSONDecoder().decode(UserProfile.self, from: data)
                        print(value)
                    }
                    catch (let decoderError) {
                        print(decoderError.localizedDescription)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}

