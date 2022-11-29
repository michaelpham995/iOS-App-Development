//
//  PhamMichael-HW10
//  EID: mp46987
//  Course: CS 329E
//
//  Created by Michael Pham on 11/15/22.
//

import UIKit
import AVFoundation

let imagesForRow: CGFloat = 3

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, storeImageDelegate {


    //Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Setting variables for photo selection below
    var photo: UIImage!
    let picker = UIImagePickerController()
    var isSourcePicker: Bool = false


    var imageData = ["pic1", "pic2"]
    
    // Data source for new images and counting images
    var newImageData: [UIImage] = []
    var numOfImages: Int = 0
    var numOfNewImages: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Protocol for saveImageDelegate
    func storeImageDelegate(_ saveImage: Bool) {
        if saveImage {
            newImageData.insert(photo, at: 0)
            
            imageAddedAlert()
            collectionView.reloadData()
        }
    }
    

    //Standard
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //The number of cells in the collection view is a combination of new images and old
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
            print("There are \(self.imageData.count + self.newImageData.count) pictures")
            return self.imageData.count + self.newImageData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellIdentifier", for: indexPath) as! ImageDetailCell

        if self.numOfNewImages >= self.newImageData.count {
            if numOfImages < self.imageData.count {
                let currentImageName = self.imageData[self.numOfImages]
                cell.image.image = UIImage(named:currentImageName)!
                self.numOfImages += 1
                return cell
            } else {
                self.numOfImages = 0
                self.numOfNewImages = 0
            }
        } else {
            cell.image.image = newImageData[numOfNewImages]
            self.numOfNewImages += 1
            return cell
        }
        
        print("Is this working")
        return cell
        
    }
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fullscreenSegue" {
            let destination = segue.destination as? ImageView
            destination?.delegate = self
            if isSourcePicker {
                destination?.newImage = photo
                destination?.isSourcePicker = true
            } else {
                if let cell = sender as? ImageDetailCell {
                    destination?.newImage = cell.image.image
                }
            }
            isSourcePicker = false
        }
    }
    
    //Camera
    @IBAction func takePictureBtn(_ sender: Any) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access denied")
                return
            }
            
            picker.delegate = self
            // whole picture, not an edited version
            picker.allowsEditing = false
            
            // set the source to be the camera
            picker.sourceType = .camera
            
            // set camera mode to "photo"
            picker.cameraCaptureMode = .photo
            
            present(picker, animated: true, completion: nil)
            
        } else {
            noCamera()
        }
    }
    
    
    //Photolibrary
    
    @IBAction func addFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.delegate = self
        // set the source to be the Photo Library
        picker.sourceType = .photoLibrary;
        present(picker, animated: true, completion: nil)
    }
    
    
    // Alert if theres no cameras - should be like this on mac
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let chosenImage = info[.originalImage] as! UIImage
        photo = chosenImage
        isSourcePicker = true
        performSegue(withIdentifier: "fullscreenSegue", sender: self)
        // dismiss the popover
        dismiss(animated: true, completion: nil)
    }
    
    //Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // Alert for adding an image to colectionView
    func imageAddedAlert(){
        let alertVC = UIAlertController(
            title: "Image Successfully Added to Collection",
            message: "The image is added to your Collection View.",
            preferredStyle: .alert)
        let okSelection = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {alert in _ = self.navigationController?.popViewController(animated: true)})
        alertVC.addAction(okSelection)
        present(alertVC, animated: true,
                completion: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width/imagesForRow
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init()
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


