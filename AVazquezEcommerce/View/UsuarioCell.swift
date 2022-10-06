//
//  UsuarioCell.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 26/09/22.
//
import SwipeCellKit

import UIKit

class UsuarioCell: SwipeTableViewCell {
    
    @IBOutlet weak var Nombre: UILabel!
    
    @IBOutlet weak var ApellidoPaterno: UILabel!
    
    @IBOutlet weak var ApellidoMaterno: UILabel!
    
    @IBOutlet weak var Username: UILabel!
    
    @IBOutlet weak var Contrasena: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
