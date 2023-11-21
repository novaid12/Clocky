//
//  AddAlarmButtonTableViewCell.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import UIKit

class AddAlarmButtonTableViewCell: UITableViewCell {

    static let identifier = "addAlarmButtonTableViewCell"
    
    let mySwitch = UISwitch()

    let titleLabel:UILabel = {
       let myLabel = UILabel()
        
        return myLabel
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = mySwitch
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
     
            make.top.bottom.equalTo(self)
        
            make.leading.equalTo(self).offset(14)
        }
    }
    //    @objc func switchChanged(_ sender : UISwitch!){
    //        print("table row switch Changed \(sender.tag)")
    //        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    //    }
}
