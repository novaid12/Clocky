//
//  ProfileVC.swift
//  Clocky
//
//  Created by  NovA on 8.11.23.
//

import Alamofire
import AlamofireImage
import UIKit

class ProfileVC: UIViewController {
    @IBOutlet var image: UIImageView!
    @IBOutlet var email: UILabel!
    @IBOutlet var country: UILabel!
    @IBOutlet var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCaller.shared.getCurrentToken { [weak self] token in
            ApiCaller.shared.getCurrentUserProfile(token: token) { [weak self] result in
                switch result {
                case .success(let model):
                    self?.setupUI(model: model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    @IBAction func signOutBtn() {
        AuthManager.shared.logOutAccount()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchToLoginScreen()
    }

    deinit {
        print("deinit ProfileVC")
    }

    private func setupUI(model: UserProfile) {
        email.text = model.email
        country.text = model.country
        name.text = model.display_name
        let url = model.images[model.images.count - 1].url

        AF.request(url).responseImage { [weak self] responce in
            switch responce.result {
            case .success(let image):

                self?.image.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
