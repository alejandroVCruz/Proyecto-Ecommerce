//
//  ProductoViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 30/09/22.
//
import iOSDropDown

import UIKit

class ProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imagen: UIImageView!
    
    
    @IBOutlet weak var TextNombreProducto: UITextField!
    
    @IBOutlet weak var TextPrecioUnitario: UITextField!
    
    @IBOutlet weak var TextStock: UITextField!
    
    @IBOutlet weak var TextDescripcion: UITextField!
    
    @IBOutlet weak var DropDownProveedor: DropDown!
    
    @IBOutlet weak var DropDownDepartamento: DropDown!
    
    @IBOutlet weak var button: UIButton!
    
    var IdProducto : Int = 0
    var IdProveedor : Int = 0
    var IdDepartamento : Int = 0
    var arrayProveedor: [String] = []
    var arrayDepartamento: [String] = []
    var arrayIdDepartamento: [Int] = []
    var arrayIdProveedor: [Int] = []
    var result = Result()
    var proveedores : [Proveedor] = []
    var departamentos : [Departamento] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        Validar()
        imagePicker.delegate = self
        
        LoadDataProveedor()
        DropDownProveedor.optionArray = arrayProveedor
        DropDownProveedor.optionIds = arrayIdProveedor
        
        
        LoadDataDepartamento()
        DropDownDepartamento.optionArray = arrayDepartamento
        DropDownDepartamento.optionIds = arrayIdDepartamento
        
        DropDownProveedor.didSelect { selectedText, index, id in
            self.IdProveedor = id }
        
        DropDownDepartamento.didSelect { selectedText, index, id in
            self.IdDepartamento = id }
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
                DropDownDepartamento.text = String(producto.departamento.IdDepartamento)
                DropDownProveedor.text = String(producto.proveedor.IdProveedor)
                
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
        producto.departamento.IdDepartamento = IdDepartamento
        producto.proveedor.IdProveedor = IdProveedor
        
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
    
    func LoadDataProveedor(){
         result = try! Proveedor.GetAll()
        if result.Correct!{
            proveedores = result.Objects as! [Proveedor]
            for proveedor in proveedores{
                arrayProveedor.append(proveedor.Nombre!)
                arrayIdProveedor.append(proveedor.IdProveedor)
            }
        }
    }
    
    func LoadDataDepartamento(){
        result = try! Departamento.GetAll()
        if result.Correct!{
            departamentos = result.Objects as! [Departamento]
            for departamento in departamentos {
                arrayDepartamento.append(departamento.Nombre!)
                arrayIdDepartamento.append(departamento.IdDepartamento)
            }
        }
    }
    
}
