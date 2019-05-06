//
//  CalculateCell.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/30/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class CalculateCell: UITableViewCell {
    let calLabel:UILabel = {
        let label = UILabel()
        label.text = "Calculate Buy or Sell"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sharenumber:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Number of shares"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let result: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let sellButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 107, g: 218, b: 115)
        button.setTitle("Sell", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: UIControlState())
        return button
    }()
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 107, g: 218, b: 115)
        button.setTitle("Buy", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: UIControlState())
        return button
    }()
    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("Confirm", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: UIControlState())
        return button
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(calLabel)
        contentView.addSubview(confirmButton)
        contentView.addSubview(sellButton)
        contentView.addSubview(buyButton)
        contentView.addSubview(sharenumber)
        contentView.addSubview(result)
        contentView.addSubview(confirmButton)
        
        calLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        calLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        calLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        calLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sharenumber.topAnchor.constraint(equalTo: calLabel.bottomAnchor, constant: 5).isActive = true
        sharenumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        sharenumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        sharenumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sellButton.topAnchor.constraint(equalTo: sharenumber.bottomAnchor, constant: 5).isActive = true
        sellButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        sellButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -2.5).isActive = true
        sellButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        buyButton.topAnchor.constraint(equalTo: sharenumber.bottomAnchor, constant: 5).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 2.5).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        result.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 5).isActive = true
        result.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        result.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        result.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        confirmButton.topAnchor.constraint(equalTo: result.bottomAnchor, constant: 5).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
