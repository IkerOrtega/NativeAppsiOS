//
//  FormViewController.swift
//  NAProject
//
//  Created by Iker on 09/01/2018.
//  Copyright © 2018 Iker. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var nameField : UITextField!
    @IBOutlet weak var phoneField : UITextField!
    @IBOutlet weak var emailField : UITextField!
    
    @IBOutlet weak var finishButton : UIButton!
    
    var name : String! = ""
    var phone : String! = ""
    var email : String! = ""
    
    @IBAction func toMain(sender: UIButton){
        if(nameField.hasText && phoneField.hasText && emailField.hasText){
            name = nameField.text!
            phone = phoneField.text!
            email = emailField.text!
            
            
        performSegue(withIdentifier: "unwindToMain", sender: self)
        } else {
            navigationItem.prompt = "Please fill all the fields!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
