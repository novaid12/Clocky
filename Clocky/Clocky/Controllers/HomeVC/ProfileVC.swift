//
//  ProfileVC.swift
//  Clocky
//
//  Created by  NovA on 8.11.23.
//

import UIKit

class ProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCaller.shared.getCurrentUserProfile()
    }
}

