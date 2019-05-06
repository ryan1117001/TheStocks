//
//  DetailCell.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class QuoteCell: UITableViewCell {
    
    let keyStatLabel:UILabel = {
        let label = UILabel()
        label.text = "Key Statistics"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let openLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let closeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let highLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lowLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let volumeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let changeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let changePercentLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let marketPercentLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let marketCapLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let peRatioLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let week52HighLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let week52LowLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ytdChangeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(keyStatLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(openLabel)
        contentView.addSubview(closeLabel)
        contentView.addSubview(highLabel)
        contentView.addSubview(lowLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(volumeLabel)
        contentView.addSubview(changeLabel)
        contentView.addSubview(changePercentLabel)
        contentView.addSubview(marketPercentLabel)
        contentView.addSubview(marketCapLabel)
        contentView.addSubview(peRatioLabel)
        contentView.addSubview(week52HighLabel)
        contentView.addSubview(week52LowLabel)
        contentView.addSubview(ytdChangeLabel)
        
        keyStatLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        keyStatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        keyStatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        keyStatLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: keyStatLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        openLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        openLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        openLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        openLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        closeLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 5).isActive = true
        closeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        closeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        closeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        closeLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 5).isActive = true
        closeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        closeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        closeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        highLabel.topAnchor.constraint(equalTo: closeLabel.bottomAnchor, constant: 5).isActive = true
        highLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        highLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        highLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 5).isActive = true
        lowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        lowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        lowLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        volumeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        volumeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        volumeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        volumeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        changeLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 5).isActive = true
        changeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        changeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        changeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        changePercentLabel.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 5).isActive = true
        changePercentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        changePercentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        changePercentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        marketPercentLabel.topAnchor.constraint(equalTo: changePercentLabel.bottomAnchor, constant: 5).isActive = true
        marketPercentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        marketPercentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        marketPercentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        marketCapLabel.topAnchor.constraint(equalTo: marketPercentLabel.bottomAnchor, constant: 5).isActive = true
        marketCapLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        marketCapLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        marketCapLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        peRatioLabel.topAnchor.constraint(equalTo: marketCapLabel.bottomAnchor, constant: 5).isActive = true
        peRatioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        peRatioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        peRatioLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        week52HighLabel.topAnchor.constraint(equalTo: peRatioLabel.bottomAnchor, constant: 5).isActive = true
        week52HighLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        week52HighLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        week52HighLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        week52LowLabel.topAnchor.constraint(equalTo: week52HighLabel.bottomAnchor, constant: 5).isActive = true
        week52LowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        week52LowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        week52LowLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        ytdChangeLabel.topAnchor.constraint(equalTo: week52LowLabel.bottomAnchor, constant: 5).isActive = true
        ytdChangeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        ytdChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        ytdChangeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
