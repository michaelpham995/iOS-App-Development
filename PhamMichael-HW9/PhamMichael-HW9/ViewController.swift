//
// Project: PhamMichael-HW9
// EID: mp46987
// Course: CS329E
//
//  ViewController.swift
//  PhamMichael-HW9
//
//  Created by Michael Pham on 11/7/22.
//

import UIKit
import Foundation


let rowCount: Int = 19
let colCount: Int = 9

class ViewController: UIViewController {

    
    var label: UILabel?

    //Setting the screen width and height
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    //Setting the cell widths and heights
    var width: CGFloat = UIScreen.main.bounds.width/CGFloat(colCount)
    var height: CGFloat = UIScreen.main.bounds.height/CGFloat(rowCount)
    //Initializing the 4 directions in which we will be swipping
    var top: CGFloat?
    var bottom: CGFloat?
    var right: CGFloat?
    var left: CGFloat?

    //Setting Direction pointers
    var endGame: Bool = false
    var directionChanged: String = "no swipe"
    let newDirection = DispatchSemaphore(value: 1)
    let semaphoreGameOver = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        right = screenWidth - width/2
        left = 0 + width/2
        top = 0 + height/2
        bottom = screenHeight - height/2
        
        label = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: width , height: height))
        label?.center = self.view.center
        label?.backgroundColor = UIColor.green
        self.view.addSubview(label!)

        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipe(recognizer:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipe(recognizer:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipe(recognizer:)))
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipe(recognizer:)))
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(downSwipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(recognizeTap(recognize:)))
        self.view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //This method recognizes taps
    @IBAction func recognizeTap(recognize: UITapGestureRecognizer) {
        label?.center = self.view.center
        label?.backgroundColor = UIColor.green
        
        semaphoreGameOver.wait()
        self.newDirection.wait()
        endGame = false
        self.directionChanged = "tap"
        semaphoreGameOver.signal()
        self.newDirection.signal()
        
        movement(direction: "tap")
        
    }

    //This method recognizes the swipe directions
    @IBAction func recognizeSwipe(recognizer: UISwipeGestureRecognizer) {
        
        var swipeDirection: String = "none"
        
        switch recognizer.direction {
        case UISwipeGestureRecognizer.Direction.right:
            swipeDirection = "right"
        case UISwipeGestureRecognizer.Direction.left:
            swipeDirection = "left"
        case UISwipeGestureRecognizer.Direction.up:
            swipeDirection = "up"
        case UISwipeGestureRecognizer.Direction.down:
            swipeDirection = "down"
        default:
            break
        }
        semaphoreGameOver.wait()
        newDirection.wait()
        if endGame || swipeDirection == directionChanged {
            semaphoreGameOver.signal()
            newDirection.signal()
            return
        } else {
            semaphoreGameOver.signal()
            newDirection.signal()
            movement(direction: swipeDirection)
        }
    }
    

    
    //This is a helper method to update the UI
    func changeScreen(direction: String, position: CGFloat) {
        DispatchQueue.main.async {
            self.semaphoreGameOver.wait()
            self.newDirection.wait()
            
            if self.directionChanged == direction {
                UIView.animate(withDuration: 0,
                               animations: {
                                if direction == "left" || direction == "right" {
                                    self.label?.center.x = position
                                } else {
                                    self.label?.center.y = position } },
                               completion: {finished in
                                if self.endGame {
                                    self.label?.backgroundColor = UIColor.red }})
            }
            self.semaphoreGameOver.signal()
            self.newDirection.signal()
        }
    }
    
    //This actually moves our pointer on the screen
    func movement(direction: String) {
        var ySize: CGFloat = (self.label?.center.y)!
        var xSize: CGFloat = (self.label?.center.x)!
        var updatedCoordinates: CGFloat!
        DispatchQueue.global(qos: .userInteractive).async {
            self.newDirection.wait()
            self.directionChanged = direction
            self.newDirection.signal()
            
            self.semaphoreGameOver.wait()
            while (!self.endGame) {
                self.semaphoreGameOver.signal()
                self.newDirection.wait()
                
                if self.directionChanged != direction {
                    self.newDirection.signal()
                    return
                } else {
                    self.newDirection.signal()
                    usleep(300000)
                    
                    self.semaphoreGameOver.wait()
                    self.newDirection.wait()
                    
                    switch direction {
                    case "up":
                        ySize -= self.height
                        if Int(ySize - self.top!) == 0 && self.directionChanged == direction {
                            self.endGame = true }
                        updatedCoordinates = ySize
                    case "down":
                        ySize += self.height
                        if Int(ySize - self.bottom!) == 0 && self.directionChanged == direction{
                            self.endGame = true }
                        updatedCoordinates = ySize
                    case "right":
                        xSize += self.width
                        if Int(xSize - self.right!) == 0 && self.directionChanged == direction {
                            self.endGame = true }
                        updatedCoordinates = xSize
                    case "left":
                        xSize -= self.width
                        if Int(xSize - self.left!) == 0 && self.directionChanged == direction {
                            self.endGame = true }
                        updatedCoordinates = xSize
                    case "tap":
                        ySize += self.height
                        if Int(ySize - self.bottom!) == 0 && self.directionChanged == direction{
                            self.endGame = true }
                        updatedCoordinates = ySize
                    default:
                        break
                    }
                    
                    self.semaphoreGameOver.signal()
                    self.newDirection.signal()
                    self.changeScreen(direction: direction, position: updatedCoordinates)
                    self.semaphoreGameOver.wait()
                }
            }
            self.semaphoreGameOver.signal()
        }
    }

}

