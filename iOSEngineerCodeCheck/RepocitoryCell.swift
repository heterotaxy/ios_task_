//
//  RepocitoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 高橋晴矢 on 2021/07/31.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepocitoryCell: UITableViewCell {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var detailtextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
