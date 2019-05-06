//
//  PortfolioController.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/24/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit
import Firebase

class PortfolioController: UITableViewController {
    var count = 0
    var portfolio = [Portfolio]()
    var filteredPortfolio = [Portfolio]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCount()
        fetchPortfolio()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Your Portfolio"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(SearchCell.self, forCellReuseIdentifier: "cellid")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
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
            return filteredPortfolio.count
        }
        return portfolio.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 145, g: 208, b: 90)
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchCount()
        fetchPortfolio()
        fetchUserAndSetupNavBarTitle()
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PortfolioCell(style: .default, reuseIdentifier: "cellid")
        var port : Portfolio
        if isFiltering() {
            port = filteredPortfolio[indexPath.row]
        }
        else {
            port = portfolio[indexPath.row]
        }
        cell.symbol.text = port.symbol
        if (port.company == "") {
            cell.name.text = "N/A"
        }
        else {
            cell.name.text = port.company
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! PortfolioCell
        let dc = DetailController()
        dc.view.backgroundColor = .white
        dc.title = currentCell.symbol.text
        dc.symbol = currentCell.symbol.text
        dc.downloadStock {
            dc.downloadQuote {
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                self.tableView.reloadData()
                self.navigationController?.pushViewController(dc, animated: true)
            }
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let uid = Auth.auth().currentUser?.uid else{
                return
            }
            let currentcell = tableView.cellForRow(at: indexPath) as! PortfolioCell
            tableView.beginUpdates()
            let cleansymbol = currentcell.symbol.text!.replacingOccurrences(of: ".", with: "@")
            let ref = Database.database().reference().child("users").child(uid).child("portfolio").child(cleansymbol)
            portfolio.remove(at: indexPath.row)
            ref.removeValue()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func fetchCount() {
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.hasChild("portfolio") {
                ref.child("portfolio").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.count = Int(snapshot.childrenCount)
                    //print(self.count)
                })
            }
            else {
                self.count = 0
            }
        })
    }
    func fetchPortfolio() {
        portfolio.removeAll()
        filteredPortfolio.removeAll()
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users").child(uid!)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.hasChild("portfolio") {
                ref.child("portfolio").observeSingleEvent(of: .value, with: {(snapshot) in
                    for rest in snapshot.children.allObjects as! [DataSnapshot] {
                            guard let restDict = rest.value as? [String : AnyObject] else {continue}
                            let other = Portfolio(dictionary: restDict)
                            self.portfolio.append(other)
                    }
                    self.tableView.reloadData()
                })
            }
        })
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPortfolio = portfolio.filter({( temp : Portfolio) -> Bool in
            return temp.symbol!.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
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
    
    // When NavBar TitleView is Tapped!!! Edit User Profile!!!
    @objc private func handleTap(){
        //print("Tapped")
        
        let profileController = ProfileController()
        
        profileController.fetchProfile()
        
        navigationController?.pushViewController(profileController, animated: true)
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
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent != nil && self.navigationItem.titleView == nil {
            fetchUserAndSetupNavBarTitle()
        }
    }

}

extension PortfolioController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
