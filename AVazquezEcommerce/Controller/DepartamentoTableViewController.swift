//
//  DepartamentoTableViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 26/10/22.
//
import SwipeCellKit

import UIKit

class DepartamentoTableViewController: UITableViewController {
    
    var departamento = Departamento()
    var departamentos : [Departamento] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
         
         tableView.register(UINib(nibName: "DepartamentoCell", bundle: nil),forCellReuseIdentifier: "DepartamentoCell")
    }
    
    func loadData()
    {
        do{
            var result = try! Departamento.GetAll()
            if result.Correct!{
             departamentos = result.Objects as! [Departamento]
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
        return departamentos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartamentoCell", for: indexPath) as! DepartamentoCell
        
        cell.delegate = self
        
        let proveedor : Departamento = departamentos[indexPath.row]
        cell.IdDepartamento.text = String(proveedor.IdDepartamento)
        cell.Nombre.text = proveedor.Nombre
        cell.Area.text = String(proveedor.IdArea)
        
        return cell
    }
}

extension DepartamentoTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .right{
            
            let deleteAction = SwipeAction(style: .destructive, title: "Borrar") { action, indexPath in
                let proveedor : Departamento = self.departamentos[indexPath.row] as! Departamento
                Departamento.Delete(IdDepartamento: self.departamento.IdDepartamento)
                self.loadData()
            }
            
            return [deleteAction]
            
            
        }else {let UpdateAction = SwipeAction(style: .default, title: "Actualizar") { action, indexPath in
            self.departamento = self.departamentos[indexPath.row]
            self.performSegue(withIdentifier: "Departamento", sender: self)
        }
        return [UpdateAction]
            
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Departamento"{
            var DepartamentoController = segue.destination as? DepartamentoController
            
            DepartamentoController?.IdDepartamento = self.departamento.IdDepartamento
            
            //var ViewController = segue.destination as? ViewController
                
                        //    ViewController?.IdUsuario =  self.usuario.IdUsuario
          }
       }

    }
