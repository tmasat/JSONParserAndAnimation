//
//  TableViewCell.swift
//  ReadJSONAndMotion
//
//  Created by Çağrı Tuğberk MASAT on 6.09.2019.
//  Copyright © 2019 Çağrı Tuğberk MASAT. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
