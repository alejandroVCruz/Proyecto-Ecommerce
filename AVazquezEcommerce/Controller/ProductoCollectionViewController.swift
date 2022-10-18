//
//  ProductoCollectionViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 17/10/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductoCollectionViewController: UICollectionViewController {

    var producto = Producto()
    var productos : [Producto] = []
    var departamento = Departamento()
    var IdDepartamento : Int = 0
    var IdProducto : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView.register(UINib(nibName: "AreaCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "AreaCollectionViewCell")

        // Do any additional setup after loading the view.
    }
    
    func loadData()
    {
        do{
            var result = try! Producto.GetByIdP(IdDepartamento)
            if result.Correct!{
             productos = result.Objects as! [Producto]
                collectionView.reloadData()
            }
        }catch{
            print("Ocurrio un error")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCollectionViewCell", for: indexPath) as! AreaCollectionViewCell
    
        let producto : Producto = productos[indexPath.row]
        cell.Nombre.text = producto.Nombre
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

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
