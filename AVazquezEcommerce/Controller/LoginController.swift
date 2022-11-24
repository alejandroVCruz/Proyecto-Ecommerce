//
//  LoginController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 05/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginController: UIViewController {
    
    
    @IBOutlet weak var TextUsername: UITextField!
    
    
    @IBOutlet weak var TextContraseña: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func IniciarSesion(_ sender: Any) {
        
        let username = TextUsername.text!
        let contraseña = TextContraseña.text
        //if contraseña == usuario.Contrasena{
        //else{
        //Error contraseña incorrecta
        //let alert = UIAlertController(title: "Contraseña Incorrecta", message: "La contraseña que ingreso es incorrecta", preferredStyle: UIAlertController.Style.alert)
        //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
        //  }
        //}else{
        //Error no existe el usuario
        //  let alert = UIAlertController(title: "Usuario Incorrecta", message: "El usuario que ingreso es incorrecto", preferredStyle: UIAlertController.Style.alert)
        //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
        //
        
        if let email = TextUsername.text, let password = TextContraseña.text{
            Auth.auth().signIn(withEmail: email,password: password){ authResult, error in
                if let ex = error{
                    let alert = UIAlertController(title: "Correo Incorrecto", message: "El correo que ingreso es incorrecto", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    let alert = UIAlertController(title: "DATOS CORRECTOS", message: "BIENVENIDO", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.performSegue(withIdentifier: "usuario", sender: self)
                }
                
            }
            
        }else{
        }
        
    }
}
