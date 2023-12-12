//
//  GetTrackService.swift
//  Clocky
//
//  Created by  NovA on 11.12.23.
//

import Alamofire
import Foundation
import SafariServices

class GetTrackService {
    public static func getRecommendations(token: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        let genres = ["acoustic", "afrobeat", "alt-rock", "alternative", "ambient", "anime", "black-metal", "bluegrass", "blues",
                      "bossanova", "brazil", "breakbeat", "british", "cantopop", "chicago-house", "children", "chill", "classical",
                      "club", "comedy", "country", "dance", "dancehall", "death-metal", "deep-house", "detroit-techno", "disco",
                      "disney", "drum-and-bass", "dub", "dubstep", "edm", "electro", "electronic", "emo", "folk", "forro", "french",
                      "funk", "garage", "german", "gospel", "goth", "grindcore", "groove", "grunge", "guitar", "happy", "hard-rock",
                      "hardcore", "hardstyle", "heavy-metal", "hip-hop", "holidays", "honky-tonk", "house", "idm", "indian", "indie",
                      "indie-pop", "industrial", "iranian", "j-dance", "j-idol", "j-pop", "j-rock", "jazz", "k-pop", "kids", "latin",
                      "latino", "malay", "mandopop", "metal", "metal-misc", "metalcore", "minimal-techno", "movies", "mpb", "piano",
                      "pop", "pop-film", "post-dubstep", "power-pop", "progressive-house", "psych-rock", "rainy-day", "reggae", "reggaeton",
                      "road-trip", "rock", "rock-n-roll", "rockabilly", "romance", "sad", "salsa", "samba", "sertanejo", "show-tunes", "singer-songwriter", "ska", "sleep", "songwriter", "soul", "soundtracks", "spanish", "study", "summer",
                      "swedish", "synth-pop", "tango", "techno", "trance", "trip-hop", "turkish", "work-out", "world-music", "punk",
                      "punl-rock", "new-release", "new-age", "opera", "pagode", "party"]

        var seeds: [String] = []
        while seeds.count < 5 {
            if let random = genres.randomElement() {
                seeds.append(random)
            }
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        let url = "https://api.spotify.com/v1/recommendations?limit=1&seed_genres=\(seeds.joined(separator: ","))"

        AF.request(url, method: .get, headers: headers).response { response in
            switch response.result {
            case .success(let data):
//                let result = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                let result = try? JSONDecoder().decode(RecommendationsResponse.self, from: data!)
                let id = result?.tracks[0].preview_url.description
                completion(.success(id!))
            case .failure(let error):
                print("Не удалось выйти из аккаунта Spotify: \(error)")
                completion(.failure(error))
            }
        }
    }

    public static func getTrack(token: String, id: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        let url = "https://api.spotify.com/v1/tracks/\(id)"

        AF.request(url, method: .get, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                let result = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                let result = try? JSONDecoder().decode(RecommendationsResponse.self, from: data!)
//                let id = result?.tracks[0].id.description
//                completion(.success(id!))
                print(result)
            case .failure(let error):
                print("Не удалось выйти из аккаунта Spotify: \(error)")
                completion(.failure(error))
            }
        }
    }
}
