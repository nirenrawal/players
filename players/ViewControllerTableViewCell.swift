//
//  ViewControllerTableViewCell.swift
//  players
//
//  Created by Nirendra Singh Rawal on 16/05/2021.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSport: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
