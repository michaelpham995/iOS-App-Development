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
import FirebaseAuth

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
        let fetchedResults = pullPizzas()
        return fetchedResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = pizzaTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let fetchResults = pullPizzas()
        let pizza = fetchResults[indexPath.row]
        if let size = pizza.value(forKey: "size"){
            if let crust = pizza.value(forKey: "typeCrust"){
                if let cheese = pizza.value(forKey: "typeCheese"){
                    if let meat = pizza.value(forKey: "typeMeat"){
                        if let veggies = pizza.value(forKey: "typeVeggies"){
                            item.textLabel?.numberOfLines = 5
                            item.textLabel?.text = printTableCell(size as! String, crust as! String, cheese as! String, meat as! String, veggies as! String)
                        }
                    }
                }
            }
        }
        return item
    }
    
    
    //Deleting a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchResults = pullPizzas()
            let pizza = fetchResults[indexPath.row]
            context.delete(pizza)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do{
                try context.save()
            } catch{
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func printTableCell(_ size: String, _ typeCrust: String, _ typeCheese: String, _ typeMeat: String, _ typeVeggies: String) -> String{
        return ("\t\(size)\n\t\(typeCrust)\n\t\(typeCheese)\n\t\(typeMeat)\n\t\(typeVeggies)")
    }
    
    
    func pullPizzas() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pizza")
        var fetchedResults: [NSManagedObject]? = nil
        do{
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch{
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return (fetchedResults)!
    }
    
    
    //clear core data
    func eraseCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pizza")
        var fetchedResults:[NSManagedObject]
        do{
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            if fetchedResults.count > 0{
                for result:AnyObject in fetchedResults{
                    context.delete(result as! NSManagedObject)
                    print("\(result.value(forKey: "name")!) has been deleted!")
                }
            }
            try context.save()
        } catch{
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    

    
    @IBAction func signOutUserBtn(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch{
            print("Sign out error")
        }
    }
    
}
    

