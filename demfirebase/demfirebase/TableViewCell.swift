//
//  TableViewCell.swift
//  demfirebase
//
//  Created by abdul ahad on 06/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbltext: UILabel!
  
    
    var chatmodel: Chatmodel?{
        didSet{
            lblname.text = chatmodel?.name
            lbltext.text = chatmodel?.text
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
