//
//  UsuarioController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 23/09/22.
//

import SwipeCellKit

import UIKit

class UsuarioController: UITableViewController {

    var usuario = Usuario()
    var usuarios : [Usuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       	loadData()
        
        tableView.register(UINib(nibName: "UsuarioCell", bundle: nil),forCellReuseIdentifier: "UsuarioCell")
       
    }
    
    func loadData()
    {
        do{
            var result = try! Usuario.GetAll()
            if result.Correct!{
             usuarios = result.Objects as! [Usuario]
                tableView.reloadData()
            }
        }catch{
            print("Ocurrio un error")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        
        cell.delegate = self
        
        let usuario : Usuario = usuarios[indexPath.row]
        cell.Nombre.text = usuario.Nombre
        cell.ApellidoPaterno.text = usuario.ApellidoPaterno
        cell.ApellidoMaterno.text = usuario.ApellidoMaterno
        cell.Username.text = usuario.Username
        cell.Contrasena.text = usuario.Contrasena
        
        return cell
    }

}

extension UsuarioController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Borrar") { action, indexPath in
                let usuario : Usuario = self.usuarios[indexPath.row] as! Usuario
                Usuario.Delete(IdUsuario: usuario.IdUsuario)
                self.loadData()
            }
            
            return [deleteAction]
            
            
        }else {let UpdateAction = SwipeAction(style: .default, title: "Actualizar") { action, indexPath in
            self.usuario = self.usuarios[indexPath.row] as! Usuario
            self.performSegue(withIdentifier: "UsuarioSegues", sender: self)
            self.loadData()
        }
        return [UpdateAction]
            
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UsuarioSegues"{
            var UsuarioController = segue.destination as? ViewController
            
            UsuarioController?.IdUsuario = self.usuario.IdUsuario
            
            //var ViewController = segue.destination as? ViewController
                
                        //    ViewController?.IdUsuario =  self.usuario.IdUsuario
          }
       }

    }
