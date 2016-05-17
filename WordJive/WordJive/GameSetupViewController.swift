//
//  GameSetupViewController.swift
//  WordJive
//
//  Created by Oliver Short on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let settingsArray = [
        ["title": "Title", "placeholder": "Title"],
        ["title": "Width", "placeholder": "20"],
        ["title": "Height", "placeholder": "20"],
        ["title": "Words", "placeholder": "10"],
        ["title": "Min Word Length", "placeholder": "4"],
        ["title": "Max Word Length", "placeholder": "10"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.layer.cornerRadius = 7.0
        
        tableView.tableFooterView = UIView(frame: CGRectZero)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonPushed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func playButtonPushed(sender: UIButton) {
        
        
        
    }
    
    
    // MARK: Table view stuff
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameSetupCell", forIndexPath: indexPath) as? SettingsTableViewCell
        
        cell?.settingLabel.text = settingsArray[indexPath.row]["title"]
        cell?.settingTextField.placeholder = settingsArray[indexPath.row]["placeholder"]
        
        return cell!
    }

}
