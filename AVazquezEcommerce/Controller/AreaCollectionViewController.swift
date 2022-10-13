//
//  AreaCollectionViewController.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 11/10/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class AreaCollectionViewController: UICollectionViewController {
    
    var area = Area()
    var areas : [Area] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "AreaCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "AreaCollectionViewCell")
        // Do any additional setup after loading the view.
    }

    func loadData()
    {
        do{
            var result = try! Area.GetAll()
            if result.Correct!{
             areas = result.Objects as! [Area]
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
        return areas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCollectionViewCell", for: indexPath) as! AreaCollectionViewCell
    
        let area : Area = areas[indexPath.row]
        cell.Nombre.text = area.Nombre
    
        return cell
    }

   
}
