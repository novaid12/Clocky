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
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
    }

    @IBAction func signOutBtn() {
        AuthManager.shared.logOutAccount()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.switchToLoginScreen()
    }

    deinit {
        print("deinit ProfileVC")
    }

    private func setupUI(model: UserProfile?) {
        guard let model = model, let image = model.images else { return }
        email.text = model.email
        country.text = model.country
        name.text = model.display_name
        guard image.count != 0 ,let url = image[image.count - 1].url else { return }

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
