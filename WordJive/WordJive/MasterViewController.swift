//
//  MasterViewController.swift
//  WordJive
//
//  Created by Donny Davis on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, CapabilitiesDelegate {

    var detailViewController: PuzzleViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var capabilitiesArray: [[String: String]]? = nil
    var audioPlayer = AVAudioPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? PuzzleViewController
        }
        
        if let audioFilePath = NSBundle.mainBundle().pathForResource("WordJive", ofType: "mp3") {
            let audioURL = NSURL(fileURLWithPath: audioFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
                audioPlayer.play()
            } catch {
                print("Not able to play audio")
            }
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 126, height: 41))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "WordJiveTitleIcon")
        imageView.image = image
        navigationItem.titleView = imageView
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        animateTable()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        for cell in cells {
            if let cell = cell as? GamesTableViewCell {
                cell.center.x -= tableView.bounds.width
            } else {
                return
            }
        }
        
        var index = 0
        for cell in cells {
            if let cell = cell as? GamesTableViewCell {
                UIView.animateWithDuration(0.5, delay: (0.05 * Double(index)), options: [], animations: {
                        cell.center.x += self.tableView.bounds.width
                    }, completion: nil)
            }
            index += 1
        }
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PuzzleViewController
                controller.gameItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "settingsSegue" {
            let optionsVC = (segue.destinationViewController as! UINavigationController).topViewController as! GameSetupViewController
            optionsVC.fetchedResultsController = self.fetchedResultsController
            optionsVC.capabilitiesArray = capabilitiesArray!
            optionsVC.navigationController?.popoverPresentationController?.backgroundColor = UIColor(red: (237/255.0), green: (28/255.0), blue: (36/255.0), alpha: 1.0)
        }
        if segue.identifier == "CreditsSegue" {
            let creditsVC = (segue.destinationViewController as! UINavigationController).topViewController as! CreditsViewController
            creditsVC.navigationController?.popoverPresentationController?.backgroundColor = UIColor(red: (237/255.0), green: (28/255.0), blue: (36/255.0), alpha: 1.0)
        }
    }

    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = UIView()
            footerView.backgroundColor = UIColor.clearColor()
            return footerView
        } else {
            return UIView()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let title = UILabel()
        title.textColor = UIColor.whiteColor()
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = title.textColor
        header.textLabel?.textAlignment = .Center
        header.contentView.backgroundColor = UIColor(red: (197/255.0), green: (44/255.0), blue: (0/255.0), alpha: 1.0)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = self.fetchedResultsController.sections![section]
        if let object = sectionInfo.objects?[0] as? NSManagedObject {
            switch object.valueForKey("completed") as! Bool {
            case false:
                return "Active games"
            case true:
                return "Completed games"
            }
        } else {
            return ""
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> GamesTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! GamesTableViewCell
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.configureCell(cell, withObject: object)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    func configureCell(cell: GamesTableViewCell, withObject object: NSManagedObject) {
        cell.setupCell(object)
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Game", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor1 = NSSortDescriptor(key: "completed", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "title", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: "completed", cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //print("Unresolved error \(error), \(error.userInfo)")
             abort()
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell((tableView.cellForRowAtIndexPath(indexPath!)! as! GamesTableViewCell), withObject: anObject as! NSManagedObject)
            case .Move:
                tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    // MARK: - CapabilitiesDelegate
    
    func availableCapabilities(data: [[String : String]]) {
        capabilitiesArray = data
    }

}

