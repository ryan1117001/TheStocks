//
//  CustomTabBar.swift
//  
//
//  Created by Ryan Hua on 4/22/18.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar(){
        
        //Splits between four different view controllers that show different view controllers
        let firstCtr = PortfolioController()
        firstCtr.title = "Portfolio"
        let firstNav = UINavigationController(rootViewController: firstCtr)
        firstNav.title = "Portfolio"
        firstNav.tabBarItem.image = #imageLiteral(resourceName: "portfolio")
        
        
        let secondCtr = MarketController()
        secondCtr.title = "Market"
        secondCtr.getAllMarket()
        let secondNav = UINavigationController(rootViewController: secondCtr)
        secondNav.title = "Market"
        secondNav.tabBarItem.image = #imageLiteral(resourceName: "chart")
        
        
        let thirdCtr = SearchController()
        thirdCtr.getAllSymbols()
        thirdCtr.title = "Search"
        let thirdNav = UINavigationController(rootViewController: thirdCtr)
        thirdNav.title = "Search"
        thirdNav.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        viewControllers = [firstNav, secondNav, thirdNav]
        
        tabBar.isTranslucent = false
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

let imageCache = NSCache<NSString, AnyObject>()

// download from https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func downloadImageUsingCacheWithLink(_ urlLink: String){
        self.image = nil
        
        if urlLink.isEmpty {
            return
        }
        // check cache first
        if let cachedImage = imageCache.object(forKey: urlLink as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // otherwise, download
        let url = URL(string: urlLink)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let err = error {
                print(err)
                return
            }
            DispatchQueue.main.async {
                if let newImage = UIImage(data: data!) {
                    imageCache.setObject(newImage, forKey: urlLink as NSString)
                    
                    self.image = newImage
                }
            }
        }).resume()
        
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
