//
//  MarketCell.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class MarketCell: UITableViewCell {
    let venueName:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let mic:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tapeId:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tapeA:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tapeB:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tapeC:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let marketPercent:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(venueName)
        contentView.addSubview(mic)
        contentView.addSubview(tapeId)
        contentView.addSubview(tapeA)
        contentView.addSubview(tapeB)
        contentView.addSubview(tapeC)
        contentView.addSubview(marketPercent)
        
        venueName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        venueName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        venueName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        mic.topAnchor.constraint(equalTo: venueName.bottomAnchor, constant: 5).isActive = true
        mic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        mic.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tapeId.topAnchor.constraint(equalTo: mic.bottomAnchor, constant: 5).isActive = true
        tapeId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        tapeId.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tapeA.topAnchor.constraint(equalTo: tapeId.bottomAnchor, constant: 5).isActive = true
        tapeA.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        tapeA.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tapeB.topAnchor.constraint(equalTo: tapeA.bottomAnchor, constant: 5).isActive = true
        tapeB.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        tapeB.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tapeC.topAnchor.constraint(equalTo: tapeB.bottomAnchor, constant: 5).isActive = true
        tapeC.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        tapeC.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        marketPercent.topAnchor.constraint(equalTo: tapeC.bottomAnchor, constant: 5).isActive = true
        marketPercent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        marketPercent.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
