//  Project: PhamMichael-HW3
//  EID: mp46987
//  Course: CS329E
//
//  ViewController.swift
//  Created by Michael Pham on 9/19/22.
//

import UIKit

protocol TextChanger {
    func changeText(newName: String)
}

protocol ColorChanger {
    func changeColor(chooseColor: UIColor)
}

class ViewController: UIViewController, TextChanger, ColorChanger{

    
    @IBOutlet weak var textField1: UILabel!
    @IBOutlet weak var changeColor: UIButton!
    @IBOutlet weak var changeText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.text = "Text goes here"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "textSegueIdentifier",
           let otherName = segue.destination as? TextChangeVC {
            otherName.newTextName = textField1.text!
            otherName.delegate = self
        }
        
        if segue.identifier == "colorSegueIdentifier", let otherColor = segue.destination as?         ColorChangeVC{
            otherColor.labelColor = textField1.backgroundColor
            otherColor.delegate = self
            
        }
    }
    

    
    func changeText (newName: String) {
        textField1.text = newName
    }
    
    func changeColor(chooseColor: UIColor) {
        textField1.backgroundColor = chooseColor
    }


}

