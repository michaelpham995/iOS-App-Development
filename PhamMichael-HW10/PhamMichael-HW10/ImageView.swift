//
//  PhamMichael-HW10
//  EID: mp46987
//  Course: CS 329E
//
//  Created by Michael Pham on 11/15/22.
//

import UIKit

//Establish delegate for collection view
protocol storeImageDelegate {
    func storeImageDelegate(_ saveImage: Bool)
}

class ImageView: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    //Set variables to add image
    var newImage: UIImage?
    var delegate: storeImageDelegate?
    var isSourcePicker: Bool = false
    var saveImage: Bool = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Displays the image we choose
        imageView.image = newImage
        
        //If we're adding an image then we show the save button and we dont show it if we are viewing an existing image from the collection
        if isSourcePicker {
            self.navigationController?.isToolbarHidden = false
            self.saveBtn.isEnabled = true
        } else {
            self.navigationController?.isToolbarHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When we save the image then we pass it on to the delegate which will affect the collection view
    
    @IBAction func buttonSavePressed(_ sender: Any) {
        print("The button was pressed")
        saveImage = true
        delegate?.storeImageDelegate(saveImage)
        _ = navigationController?.popViewController(animated: true)
    }


    
}
    


