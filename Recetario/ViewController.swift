//
//  ViewController.swift
//  Recetario
//
//  Created by Abraham Barcenas M on 10/20/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var segmentOpciones: UISegmentedControl!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnAction: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnAction.layer.borderColor = white.cgColor
        //btnAction.titleLabel?.text = "Login"
        
        self.hideKeyboardOnTap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }


    //desaparece el teclado cuando se presiona Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //desaparece el teclado cuando se presiona afuera del teclado
    func hideKeyboardOnTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    @IBAction func segmentChange(_ sender: AnyObject) {
        if self.segmentOpciones.selectedSegmentIndex == 0 {
            self.btnAction.setTitle("Login", for: .normal)
            self.txtEmail.text = ""
            self.txtPassword.text = ""
        }else{
            self.btnAction.setTitle("Register", for: .normal)
            self.txtEmail.text = ""
            self.txtPassword.text = ""
        }
    }

    @IBAction func btnPressed(_ sender: AnyObject) {
        
        if let email = self.txtEmail.text , let password = self.txtPassword.text {
            if self.segmentOpciones.selectedSegmentIndex == 0 {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    
                    if error != nil {
                        
                        KVNProgress.showError(withStatus: "Usuario / Password Incorrecto", completion: {
                            self.txtPassword.text = ""
                        })
                    }else{
                        KVNProgress.showSuccess(withStatus: "Bienvenido", completion: {
                            self.txtEmail.text = ""
                            self.txtPassword.text = ""
                            
                            self.performSegue(withIdentifier: "mainSegue", sender: nil)
                        })
                    }
                    
                })
            }else{
                
                if password.characters.count < 8 {
                    KVNProgress.showError(withStatus: "El email debe tener por lo menos 8 caracteres", completion: {
                        self.txtPassword.text = ""
                    })
                }else{
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            let configuration = KVNProgressConfiguration()
                            configuration.minimumErrorDisplayTime = 3.0
                            KVNProgress.showError(withStatus: "Email en uso, intente con otro", completion: {
                                self.txtPassword.text = ""
                            })
                        }else{
                            KVNProgress.showSuccess(withStatus: "Usuario creado exitosamente", completion: {
                                self.txtEmail.text = ""
                                self.txtPassword.text = ""
                            })
                        }
                        
                    })
                }
            }
            
        }else{
            KVNProgress.showError(withStatus: "Oops, parece que has olvidado llenar un campo")
            return
        }
    }
    
    
    @IBAction func adios(segue: UIStoryboardSegue){
        print("Adios")
    }
    
    
}

