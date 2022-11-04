//
//  ViewController.swift
//  PhamMichael-HW7
//
//  Created by Michael Pham on 10/24/22.
//

import UIKit



class ViewController: UIViewController, TimerDelegate, newTimerInfo, UITableViewDataSource, UITableViewDelegate  {
    

    

    @IBOutlet weak var tableView: UITableView!
    
    var currentTimerIndex: Int!
    var countdown: Bool = false
    var selectedTimer: ViewTimer?
    
    var timersList: [ViewTimer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Efficient disposal of resources
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timerCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath as IndexPath) as! TimerCell
        
        let row = indexPath.row
        timerCell.timer = timersList[row]
        timerCell.eventLabel.text = "Event\t\t" + timersList[row].cellEvent
        timerCell.locationLabel.text = "Location\t" + timersList[row].cellLocation
        timerCell.remainingTimeLabel.text = "Remaining time(s)\t" + String(timersList[row].cellRemainingTime)
        return timerCell
    }
    
    func timerUpdate(remainingTime: Int32){
        timersList[currentTimerIndex].update(time: remainingTime)
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?){
        switch segue.identifier{
        case "newSegue":
            let destination = segue.destination as? AddTimerViewController
            destination?.delegate = self
        
        case "countdownSegue":
            let destination = segue.destination as? CountdownViewController
            destination?.delegate = self
            if let indexPath = self.tableView.indexPathForSelectedRow{
                currentTimerIndex = indexPath.row
                selectedTimer = timersList[currentTimerIndex]
                countdown = true
                destination?.timer = selectedTimer
            }
        default:
            break
        }
    }
    

    
    func newTimer(event: String, location: String, timeCount : Int32) {
        makeTimer(event: event, location: location, remainingTime: timeCount )
        tableView.reloadData()
    }
    
    func makeTimer(event: String, location: String, remainingTime: Int32){
        let insertedTimer = ViewTimer(event: event, location: location, time: remainingTime)
        if timersList.contains(insertedTimer){
            let alert = UIAlertController(title: "Already Listed",
                                          message: "This event has already been listed",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        timersList.append(insertedTimer)
    }
    
    func update(remainingTime: Int32){
        timersList[currentTimerIndex].update(time: remainingTime)
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        tableView.reloadData()
        }
    }
}

