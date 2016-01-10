//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Dhruv Upadhyay on 1/9/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var overviewCell: UILabel!
    
    @IBOutlet var posterView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
