//
//  AlarmLabelVC.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import UIKit

class AlarmLabelVC: UIViewController,UITextFieldDelegate {

    
    //MARK: - UI
    let textField:UITextField = {
       let myTextField = UITextField()
//        myTextField.backgroundColor = #colorLiteral(red: 0.1734634042, green: 0.1683282256, blue: 0.1771324873, alpha: 1)
        myTextField.returnKeyType = .done
        myTextField.clearButtonMode = .whileEditing
        myTextField.borderStyle = .roundedRect
        return myTextField
    }()
    
    weak var labelDelegate:UpdateAlarmLabelDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
            
            if let text = textField.text {
                if text == "" {
                    labelDelegate?.updateAlarmLabel(alarmLabelText: "Alarm")
                }else {
                    labelDelegate?.updateAlarmLabel(alarmLabelText: text)
                }
            }
        }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        textField.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
            
    //MARK: - SetupUI
    func setupUI(){
        
        navigationController?.navigationBar.tintColor = .orange
        
        self.title = "Lebal"
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view).offset(-120)
            make.height.equalTo(45)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
}
