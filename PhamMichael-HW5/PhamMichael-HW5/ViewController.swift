// Project: PhamMichael-HW5
// EID: mp46987
// Course: CS329E
//
//  ViewController.swift
//  PhamMichael-HW5
//
//  Created by Michael Pham on 10/11/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pizzaOrder = [String]()
    
    
    let createPizzaSegue = "createPizzaSegue"
    let textCellIdentifier = "textCell"
    @IBOutlet weak var pizzaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pizzaTableView.reloadData()
        self.navigationItem.hidesBackButton = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == createPizzaSegue,
           let nextVC = segue.destination as? orderPizzaViewController{
            nextVC.delegate = self
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = pizzaTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.text = pizzaList[row]
        return cell
    }
    
    
    
}
    

