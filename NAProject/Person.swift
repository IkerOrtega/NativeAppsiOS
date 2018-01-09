//
//  Person.swift
//  NAProject
//
//  Created by Iker on 07/01/2018.
//  Copyright © 2018 Iker. All rights reserved.
//

import UIKit

class Person: NSObject,NSCoding {
    var name: String
    var image: String
    var phone: String
    var email : String
    
    init(name: String, image: String, phone: String, email: String) {
        self.name = name
        self.image = image
        self.phone = phone
        self.email = email
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
        phone = aDecoder.decodeObject(forKey: "phone") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(email, forKey: "email")
    }
     
}
