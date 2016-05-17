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
        ["title": "Title", "placeholder": "Title"],
        ["title": "Width", "placeholder": "20"],
        ["title": "Height", "placeholder": "20"],
        ["title": "Words", "placeholder": "10"],
        ["title": "Min Word Length", "placeholder": "4"],
        ["title": "Max Word Length", "placeholder": "10"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        playButton.layer.cornerRadius = 7.0
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
            let indexPath = NSIndexPath(forRow: index, inSection: 1)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SettingsTableViewCell {
                if cell.settingTextField.text != "" {
                    newManagedObject.setValue(cell.settingTextField.text, forKey: settingsArray[index]["title"]!)
                } else {
                    newManagedObject.setValue(cell.settingTextField.placeholder, forKey: settingsArray[index]["title"]!)
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
