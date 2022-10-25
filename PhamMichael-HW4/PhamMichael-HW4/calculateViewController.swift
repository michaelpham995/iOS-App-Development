// Project: PhamMichael-HW4
// EID: mp46987
// Course: CS 329E
//
//  calculateViewController.swift
//  PhamMichael-HW4
//
//  Created by Michael Pham on 9/23/22.
//

import UIKit

class calculateViewController: UIViewController {
    
    
    
    @IBOutlet weak var operandTwo: UITextField!
    @IBOutlet weak var operandOne: UITextField!
    @IBOutlet weak var labelOperator: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    
    var chosenOperator: String? = "Operator"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelOperator.text = chosenOperator
        operandOne.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Youtube suggestion
    }
    
    
    @IBAction func calculateResult(_ sender: Any)
    {

        
            if let input1 = operandOne.text,
                let input2 = operandTwo.text,
                (Float(input1) != nil), (Float(input2) != nil)
            {
            
                var operand1 = Float(input1)
                var operand2 = Float(input2)
                
                
                if input1.contains("."){
                    var operand1 = Float(input1)
                } else{
                    var operand1 = Int(input1)
                }
                if input2.contains("."){
                    var operand2 = Float(input2)
                } else{
                    var operand2 = Int(input2)
                }
                

                
                switch chosenOperator {
                case "+":
                    labelResult.text = String(operand1! + operand2!)
                case "-":
                    labelResult.text = String(operand1! - operand2!)
                case "*":
                    labelResult.text = String(operand1! * operand2!)
                case "/":
                    if operand2 != 0 {
                        labelResult.text = String((operand1!) / (operand2!))
                    } else {
                        labelResult.text = "Cannot divide by 0!"
                    }
                default:    // This case should never happen
                    labelResult.text = "Invalid operator!"
                }
            } else {
                labelResult.text = "Invalid input(s)!"
            }
            
        }
        

    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
