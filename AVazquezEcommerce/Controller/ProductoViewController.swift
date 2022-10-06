//
//  ProductoViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 30/09/22.
//

import UIKit

class ProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imagen: UIImageView!
    
    var IdProducto : Int = 0
    
    
    @IBOutlet weak var TextNombreProducto: UITextField!
    
    @IBOutlet weak var TextPrecioUnitario: UITextField!
    
    @IBOutlet weak var TextStock: UITextField!
    
    @IBOutlet weak var TextDescripcion: UITextField!
    
    @IBOutlet weak var TextIdProveedor: UITextField!
    
    @IBOutlet weak var TextIdDepartamento: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        Validar()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func Validar(){
        if IdProducto != 0{
            let result: Result = Producto.GetById(IdProducto)
            if result.Correct!{
                let producto = result.Object as! Producto
                TextNombreProducto.text = producto.Nombre
                TextPrecioUnitario.text = String(producto.PrecioUnitario)
                TextStock.text = String(producto.Stock)
                TextDescripcion.text = producto.Descripcion
                TextIdDepartamento.text = String(producto.departamento.IdDepartamento)
                TextIdProveedor.text = String(producto.proveedor.IdProveedor)
                
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
        let producto = Producto()
        producto.Nombre = TextNombreProducto.text
        producto.PrecioUnitario = Double(TextPrecioUnitario.text!)!
        producto.Stock = Int(TextStock.text!)!
        producto.Descripcion = TextDescripcion.text
        producto.departamento.IdDepartamento = Int(TextIdDepartamento.text!)!
        producto.proveedor.IdProveedor = Int(TextIdProveedor.text!)!
        
       let textbutton = sender.titleLabel
        if sender.titleLabel?.text == "GUARDAR"{
            Producto.Add(producto)
        }
        else if sender.titleLabel?.text == "Actualizar"{
            producto.IdProducto = IdProducto
            Producto.Update(producto)
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
        imagen?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
}
