//  Project: PhamMichael-HW3
//  EID: mp46987
//  Course: CS329E
//
//  TextChangeVC.swift
//  PhamMichael-HW3

//
//  Created by Michael Pham on 9/19/22.
//

import UIKit

class TextChangeVC: UIViewController {


    @IBOutlet weak var textEditor: UITextField!
    
    var newTextName = ""
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEditor.text = newTextName
    }
    

    @IBAction func saveNewText(_ sender: Any) {
        let otherVC = delegate as! TextChanger
        otherVC.changeText(newName: textEditor.text!)
        self.dismiss(animated:true)
    }
    
}
