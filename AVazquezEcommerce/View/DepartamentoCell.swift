//
//  DepartamentoCell.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 26/10/22.
//
import SwipeCellKit

import UIKit

class DepartamentoCell: SwipeTableViewCell {
    
    
    @IBOutlet weak var IdDepartamento: UILabel!
    
    @IBOutlet weak var Nombre: UILabel!
    
    @IBOutlet weak var Area: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
