//
//  DepartamentoCollectionViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 11/10/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class DepartamentoCollectionViewController: UICollectionViewController {
    
    var departamento = Departamento()
    var departamentos : [Departamento] = []
    var area = Area()
    var IdArea : Int = 0
    var IdDepartamento : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView.register(UINib(nibName: "AreaCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "AreaCollectionViewCell")
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    func loadData()
    {
        do{
            var result = try! Departamento.GetById(IdArea)
            if result.Correct!{
             departamentos = result.Objects as! [Departamento]
                collectionView.reloadData()
            }
        }catch{
            print("Ocurrio un error")
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return departamentos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.departamento = self.departamentos[indexPath.row] as! Departamento
        self.performSegue(withIdentifier: "Id", sender: self)
        self.loadData()
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCollectionViewCell", for: indexPath) as! AreaCollectionViewCell
    
        let departamento : Departamento = departamentos[indexPath.row]
        cell.Nombre.text = departamento.Nombre
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Id"{
            var ProductoController = segue.destination as? ProductoCollectionViewController
            
            ProductoController?.IdDepartamento = self.departamento.IdDepartamento
            
            //var ViewController = segue.destination as? ViewController
                
                        //    ViewController?.IdUsuario =  self.usuario.IdUsuario
          }
       }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
  
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
