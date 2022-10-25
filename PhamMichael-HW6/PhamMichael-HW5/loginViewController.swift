//
//  loginViewController.swift
//  PhamMichael-HW5
//
//  Created by Michael Pham on 10/18/22.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userIDField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        confirmPasswordField.isHidden = true
        confirmPasswordLabel.isHidden = true
        signInBtn.setTitle("Sign in", for: .normal)
        statusLabel.text = ""
        
        Auth.auth().addStateDidChangeListener(){
            auth, user in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.userIDField.text = nil
                self.passwordField.text = nil
                self.confirmPasswordField.text = nil
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userIDField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        statusLabel.text = ""
    }
    
    //When user touches outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func chooseSegment(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            confirmPasswordLabel.isHidden = true
            confirmPasswordField.isHidden = true
            signInBtn.setTitle("Sign in", for: .normal)
            break
        case 1:
            confirmPasswordField.isHidden = false
            confirmPasswordLabel.isHidden = false
            signInBtn.setTitle("Sign up", for: .normal)
            break
        default:
            break
        }
    
        
        
    }
    
    @IBAction func signInBtnPress(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0{
            userSignIn()
        } else{
            userSignUp()
        }
    }
    
    
    func userSignIn(){
        let username = userIDField.text!
        let password = passwordField.text!
        Auth.auth().signIn(withEmail: username, password:password){
            authResult, error in
            if let error = error as NSError?{
                self.statusLabel.text = "\(error.localizedDescription)"
            } else{
                self.statusLabel.text = "You have signed in successfully!"
            }
        }
    }
    
    
    func userSignUp(){
        let username = userIDField.text!
        let password = passwordField.text!
        let confirmPassword = confirmPasswordField.text!
        if (password == confirmPassword){
            Auth.auth().createUser(withEmail: username, password: password){
                authResult, error in
                if let error = error as NSError?{
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else{
                    self.statusLabel.text = "Account has been created!"
                }
            }
        } else{
            statusLabel.text = "Password and confirmed password does not match."
        }
    }
    
}
