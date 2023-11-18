//
//  AppDelegate.swift
//  Clocky
//
//  Created by  NovA on 25.10.23.
//

import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    private var audioPlayer: AVAudioPlayer?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if AuthManager.shared.isSignedIn {
            AuthManager.shared.refreshIfNeeded(completion: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            let navigationController = UINavigationController(rootViewController: initialViewController)
            
            self.navigationController = navigationController
            window.rootViewController = navigationController
            
            
        } else {
            let storyboard = UIStoryboard(name: "WelcomeStoryboard", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeVC")
            let navigationController = UINavigationController(rootViewController: initialViewController)
            
            self.navigationController = navigationController
            window.rootViewController = navigationController
        }
        window.makeKeyAndVisible()
        self.window = window
        
        let current = UNUserNotificationCenter.current()
        current.delegate = self
        current.requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { granted, error in
            if granted {
                print("yes")
            }
            else {
                print("no")
            }
        })
        
        return true
    }
    
    func switchToLoginScreen() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "WelcomeStoryboard", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeVC")
        window.rootViewController = initialViewController
        UIApplication.shared.windows.first?.rootViewController = initialViewController
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme.localizedCaseInsensitiveCompare("myAppClocky") == .orderedSame {
            // обработайте возвращение пользователя после авторизации Spotify здесь
            
            return true
        }
        return false
    }
    
    deinit {
        print("deinit AppDelegate")
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    //app在前台也會通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
    
    //點選通知完成後會發生的事
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
