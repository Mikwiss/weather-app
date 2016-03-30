//
//  MomentViewCell.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 08/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import UIKit

class MomentViewCell: UICollectionViewCell {

    @IBOutlet weak var momentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(text : String)
    {
        momentLbl.text = text;
    }
}
