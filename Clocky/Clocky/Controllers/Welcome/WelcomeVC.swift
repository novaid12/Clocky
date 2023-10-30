//
//  WelcomeVC.swift
//  Clocky
//
//  Created by  NovA on 30.10.23.
//

import UIKit

class WelcomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
        authVC.complitionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        navigationController?.pushViewController(authVC, animated: true)
    }

    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Oooooops", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
