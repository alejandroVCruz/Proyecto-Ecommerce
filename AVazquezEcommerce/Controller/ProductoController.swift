//
//  ProductoController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 03/10/22.
import SwipeCellKit

import UIKit

class ProductoController: UITableViewController {
    
    var producto = Producto()
    var productos : [Producto] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
     
     tableView.register(UINib(nibName: "ProductoCell", bundle: nil),forCellReuseIdentifier: "ProductoCell")
        
    }
    
    func loadData()
    {
        do{
            var result = try! Producto.GetAll()
            if result.Correct!{
             productos = result.Objects as! [Producto]
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
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        
        cell.delegate = self
        
        let producto : Producto = productos[indexPath.row]
        cell.NombreProducto.text = producto.Nombre
        cell.PrecioUnitario.text = String(producto.PrecioUnitario)
        cell.Stock.text = String(producto.Stock)
        cell.Descripcion.text = producto.Descripcion
        cell.Departamento.text = String(producto.departamento.IdDepartamento)
        cell.Proveedor.text = String(producto.proveedor.IdProveedor)
        


        return cell
    }
}

extension ProductoController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Borrar") { action, indexPath in
                let producto : Producto = self.productos[indexPath.row] as! Producto
                Producto.Delete(IdProducto: producto.IdProducto)
                self.loadData()
            }
            
            return [deleteAction]
            
            
        }else {let UpdateAction = SwipeAction(style: .default, title: "Actualizar") { action, indexPath in
            self.producto = self.productos[indexPath.row] as! Producto
            self.performSegue(withIdentifier: "ProductoSegues", sender: self)
            self.loadData()
        }
        return [UpdateAction]
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductoSegues"{
            var ProductoController = segue.destination as? ProductoViewController
            
            ProductoController?.IdProducto = self.producto.IdProducto
            
            //var ViewController = segue.destination as? ViewController
                
                        //    ViewController?.IdUsuario =  self.usuario.IdUsuario
          }
       }
}

