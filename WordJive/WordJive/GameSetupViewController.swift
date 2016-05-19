//
//  GameSetupViewController.swift
//  WordJive
//
//  Created by Oliver Short on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import CoreData

enum TableSections {
    case Title
    case Options
    case Capabilities
}

class GameSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var context: NSManagedObjectContext?
    var entity: NSEntityDescription?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let textFieldsArray = [["title": "Title", "placeholder": "Title", "key": "title"]]
    let slidersArray = [
        ["title": "Width", "placeholder": 20, "key": "width"],
        ["title": "Height", "placeholder": 20, "key": "height"],
        ["title": "Words", "placeholder": 10, "key": "words"],
        ["title": "Min Word Length", "placeholder": 4, "key": "minWordLength"],
        ["title": "Max Word Length", "placeholder": 10, "key": "maxWordLength"]]
    
    var capabilitiesArray = [[String: String]]()
    var selectedCapabilities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        playButton.layer.cornerRadius = 7.0
        playButton.layer.borderColor = UIColor(red: (13/255.0), green: (95/255.0), blue: (255/255.0), alpha: 1.0).CGColor
        playButton.titleLabel?.font = UIFont(name: "Pacifico", size: 24)
        
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
        var dataDictionary = [String: AnyObject]()
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        for index in 0...textFieldsArray.count-1 {
            let indexPath = NSIndexPath(forRow: index, inSection: TableSections.Title.hashValue)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SettingsTableViewCell {
                if cell.settingTextField.text != "" {
                    newManagedObject.setValue(cell.settingTextField.text, forKey: textFieldsArray[index]["key"]!)
                } else {
                    newManagedObject.setValue(textFieldsArray[index]["placeholder"], forKey: textFieldsArray[index]["key"]!)
                }
            }
        }
        
        for index in 0...slidersArray.count-1 {
            let indexPath = NSIndexPath(forRow: index, inSection: TableSections.Options.hashValue)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? SliderTableViewCell {
                if cell.valueSlider.value != 0.0 {
                    newManagedObject.setValue(Int(cell.valueSlider.value), forKey: slidersArray[index]["key"]! as! String)
                    dataDictionary[slidersArray[index]["key"]! as! String] = Int(cell.valueSlider.value)
                } else {
                    newManagedObject.setValue(slidersArray[index]["placeholder"], forKey: slidersArray[index]["key"]! as! String)
                    dataDictionary[slidersArray[index]["key"]! as! String] = slidersArray[index]["placeholder"]
                }
            }
        }
        
        newManagedObject.setValue(false, forKey: "completed")
        dataDictionary["capabilities"] = selectedCapabilities
        
        // Save the context.
        do {
            try context!.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        BackEndRequests.getPuzzle(dataDictionary)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Table view stuff
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case TableSections.Title.hashValue:
            return "Title"
        case TableSections.Options.hashValue:
            return "Game options"
        case TableSections.Capabilities.hashValue:
            return "Choose at least one option below"
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case TableSections.Title.hashValue:
            return textFieldsArray.count
        case TableSections.Options.hashValue:
            return slidersArray.count
        case TableSections.Capabilities.hashValue:
            return capabilitiesArray.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        switch indexPath.section {
        case TableSections.Title.hashValue:
            cell = configureTitleCell(indexPath)
        case TableSections.Options.hashValue:
            cell = configureOptionsCell(indexPath)
        case TableSections.Capabilities.hashValue:
            cell = configureCapabilitiesCell(indexPath)
        default:
            break
        }
        
        return cell!
    }
    
    func configureTitleCell(indexPath: NSIndexPath) -> SettingsTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as? SettingsTableViewCell
        cell?.settingLabel.text = textFieldsArray[indexPath.row]["title"]
        cell?.settingTextField.placeholder = textFieldsArray[indexPath.row]["placeholder"]
        return cell!
    }
    
    func configureOptionsCell(indexPath: NSIndexPath) -> SliderTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SliderCell", forIndexPath: indexPath) as? SliderTableViewCell
        cell?.titleLabel.text = slidersArray[indexPath.row]["title"] as? String
        if let sliderValue = slidersArray[indexPath.row]["placeholder"] as? Int {
            cell?.valueLabel.text = String(sliderValue)
        } else {
            cell?.valueLabel.text = ""
        }
        cell?.valueSlider.maximumValue = slidersArray[indexPath.row]["placeholder"] as! Float
        cell?.valueSlider.minimumValue = 2
        cell?.valueSlider.value = slidersArray[indexPath.row]["placeholder"] as! Float
        return cell!
    }
    
    func configureCapabilitiesCell(indexPath: NSIndexPath) -> CapabilitiesTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CapabilitiesCell", forIndexPath: indexPath) as? CapabilitiesTableViewCell
        cell?.capabilityLabel.text = capabilitiesArray[indexPath.row]["name"]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == TableSections.Capabilities.hashValue {
            let cell = tableView.cellForRowAtIndexPath(tableView.indexPathForSelectedRow!) as? CapabilitiesTableViewCell
            
            if cell?.accessoryType.hashValue == UITableViewCellAccessoryType.None.hashValue {
                cell?.accessoryType = .Checkmark
                if let capability = capabilitiesArray[indexPath.row]["keyword"] {
                    selectedCapabilities.append(capability)
                }
            } else {
                cell?.accessoryType = .None
            }
        }
    }

}
