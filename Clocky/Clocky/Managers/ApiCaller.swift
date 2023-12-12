//
//  ApiCaller.swift
//  Clocky
//
//  Created by  NovA on 8.11.23.
//

import Alamofire
import UIKit

final class ApiCaller {
    static let shared = ApiCaller()

    private init() {}

    enum Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }

    enum APIError: Error {
        case faileedToGetData
    }

    public func getCurrentToken(complition: @escaping (String) -> Void) {
        AuthManager.shared.withValidToken { token in
            complition(token)
        }
    }
    public func getCurrentUserProfile(token: String, complition: @escaping (Result<UserProfile, Error>) -> Void) {
          let headers: HTTPHeaders = [
              "Authorization": "Bearer \(token)"
          ]
          let url = "https://api.spotify.com/v1/me"
          AF.request(url, method: .get, headers: headers)
              .response { response in
                  switch response.result {
                  case .success(let data):
                      guard let data = data else { return }
                      do {
                          let value = try JSONDecoder().decode(UserProfile.self, from: data)
  //                        print(value)
                          complition(.success(value))
                      }
                      catch (let decoderError) {
                          print(decoderError.localizedDescription)
                          complition(.failure(decoderError ))
                      }
                  case .failure(let error):
                      print(error)
                  }
              }
      }
    
    
    deinit {
        print("deinit ApiCaller")
    }
}
