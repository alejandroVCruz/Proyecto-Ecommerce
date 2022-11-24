//
//  DepartamentoController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 26/10/22.
//
import iOSDropDown

import UIKit

class DepartamentoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var IdDepartamento : Int = 0
    var IdArea : Int = 0
    
    var arrayArea: [String] = []
    var arrayIdArea: [Int] = []
    var result = Result()
    var areas : [Area] = []
    
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var Nombre: UITextField!
    
    
    @IBOutlet weak var AreaDropDown: DropDown!
    
    
    @IBOutlet weak var Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validar()
        imagePicker.delegate = self
        
        LoadDataArea()
        AreaDropDown.optionArray = arrayArea
        AreaDropDown.optionIds = arrayIdArea
        
        AreaDropDown.didSelect { selectedText, index, id in
            self.IdArea = id }

        // Do any additional setup after loading the view.
    }
    func Validar(){
        if IdDepartamento != 0{
            let result: Result = Departamento.GetById(IdDepartamento)
            if result.Correct!{
                let departamento = result.Object as! Departamento
                Nombre.text = departamento.Nombre
                AreaDropDown.text = String(departamento.area.IdArea)
                
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
        let departamento = Departamento()
        departamento.Nombre=Nombre.text
        departamento.area.IdArea=IdArea
        
       let textbutton = sender.titleLabel
        if sender.titleLabel?.text == "GUARDAR"{
            Departamento.Add(departamento)
        }
        else if sender.titleLabel?.text == "Actualizar"{
            departamento.IdDepartamento = IdDepartamento
            Departamento.Update(departamento)
        }
    }
    
    @IBAction func seleccionarFoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
       
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func TomarFoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        Imagen?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    func LoadDataArea(){
         result = try! Area.GetAll()
        if result.Correct!{
            areas = result.Objects as! [Area]
            for area in areas{
                arrayArea.append(area.Nombre!)
                arrayIdArea.append(area.IdArea)
            }
        }
    }
}
