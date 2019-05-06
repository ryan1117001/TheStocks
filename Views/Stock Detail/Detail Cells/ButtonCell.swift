//
//  ButtonCell.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/29/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: UIControlState())
        return button
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(button)
        
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
}
