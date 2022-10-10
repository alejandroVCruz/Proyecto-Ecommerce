//
//  ViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 20/09/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var Imagen: UIImageView!
    
    var IdUsuario : Int = 0
    
    @IBOutlet weak var TextNombre: UITextField!
    
    @IBOutlet weak var TextApellidoPaterno: UITextField!
    
    @IBOutlet weak var TextApellidoMaterno: UITextField!
    
    @IBOutlet weak var TextUserName: UITextField!
    
    @IBOutlet weak var TextContraseña: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validar()
        imagePicker.delegate = self
        
        
    }
    
    func Validar(){
        if IdUsuario != 0{
            let result: Result = Usuario.GetById(IdUsuario)
            if result.Correct!{
                let usuario = result.Object as! Usuario
                TextNombre.text = usuario.Nombre
                TextApellidoPaterno.text = usuario.ApellidoPaterno
                TextApellidoMaterno.text = usuario.ApellidoMaterno
                TextUserName.text = usuario.Username
                TextContraseña.text = usuario.Contrasena
                
                button.setTitle("Actualizar", for: .normal)
                button.backgroundColor = UIColor.yellow
            }
            else{
                button.setTitle("Agregar", for: .normal)
                print("Ocurrio un error \(result.ErrorMessage)")
            }
        }else{
            button.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        let usuario = Usuario()
        usuario.Nombre=TextNombre.text
        usuario.ApellidoPaterno=TextApellidoPaterno.text
        usuario.ApellidoMaterno=TextApellidoMaterno.text
        usuario.Username=TextUserName.text
        usuario.Contrasena=TextContraseña.text
        
       let textbutton = sender.titleLabel
        if sender.titleLabel?.text == "GUARDAR"{
            Usuario.Add(usuario)
        }
        else if sender.titleLabel?.text == "Actualizar"{
            usuario.IdUsuario = IdUsuario
            Usuario.Update(usuario)
        }
    }
    
    
    @IBAction func TomarFoto(_ sender: UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func SeleccionarFoto(_ sender: UIButton) {
       
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
               
                present(imagePicker, animated: true, completion: nil)
         
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        Imagen?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
  
    
}
