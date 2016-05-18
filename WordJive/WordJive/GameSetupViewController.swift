//
//  GameSetupViewController.swift
//  WordJive
//
//  Created by Oliver Short on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import CoreData

class GameSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var context: NSManagedObjectContext?
    var entity: NSEntityDescription?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let settingsArray = [
        ["title": "Title", "placeholder": "Title", "key": "title"],
        ["title": "Width", "placeholder": "20", "key": "width"],
        ["title": "Height", "placeholder": "20", "key": "height"],
        ["title": "Words", "placeholder": "10", "key": "words"],
        ["title": "Min Word Length", "placeholder": "4", "key": "minWordLength"],
        ["title": "Max Word Length", "placeholder": "10", "key": "maxWordLength"]]
    
    let capabilityArray = ["Horizontal", "Vertical", "Angle", "Whatever"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        playButton.layer.cornerRadius = 7.0
        playButton.layer.borderColor = UIColor(red: (13/255.0), green: (95/255.0), blue: (255/255.0), alpha: 1.0).CGColor
        playButton.titleLabel?.font = UIFont (name: "Pacifico", size: 24)
        
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
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity!.name!, inManagedObjectContext: context!)
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        for index in 0...settingsArray.count {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SettingsTableViewCell {
                if cell.settingTextField.text != "" {
                    newManagedObject.setValue(cell.settingTextField.text, forKey: settingsArray[index]["title"]!)
                } else {
                    newManagedObject.setValue(settingsArray[index]["placeholder"], forKey: settingsArray[index]["key"]!)
                }
            }
        }
        
        // Save the context.
        do {
            try context!.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Table view stuff
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return settingsArray.count
        case 1:
            return capabilityArray.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        switch indexPath.section {
        case 0:
            cell = configureOptionsCell(indexPath)
        case 1:
            cell = configureCapabilitiesCell(indexPath)
        default:
            break
        }
        
        return cell!
    }
    
    func configureOptionsCell(indexPath: NSIndexPath) -> SettingsTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameSetupCell", forIndexPath: indexPath) as? SettingsTableViewCell
        cell?.settingLabel.text = settingsArray[indexPath.row]["title"]
        cell?.settingTextField.placeholder = settingsArray[indexPath.row]["placeholder"]
        return cell!
    }
    
    func configureCapabilitiesCell(indexPath: NSIndexPath) -> CapabilitiesTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CapabilitiesCell", forIndexPath: indexPath) as? CapabilitiesTableViewCell
        cell?.capabilityLabel.text = capabilityArray[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "CHOOSE AT LEAST ONE OPTION BELOW"
        }
        return nil
    }

}
