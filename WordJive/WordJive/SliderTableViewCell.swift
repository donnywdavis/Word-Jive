//
//  SliderTableViewCell.swift
//  WordJive
//
//  Created by Donny Davis on 5/18/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueSlider: UISlider!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func valueSliderAction(sender: UISlider) {
        valueLabel.text = String(Int(sender.value))
    }

}
