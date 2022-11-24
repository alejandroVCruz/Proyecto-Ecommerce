//
//  ProveedorViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 18/10/22.
//
import iOSDropDown

import UIKit

class ProveedorViewController: UIViewController {
    
    var IdProveedor : Int = 0
    
    
    @IBOutlet weak var Nombre: UITextField!
    
    @IBOutlet weak var Telefono: UITextField!
    
    
    
    @IBOutlet weak var Button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Validar()

        // Do any additional setup after loading the view.
    }
    
    
    func Validar(){
        if IdProveedor != 0{
            let result: Result = Proveedor.GetById(IdProveedor)
            if result.Correct!{
                let proveedor = result.Object as! Proveedor
                Nombre.text = proveedor.Nombre
                Telefono.text = String(proveedor.Telefono)
                
                Button.setTitle("Actualizar", for: .normal)
                Button.backgroundColor = UIColor.yellow
            }
            else{
                Button.setTitle("Agregar", for: .normal)
                print("Ocurrio un error \(result.ErrorMessage)")
            }
        }else{
            Button.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func AddButton(_ sender: UIButton) {
        let proveedor = Proveedor()
        proveedor.Nombre=Nombre.text
        proveedor.Telefono=Int(Telefono.text!)!
        
       let textbutton = sender.titleLabel
        if sender.titleLabel?.text == "GUARDAR"{
            Proveedor.Add(proveedor)
        }
        else if sender.titleLabel?.text == "Actualizar"{
            proveedor.IdProveedor = IdProveedor
            Proveedor.Update(proveedor)
        }
    }

}
