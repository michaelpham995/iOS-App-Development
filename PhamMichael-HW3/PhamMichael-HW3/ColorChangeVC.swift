//  Project: PhamMichael-HW3
//  EID: mp46987
//  Course: CS329E
//
//  ColorChangeVC.swift
//  PhamMichael-HW3
//
//  Created by Michael Pham on 9/21/22.
//

import UIKit


class ColorChangeVC: UIViewController {
    
    var delegate: UIViewController!
    var labelColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func blueButton(_ sender: Any) {
        let newColor = delegate as! ColorChanger
        newColor.changeColor(chooseColor: UIColor.blue)
        self.dismiss(animated: true)
        
    }
    

    @IBAction func redButton(_ sender: Any) {
        let newColor = delegate as! ColorChanger
        newColor.changeColor(chooseColor: UIColor.red)
        self.dismiss(animated: true)
    }
    
}
