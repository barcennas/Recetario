//
//  AddRecepieController.swift
//  Recetario
//
//  Created by Abraham Barcenas M on 10/21/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit
import Photos

class AddRecepieController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imagen: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        //let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        /*imagen.layer.borderWidth = 1
        imagen.layer.borderColor = black.cgColor*/
        imagen.layer.cornerRadius = 20
        imagen.isUserInteractionEnabled = true
        self.imageTap()
    }
    
    func imageTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage))
        tap.numberOfTapsRequired = 1
        self.imagen.addGestureRecognizer(tap)
    }
    
    func tappedImage(){
        
        print("Tapped")
        PHPhotoLibrary.requestAuthorization { [unowned self](authStatus) in
            DispatchQueue.main.async {
                
                if authStatus == .authorized {
                    
                    let vc = UIImagePickerController()
                    vc.modalPresentationStyle = .fullScreen
                    vc.delegate = self
                    self.navigationController?.present(vc, animated: true, completion: nil)
                    
                }else{
                    
                    let NoPermissionAlert = UIAlertController(title: "Oops", message: "Se necesita acceder a las fotos para agregar una imagen", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    NoPermissionAlert.addAction(okAction)
                    
                    self.present(NoPermissionAlert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imagen.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
