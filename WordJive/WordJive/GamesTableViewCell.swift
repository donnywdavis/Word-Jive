//
//  GamesTableViewCell.swift
//  WordJive
//
//  Created by Donny Davis on 5/19/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import CoreData

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(object: NSManagedObject?) {
        if let object = object {
            gameTitleLabel.text = object.valueForKey("title") as? String
        }
    }

}
