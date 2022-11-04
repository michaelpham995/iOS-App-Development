//
// Project: PhamMichael - HW8
// EID: mp46987
// Course: CS329E
//
//  ViewController.swift
//  PhamMichael-HW8
//
//  Created by Michael Pham on 10/31/22.
//

import UIKit
import UserNotifications

let imageOne = "uttower"
let imageTwo = "ut"

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    let imageUTTower = UIImage(named: imageOne)
    let imageUTLogo = UIImage(named: imageTwo)
    var numOfClicks = 0
    let interval: TimeInterval = 8
    
    var btnImage: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().delegate = self
        
        btnImage = UIButton(type: .roundedRect)
        btnImage.frame = CGRect(x:0, y:0, width:414, height:692)
        btnImage.center = CGPoint(x: 207, y: 346)
        btnImage.addTarget(self, action: #selector(btnImagePressed), for: .touchUpInside)

        btnImage.setImage(imageUTLogo, for: .normal)

        self.view.addSubview(btnImage)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func btnImagePressed(_ sender: Any) {
        numOfClicks += 1
        
        //Animation code
        let picture = btnImage.currentImage
        
        switch picture{
        case imageUTTower:
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: .curveEaseOut,
                           animations: {
                self.btnImage.alpha = 0.0
            },
                completion: {
                finished in
                self.btnImage.setImage(self.imageUTLogo, for: .normal)
                UIView.animate(withDuration: 1.0,
                               delay: 0.0,
                               options: .curveEaseIn,
                               animations: {
                    self.btnImage.alpha = 1.0
                }, completion: nil
                )
            })
        
        case imageUTLogo:
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: .curveEaseOut,
                           animations: {
                self.btnImage.alpha = 0.0
            },
            completion: { finished in
                self.btnImage.setImage(self.imageUTTower, for: .normal)
                UIView.animate(withDuration: 1.0,
                               delay: 0.0,
                               options: .curveEaseIn,
                               animations: {
                    self.btnImage.alpha = 1.0
                },
                completion: nil)
            }
        )
        default:
            print("There is no image")
        }
        
        //Notification for the number of clicks
        if numOfClicks > 0 && numOfClicks % 4 == 0{
            let notif = UNMutableNotificationContent()
            notif.title = "Click Count"
            notif.subtitle = "Here are the number of times you have clicked"
            notif.body = "You have clicked \(numOfClicks) times."
            
            //Below is setting up our sender and a request for iOS to push that notification
            let notifSender = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
            
            let iOSRequest = UNNotificationRequest(identifier: "fourClickNotification",
                                                   content: notif,
                                                   trigger: notifSender)
            
            UNUserNotificationCenter.current().add(iOSRequest) { //Adding iOS request to actually send
                error in
                print("Request error: ", error as Any)
            }
        }
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

    }
    
}
