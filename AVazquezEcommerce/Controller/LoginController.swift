//
//  LoginController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 05/10/22.
//

import UIKit
import FirebaseAuth

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
                
                let result : Result = Usuario.GetByUsername(username)
                if result.Correct!{
                    let usuario = result.Object as! Usuario
                    if contraseña == usuario.Contrasena{
                        self.performSegue(withIdentifier: "usuario", sender: nil)
                    }
                    else{
                        //Error contraseña incorrecta
                        let alert = UIAlertController(title: "Contraseña Incorrecta", message: "La contraseña que ingreso es incorrecta", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    //Error no existe el usuario
                    let alert = UIAlertController(title: "Usuario Incorrecta", message: "El usuario que ingreso es incorrecto", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
     
    }
    
}
