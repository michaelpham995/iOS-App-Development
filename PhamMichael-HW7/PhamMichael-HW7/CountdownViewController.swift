//
//  CountdownViewController.swift
//  PhamMichael-HW7
//
//  Created by Michael Pham on 10/24/22.
//

import UIKit
import Foundation

protocol TimerDelegate{
    func timerUpdate(remainingTime: Int32)
}


class CountdownViewController: UIViewController {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    var delegate: TimerDelegate!
    var timer: ViewTimer!
    var stopFlag: Bool = false
    
    var currEvent: String?
    var currLocation: String?
    var currRemainingTime: Int32?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventLabel.text = timer.cellEvent
        locationLabel.text = timer.cellLocation
        remainingTimeLabel.text = String(timer.cellRemainingTime)
        
        countDown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopFlag = true
        currRemainingTime = timer.cellRemainingTime
        delegate?.timerUpdate(remainingTime: currRemainingTime!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func countDown(){
        DispatchQueue.global(qos: .userInteractive).async {
            while (!self.stopFlag && self.timer.cellRemainingTime > 0){
                sleep(1)
                self.timer.cellRemainingTime -= 1
                
                DispatchQueue.main.async {
                    self.remainingTimeLabel.text = String(self.timer.cellRemainingTime)
                }
            }
        }
    }
    
    

}
