//
//  Products.swift
//  Green Leaf
//
//  Created by Muhammad Noaman on 05/04/2018.
//  Copyright © 2018 MnSoftech. All rights reserved.
//

import UIKit

class Products: NSObject {
    var productName : String?
    var productPrice : String?
    var productImage : String?
    
    init(dic : [String : Any]) {
        
        self.productName = dic["ProductName"] as? String
        self.productPrice = dic["Price"] as? String
        self.productImage = dic["ProductImage"] as? String
        
    }
    
    
}
