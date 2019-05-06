//
//  ChartCell.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/29/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit

class ChartCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var symbol : String?
    var link : DetailController?
    let temp = ["Display Data for 1 Day","Display Data for 1 Month", "Display Data for 3 Months","Display Data for 6 Months", "Display Data for Year to Day", "Display Data for 1 Year", "Display Data for 2 Year", "Display Data for 5 Year"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttoncell", for: indexPath) as! ButtonCell
        cell.button.tag = indexPath.item
        cell.button.setTitle(temp[indexPath.item], for: UIControlState())
        cell.button.addTarget(self, action: #selector(self.handlePress(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func handlePress(sender: UIButton) {
        link?.navigationController?.navigationBar.prefersLargeTitles = false
        link?.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        switch sender.tag {
        case 0:
            let cc = Day1Chart()
            cc.hidesBottomBarWhenPushed = true
            cc.view.backgroundColor = .white
            cc.symbol = self.symbol!
            cc.weekhigh = (link?.quote?.week52High)!
            cc.weeklow = (link?.quote?.week52Low)!
            cc.range = sender.tag
            cc.title = sender.title(for: UIControlState())
            self.link?.navigationController?.pushViewController(cc, animated: true)
        case 1,2,3,4,5,6,7:
            let tt = AllChart()
            tt.hidesBottomBarWhenPushed = true
            tt.view.backgroundColor = .white
            tt.symbol = self.symbol!
            tt.weekhigh = (link?.quote?.week52High)!
            tt.weeklow = (link?.quote?.week52Low)!
            tt.range = sender.tag
            tt.title = sender.title(for: UIControlState())
            link?.navigationController?.pushViewController(tt, animated: true)
        default:
            print("Button Error")
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)
        let collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: flowLayout)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "buttoncell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
