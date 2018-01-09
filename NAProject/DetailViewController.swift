//
//  DetailViewController.swift
//  NAProject


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var phone : UILabel!
    @IBOutlet weak var email : UILabel!
    
    var pImage : UIImage!
    var pName = ""
    var pPhone = ""
    var pEmail = ""
    
    
    override func viewDidLoad() {
        image.image = pImage
        name.text = pName
        phone.text = pPhone
        email.text = pEmail
        super.viewDidLoad()
         
        image.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        image.layer.borderWidth = 2
        image.layer.cornerRadius = 3
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
}

}
