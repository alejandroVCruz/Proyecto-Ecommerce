//
//  ProveedorTableViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 18/10/22.
//
import SwipeCellKit

import UIKit

class ProveedorTableViewController: UITableViewController {
    
    var proveedor = Proveedor()
    var proveedores : [Proveedor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadData()
        
        tableView.register(UINib(nibName: "ProveedorCell", bundle: nil),forCellReuseIdentifier: "ProveedorCell")
        
    }
    
    func loadData()
    {
        do{
            var result = try! Proveedor.GetAll()
            if result.Correct!{
             proveedores = result.Objects as! [Proveedor]
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
        return proveedores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProveedorCell", for: indexPath) as! ProveedorCell
        
        cell.delegate = self
        
        let proveedor : Proveedor = proveedores[indexPath.row]
        cell.Nombre.text = proveedor.Nombre
        cell.Telefono.text = String(proveedor.Telefono)
        
        return cell
    }
    
}

extension ProveedorTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Borrar") { action, indexPath in
                let proveedor : Proveedor = self.proveedores[indexPath.row] as! Proveedor
                Proveedor.Delete(IdProveedor: proveedor.IdProveedor)
                self.loadData()
            }
            
            return [deleteAction]
            
            
        }else {let UpdateAction = SwipeAction(style: .default, title: "Actualizar") { action, indexPath in
            self.proveedor = self.proveedores[indexPath.row]
            self.performSegue(withIdentifier: "proveedor", sender: self)
        }
        return [UpdateAction]
            
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proveedor"{
            var ProveedorController = segue.destination as? ProveedorViewController
            
            ProveedorController?.IdProveedor = self.proveedor.IdProveedor
            
            //var ViewController = segue.destination as? ViewController
                
                        //    ViewController?.IdUsuario =  self.usuario.IdUsuario
          }
       }

    }
