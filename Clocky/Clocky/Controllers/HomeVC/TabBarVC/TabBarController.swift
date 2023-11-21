//
//  TabBarController.swift
//  Clocky
//
//  Created by  NovA on 30.10.23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabbar()
    }
    
    private func setupTabbar() {
        let alarmNC = UINavigationController(rootViewController: AlarmVC())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
       
        let profileNC = UINavigationController(rootViewController: profileVC)

        alarmNC.tabBarItem.image = UIImage(systemName: "alarm.fill")
        profileNC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")

        alarmNC.title = "Alarm"
        profileNC.title = "Profile"
        
        self.tabBar.barTintColor = .clear
        self.tabBar.tintColor = .orange
        
        setViewControllers([alarmNC, profileNC], animated: false)
       
        alarmNC.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             .font: UIFont.boldSystemFont(ofSize: 34)]
        
        profileNC.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             .font: UIFont.boldSystemFont(ofSize: 34)]
  
    }
    
    deinit {
        print("deinit TabBarVC")
    }
}
