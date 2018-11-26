//
//  CameraController.swift
//  iOS_Project
//
//  Created by Veena Balakumar on 16/10/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class CameraController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var imagePickerController : UIImagePickerController! {
        didSet{
            imagePickerController = UIImagePickerController()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var takePhoto: UIButton!{
        didSet{
            takePhoto.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
    }
    
    @IBOutlet weak var selectPhoto: UIButton!{
        didSet{
            selectPhoto.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera

        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true ,completion: nil)
    }
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        
        imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = (info[UIImagePickerController.InfoKey.editedImage] ?? info[UIImagePickerController.InfoKey.originalImage]) as? UIImage {
            
            coreData().saveImage(image: image)
            self.viewDidLoad()
            
            
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreData().loadImage(view: self.imageView)
    }
    
    
}
