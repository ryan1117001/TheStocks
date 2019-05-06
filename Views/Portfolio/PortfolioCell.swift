//
//  PortfolioCell.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class PortfolioCell: UITableViewCell {
    let symbol:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let name:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupViews(){
        
        contentView.addSubview(symbol)
        contentView.addSubview(name)
        
        symbol.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        symbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        symbol.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        name.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 5).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
}
