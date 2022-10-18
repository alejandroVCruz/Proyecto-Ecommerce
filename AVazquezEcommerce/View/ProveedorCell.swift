//
//  ProveedorCell.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 18/10/22.
//
import SwipeCellKit

import UIKit

class ProveedorCell: SwipeTableViewCell {
    
    
    @IBOutlet weak var Nombre: UILabel!
    
    @IBOutlet weak var Telefono: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
