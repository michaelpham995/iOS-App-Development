// Project: PhamMichael-HW4
// EID: mp46987
// Course: CS 329E//  ViewController.swift
//
//  PhamMichael-HW4
//
//  Created by Michael Pham on 9/23/22.
//

import UIKit

public let operators = ["+", "-", "*", "/"]
public let selectOperator = ["Add", "Subtract", "Multiply", "Divide"]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "textCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = selectOperator[row]
        
        return cell    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculateSegue",
           let destination = segue.destination as? calculateViewController,
           let operatorType = tableView.indexPathForSelectedRow?.row
        {
            destination.chosenOperator = operators[operatorType]
        }
    }
}

