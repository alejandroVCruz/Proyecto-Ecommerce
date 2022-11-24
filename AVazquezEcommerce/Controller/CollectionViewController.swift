//
//  CollectionViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 04/10/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    var producto = Producto()
    var productos : [Producto] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
            collectionView.register(UINib(nibName: "ProductoCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "ProductoCollectionViewCell")
    }
    func loadData()
    {
        do{
            var result = try! Producto.GetAll()
            if result.Correct!{
             productos = result.Objects as! [Producto]
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
        return productos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCollectionViewCell", for: indexPath) as! ProductoCollectionViewCell
        let producto : Producto = productos[indexPath.row]
        cell.Nombre.text = producto.Nombre
        cell.Precio.text = String(producto.PrecioUnitario)
        return cell
    }
}
