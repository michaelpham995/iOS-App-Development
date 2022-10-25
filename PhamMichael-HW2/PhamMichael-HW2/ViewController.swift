//
//  ViewController.swift
//  PhamMichael-HW2
//
//  Created by Pham, Michael on 9/9/22.
//
//Project: PhamMichael-HW2
//EID: mp46987
//Course: CS329E

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userIDField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let username = userIDField.text!
        let password = passwordField.text!
        let message = username + " logged in"
        
        if username != "" && password != ""{
            statusLabel.text = message
        }
        else{
            statusLabel.text = "Invalid login"
        }
        
        }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    }
    


