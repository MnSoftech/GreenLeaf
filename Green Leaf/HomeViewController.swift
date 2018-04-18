//
//  HomeViewController.swift
//  Green Leaf
//
//  Created by Muhammad Noaman on 13/03/2018.
//  Copyright © 2018 MnSoftech. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var ref : DatabaseReference!
    
    var productName = [String]()
    var productPrice = [String]()
    var productImage = [UIImage]()
    var products = [Products]()
    let array = ["1", "1"]
    
    
    //let productImage = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.searchBar.backgroundImage = UIImage()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        sideMenu()
        loadData()
       
    }

    func loadData() {
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.hasChild("Products") {
                
                let pRef = self.ref.child("Products")
                pRef.observe(.childAdded, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let prod = Products(dic: dictionary)
                        self.products.append(prod)
                        
                        //this will crash because of background thread, so lets use dispatch_async to fix
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
                        })
                    }
                    
                }, withCancel: nil)

                    
                    
                    self.tableView.reloadData()
                
            }else {
               print("No Products Available")
            }
            
        })
        
    }
    
        
        
    func sideMenu() {
        if revealViewController() != nil {
            
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
 
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
        
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! itemCell
        
        let rProducts = products[indexPath.row]
        cell.productLabel?.text = rProducts.productName
        cell.priceLabel?.text = rProducts.productPrice
        
        if let profileImageUrl = rProducts.productImage {
            cell.thumbImage.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
   
}

