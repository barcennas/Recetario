//
//  recetaCell.swift
//  Recetario
//
//  Created by Abraham Barcenas M on 10/21/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit

class recetaCell: UITableViewCell {

    @IBOutlet var imagen: UIImageView!
    @IBOutlet var nombre: UILabel!
    @IBOutlet var descripcion: UILabel!
    @IBOutlet var tiempo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
