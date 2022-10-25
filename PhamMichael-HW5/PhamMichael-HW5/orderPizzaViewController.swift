// Project: PhamMichael-HW5
// EID: mp46987
// Course: CS329E
//
//  orderPizzaViewController.swift
//  PhamMichael-HW5
//
//  Created by Michael Pham on 10/11/22.
//

import UIKit
import CoreData

var pizzaList: [String] = []

class orderPizzaViewController: UIViewController {

    @IBOutlet weak var sizeSegControl: UISegmentedControl!
    @IBOutlet weak var currentPizzaSummary: UILabel!
    
    var size: String = "small"
    var typeCrust: String = ""
    var typeCheese: String = ""
    var typeMeat: String = ""
    var typeVeggies: String = ""
    var delegate: UIViewController!
    
    var updateOrder: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPizzaSummary.text = ""

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func changeSize(_ sender: Any) {
        switch sizeSegControl.selectedSegmentIndex{
        case 0:
            size = "small"
        case 1:
            size = "medium"
        case 2:
            size = "large"
        default:
            print("This should never pop up")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

    @IBAction func chooseCrustBtn(_ sender: Any) {
        let crustController = UIAlertController(
            title: "Select Crust",
            message: "Choose a crust type:",
            preferredStyle: .alert)
        
        crustController.addAction(UIAlertAction(
            title: "Thin Crust",
            style: .default,
            handler: {(action) in self.typeCrust = "Thin Crust"}))
        
        crustController.addAction(UIAlertAction(
            title: "Thick Crust",
            style: .default,
            handler: {(action) in self.typeCrust = "Thick Crust"}))
        present(crustController, animated: true)
    }
    


    @IBAction func chooseCheeseBtn(_ sender: Any) {
        let cheeseController = UIAlertController(
                 title: "Select Cheese",
                 message: "Choose a cheese type:",
                 preferredStyle: .actionSheet)
             
             cheeseController.addAction(UIAlertAction(
                 title: "No cheese",
                 style: .default,
                 handler: {(action) in self.typeCheese = "No cheese"}))
             
             cheeseController.addAction(UIAlertAction(
                 title: "Regular cheese",
                 style: .default,
                 handler: {(action) in self.typeCheese = "Regular cheese"}))

             cheeseController.addAction(UIAlertAction(
                 title: "Double cheese",
                 style: .default,
                 handler: {(action) in self.typeCheese = "Double cheese"}))
             present(cheeseController, animated: true)
    }
    


    @IBAction func chooseMeatBtn(_ sender: Any) {
        let meatController = UIAlertController(
            title: "Select Meat",
            message: "Choose one meat:",
            preferredStyle: .actionSheet)
        
        meatController.addAction(UIAlertAction(
            title: "Pepperoni",
            style: .default,
            handler: {(action) in self.typeMeat = "Pepperoni"}))
        
        meatController.addAction(UIAlertAction(
            title: "Sausage",
            style: .default,
            handler: {(action) in self.typeMeat = "Sausage"}))

        meatController.addAction(UIAlertAction(
            title: "Canadian Bacon",
            style: .default,
            handler: {(action) in self.typeMeat = "Canadian Bacon"}))
        present(meatController, animated: true)
    }
    


    @IBAction func chooseVeggieBtn(_ sender: Any) {
        let vegeController = UIAlertController(
              title: "Select Vegetables",
              message: "Choose your veggies:",
              preferredStyle: .actionSheet)
          
          vegeController.addAction(UIAlertAction(
              title: "Mushroom",
              style: .default,
              handler: {(action) in self.typeVeggies = "Mushroom"}))
          
          vegeController.addAction(UIAlertAction(
              title: "Onion",
              style: .default,
              handler: {(action) in self.typeVeggies = "Onion"}))

          vegeController.addAction(UIAlertAction(
              title: "Green Olive",
              style: .default,
              handler: {(action) in self.typeVeggies = "Green Olive"}))
          
          vegeController.addAction(UIAlertAction(
              title: "Black Olive",
              style: .default,
              handler: {(action) in self.typeVeggies = "Black Olive"}))
          
          vegeController.addAction(UIAlertAction(
              title: "None",
              style: .default,
              handler: {(action) in self.typeVeggies = "None"}))
          present(vegeController, animated: true)
    }
    

    func missingIngredientNotification() -> String?{
          if typeCrust == "" {
              return "crust"
          }
          else if typeCheese == ""{
              return "cheese"
          }
          else if typeMeat == ""{
              return "meat"
          }
          else if typeVeggies == ""{
              return "vegetables"
          }
          else{
              return nil
          }
      }
      
    @IBAction func doneBtn(_ sender: Any) {
        if let missingItem = missingIngredientNotification(){
            let missingController = UIAlertController(
                title: "Missing Ingredient",
                message: "Select a \(missingItem) type.",
                preferredStyle: .alert)
            missingController.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            present(missingController, animated: true)
        }
        else{
            currentPizzaSummary.text = printPizza(size, typeCrust, typeCheese, typeMeat, typeVeggies)
            pizzaList.append(printOrder(size, typeCrust, typeCheese, typeMeat, typeVeggies))
        }
    }
    
    
    func printPizza(_ size: String, _ typeCrust: String, _ typeCheese: String, _ typeMeat: String, _ typeVeggies: String) -> String{
        return ("One \(size) pizza with \n\t\(typeCrust)\n\t\(typeCheese)\n\t\(typeMeat)\n\t\(typeVeggies)")
    }
      
    func printOrder(_ size: String, _ typeCrust: String, _ typeCheese: String, _ typeMeat: String, _ typeVeggies: String) -> String{
        return ("\(size)\n\t\(typeCrust)\n\t\(typeCheese)\n\t\(typeMeat)\n\t\(typeVeggies)")
    }

}
