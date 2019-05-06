//
//  DetailController.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit
import Firebase

class DetailController: UITableViewController {
    var symbol : String?
    var company : Company?
    var quote : Quote?
    var user : User?
    //var price : Float?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        tableView.showsVerticalScrollIndicator = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    /*
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
 */
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 250
        }
        else if (indexPath.row == 1){
            return 410
        }
        else if (indexPath.row == 2) {
            return 50
        }
        else {
            return 180
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = CompanyCell(style: .default, reuseIdentifier: "cellid")
            //print(company!)
            if (company?.companyName == nil) {
                cell.companyNameLabel.text = "N/A"
            }
            else {
                cell.companyNameLabel.text = company?.companyName
            }
            if (company?.exchange == nil) {
                cell.exchangeLabel.text = "N/A"
            }
            else {
                cell.exchangeLabel.text = "Exchange: " + (company?.exchange!)!
            }
            if (company?.industry == nil) {
                cell.industryLabel.text = "N/A"
            }
            else {
                cell.industryLabel.text = "Industry: " + (company?.industry!)!
            }
            if (company?.CEO == nil) {
                cell.CEOLabel.text = "N/A"
            }
            else {
                cell.CEOLabel.text = "CEO: " + (company?.CEO!)!
            }
            if (company?.description == nil) {
                cell.descriptionLabel.text = "N/A"
            }
            else {
                cell.descriptionLabel.text = company?.description!
            }
            cell.portButton.addTarget(self, action: #selector(self.handleAdd(sender:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        else if (indexPath.row == 1) {
            let cell = QuoteCell(style: .default, reuseIdentifier: "quotecellid")
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            if (quote!.open == nil) {
                cell.openLabel.text = "Open: N/A"
            }
            else {
                cell.openLabel.text = "Open: " + String(format: "%.2f", (quote?.open)!)
            }
            if (quote!.close == nil) {
                cell.closeLabel.text = "Close: N/A"
            }
            else {
                cell.closeLabel.text = "Close: " + String(format: "%.2f", (quote?.close)!)
            }
            if (quote!.high == nil) {
                cell.highLabel.text = "High: N/A"
            }
            else {
                cell.highLabel.text = "High: " + String(format: "%.2f", (quote?.high)!)
            }
            if (quote!.low == nil) {
                cell.lowLabel.text = "Low: N/A"
            }
            else {
                cell.lowLabel.text = "Low: " + String(format: "%.2f", (quote?.low)!)
            }
            if (quote!.latestPrice == nil) {
                cell.priceLabel.text = "Price: N/A"
            }
            else {
                cell.priceLabel.text = "Price: " + String(format: "%.2f", (quote?.latestPrice)!)
            }
            if (quote!.latestTime == nil) {
                cell.timeLabel.text = "Time: N/A"
            }
            else {
                cell.timeLabel.text = "Time: " + (quote?.latestTime)!
            }
            if (quote!.latestVolume == nil) {
                cell.volumeLabel.text = "Volume: N/A"
            }
            else {
                cell.volumeLabel.text = "Volume: " + nf.string(from: NSNumber(value: (quote?.latestVolume)!))!
            }
            if (quote!.change == nil) {
                cell.changeLabel.text = "Change: N/A"
            }
            else {
                cell.changeLabel.text = "Change: " + String(format: "%.2f", (quote?.change)!)
            }
            if (quote!.changePercent == nil) {
                cell.volumeLabel.text = "Change Percentage: N/A"
            }
            else {
                cell.changePercentLabel.text = "Change Percentage: " + String(format: "%.2f", (quote?.changePercent)! * 100) + "%"
            }
            if (quote!.iexMarketPercent == nil) {
                cell.marketPercentLabel.text = "Market Percentage: N/A"
            }
            else {
                cell.marketPercentLabel.text = "Market Percentage: " + String(format: "%.2f", (quote?.iexMarketPercent)! * 100) + "%"
            }
            if (quote!.marketCap == nil) {
                cell.marketCapLabel.text = "Market Cap: N/A"
            }
            else {
                cell.marketCapLabel.text = "Market Cap: " + nf.string(from: NSNumber(value: (quote?.marketCap)!))!
            }
            if (quote!.peRatio == nil) {
                cell.peRatioLabel.text = "PE Ratio: N/A"
            }
            else {
                cell.peRatioLabel.text = "PE Ratio: " + String(format: "%.2f", (quote?.peRatio)!)
            }
            if (quote!.week52High == nil) {
                cell.week52HighLabel.text = "Week 52 High: N/A"
            }
            else {
                cell.week52HighLabel.text = "Week 52 High: " + String(format: "%.2f", (quote?.week52High)!)
            }
            if (quote!.week52Low == nil) {
                cell.week52LowLabel.text = "Week 52 Low: N/A"
            }
            else {
                cell.week52LowLabel.text = "Week 52 Low: " + String(format: "%.2f", (quote?.week52Low)!)
            }
            if (quote!.ytdChange == nil) {
                cell.ytdChangeLabel.text = "TD Change: N/A"
            }
            else {
                cell.ytdChangeLabel.text = "YTD Change: " + String(format: "%.2f", (quote?.ytdChange)!)
            }
            cell.selectionStyle = .none
            return cell
        }
        else if (indexPath.row == 2) {
            let cell = ChartCell(style: .default, reuseIdentifier: "chartcell")
            cell.symbol = self.symbol!
            cell.link = self
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = CalculateCell(style: .default, reuseIdentifier: "calcell")
            guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
                print("no auth")
                return cell
            }
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    let user = User(dictionary: dictionary)
                    self.user = user
                    cell.result.text = user.funding
                }
            })
            cell.sellButton.addTarget(self, action: #selector(self.handlesell(sender:)), for: .touchUpInside)
            cell.buyButton.addTarget(self, action: #selector(self.handlebuy(sender:)), for: .touchUpInside)
            cell.confirmButton.addTarget(self, action: #selector(self.handleconfirm(sender:)), for: .touchUpInside)
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    @objc func handleAdd(sender: UIButton) {
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        hideKeyboard()
        let ref = Database.database().reference()
        let currentCell = sender.superview?.superview as! CompanyCell
        let userRef = ref.child("users").child(uid)
        let cleansymbol = symbol!.replacingOccurrences(of: ".", with: "@")
        let values = ["company" : currentCell.companyNameLabel.text, "symbol" : symbol!] as [String: AnyObject]
        userRef.child("portfolio").child(cleansymbol).updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print (err ?? "")
                return
            }
        })
    }
    @objc func handleconfirm(sender: UIButton) {
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        hideKeyboard()
        let currentCell = sender.superview?.superview as! CalculateCell
        let ref = Database.database().reference()
        let userRef = ref.child("users").child(uid)
        let values = ["funding" : currentCell.result.text] as [String : AnyObject]
        userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err ?? "")
                return
            }
        })
        tableView.reloadData()
    }
    @objc func handlesell(sender :UIButton) {
        let currentCell = sender.superview?.superview as! CalculateCell
        if (isStringAnFloat(string: currentCell.sharenumber.text!)) {
            currentCell.result.text = String(format: "%.2f", (Float(currentCell.sharenumber.text!)! * (quote?.latestPrice!)!) + Float(user!.funding!)!)
        }
        else {
            print("error")
            return
        }
    }
    @objc func handlebuy(sender :UIButton) {
        let currentCell = sender.superview?.superview as! CalculateCell
        if (isStringAnFloat(string: currentCell.sharenumber.text!)) {
            currentCell.result.text = String(format: "%.2f", Float(user!.funding!)! - (Float(currentCell.sharenumber.text!)! * (quote?.latestPrice!)!))
        }
        else {
            print("error")
            return
        }
    }
    func isStringAnFloat(string: String) -> Bool {
        return Float(string) != nil
    }
    func downloadStock(completed: @escaping() -> () ) {
        let url = URL(string:"https://api.iextrading.com/1.0/stock/\(symbol!)/company")
        URLSession.shared.dataTask(with: url!) {
            (data,response,error) in
            if error == nil {
                guard let jsondata = data else {return}
                do {
                    self.company = try JSONDecoder().decode(Company.self, from: jsondata)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Stock Downloading Error!")
                }
            }
            } .resume()
    }
    func downloadQuote(completed: @escaping() -> () ) {
        let url = URL(string:"https://api.iextrading.com/1.0/stock/\(symbol!)/quote")
        URLSession.shared.dataTask(with: url!) {
            (data,response,error) in
            if error == nil {
                guard let jsondata = data else {return}
                do {
                    self.quote = try JSONDecoder().decode(Quote.self, from: jsondata)
                    //print(self.quote!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Quote Downloading Error!")
                }
            }
            } .resume()
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
