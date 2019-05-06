//
//  TableViewController.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit
import Firebase

class MarketController: UITableViewController {
    var market = [Market]()
    var filteredmarket = [Market]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Name of Exchange"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(MarketCell.self, forCellReuseIdentifier: "cellid")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredmarket.count
        }
        return market.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MarketCell(style: .default, reuseIdentifier: "cellid")

        let temp: Market
        
        if isFiltering() {
            temp = filteredmarket[indexPath.row]
        }
        else {
            temp = market[indexPath.row]
        }
        cell.venueName.text = temp.venueName
        cell.mic.text = "Mic: " + temp.mic
        cell.tapeId.text = "TapeId: " + temp.tapeId
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        cell.tapeA.text = "TapeA: " + nf.string(from: NSNumber(value: temp.tapeA))!
        cell.tapeB.text = "TapeB: " + nf.string(from: NSNumber(value: temp.tapeB))!
        cell.tapeC.text = "TapeC: " + nf.string(from: NSNumber(value: temp.tapeC))!
        cell.marketPercent.text = "Market Percentage: " + String(format: "%.2f", temp.marketPercent * 100) + "%"
        cell.selectionStyle = .none
        return cell
    }
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent != nil && self.navigationItem.titleView == nil {
            fetchUserAndSetupNavBarTitle()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchUserAndSetupNavBarTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 40, g: 203, b: 213)
    }
    func getAllMarket() {
        Market.allMarket { (market, error) in
            if let error = error {
                // got an error in getting the data
                print(error)
                return
            }
            guard let market = market else {
                print("error getting all todos: result is nil")
                return
            }
            // success :)
            //debugPrint(symbols)
            //print("market json sucessfully downloaded")
            self.market = market
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredmarket = market.filter({( market : Market) -> Bool in
            return market.venueName.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        
        // fetch User info! Set up Navigation Bar!
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //                self.navigationItem.title = dictionary["name"] as? String
                
                let user = User(dictionary: dictionary)
                self.setupNavBarWithUser(user)
            }
            
        }, withCancel: nil)
    }
    
    func setupNavBarWithUser(_ user: User) {
        
        let titleView = TitleView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        
        self.navigationItem.titleView = titleView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        titleView.isUserInteractionEnabled = true
        
        titleView.addGestureRecognizer(tap)
        
        if let profileImageUrl = user.profileurl {
            titleView.profileImageView.downloadImageUsingCacheWithLink(profileImageUrl)
        }
        titleView.nameLabel.text = user.username
        tableView.reloadData()
    }
    
    @objc func logout() {
        // Sign-out!!!
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let lc = LoginController()
        self.present(lc, animated: true, completion: nil)
    }
    // When NavBar TitleView is Tapped!!! Edit User Profile!!!
    @objc private func handleTap(){
        //print("Tapped")
        
        let profileController = ProfileController()
        
        profileController.fetchProfile()
        
        navigationController?.pushViewController(profileController, animated: true)
    }
    
}
extension MarketController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
