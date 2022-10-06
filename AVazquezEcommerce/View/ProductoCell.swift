//
//  ProductoCell.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 28/09/22.
//
import SwipeCellKit

import UIKit

class ProductoCell: SwipeTableViewCell {
    
    @IBOutlet weak var NombreProducto: UILabel!
    
    @IBOutlet weak var PrecioUnitario: UILabel!
    
    @IBOutlet weak var Stock: UILabel!
    
    @IBOutlet weak var Descripcion: UILabel!
    
    @IBOutlet weak var Departamento: UILabel!
    
    @IBOutlet weak var Proveedor: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
