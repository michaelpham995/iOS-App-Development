//
//  AddTimerViewController.swift
//  PhamMichael-HW7
//
//  Created by Michael Pham on 10/24/22.
//

import UIKit

protocol newTimerInfo{
    func newTimer(event: String, location: String, timeCount: Int32)
}

class AddTimerViewController: UIViewController {

    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    var delegate: newTimerInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if let event = eventTextField.text,
           let location = locationTextField.text,
           let timeCount = Int32(timeTextField.text!) {
            if timeCount >= 0{
                delegate?.newTimer(event: event, location: location, timeCount: timeCount)
                self.navigationController?.popViewController(animated: true)
            }
            else{
                let alert = UIAlertController(title: "Input is invalid",
                                              message: "Time must be >= 0",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay!", style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }   else {
            let alert = UIAlertController(title: "Missing Info",
                                          message: "All fields are required",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func returnTextField(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
