//
//  AddAlarmTVC.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import UIKit
import SnapKit

class AddAlarmTableViewCell: UITableViewCell {
    static let identifier = "AddAlarmTableViewCell"
    
    // MARK: - setupUI

    let titleLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        return myLabel
    }()
    
    let contentLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .lightGray
        return myLabel
    }()

    let detailImageView: UIImageView = {

        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
  
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.accessoryView = detailImageView
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(contentLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(14)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-50)
        }
    }
}
