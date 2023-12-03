//
//  MusicTrimmedService.swift
//  Clocky
//
//  Created by  NovA on 3.12.23.
//

import AudioKit
import AVFoundation
import Foundation
import NotificationCenter
import UserNotifications

class MusicService {
    static func exportTrimmedAudio(from url: URL, from startTime: TimeInterval, to endTime: TimeInterval, completion: @escaping (URL?) -> Void) {
        let asset = AVURLAsset(url: url)

        let composition = AVMutableComposition()
        let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)

        let timeRange = CMTimeRange(start: CMTime(seconds: startTime, preferredTimescale: asset.duration.timescale),
                                    end: CMTime(seconds: endTime, preferredTimescale: asset.duration.timescale))

        do {
            try audioTrack?.insertTimeRange(timeRange, of: asset.tracks(withMediaType: .audio)[0], at: .zero)
        } catch {
            print("Error trimming audio: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A) else {
            completion(nil)
            return
        }

        let fileManager = FileManager.default
        guard let outputURL = try? FileManager.default.soundsLibraryURL(for: "alarm.m4a") else { return }
        print(outputURL.absoluteString)
        if fileManager.fileExists(atPath: outputURL.path) {
            try? fileManager.removeItem(at: outputURL)
        }

        exportSession.outputFileType = .m4a
        exportSession.outputURL = outputURL
        completion(outputURL)
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                let fileManager = FileManager.default
                guard let newURL = try? FileManager.default.soundsLibraryURL(for: "alarm.mp3") else { return }
                do {
                    try fileManager.moveItem(at: outputURL, to: newURL)
                    print("Файл успешно переименован")
                } catch {
                    print("Ошибка переименования файла: \(error)")
                }
                completion(newURL)
            case .failed:
                print("Export failed")
                completion(nil)
            case .cancelled:
                print("Export cancelled")
                completion(nil)
            default:
                break
            }
        }
    }
}
