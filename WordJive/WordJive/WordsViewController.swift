//
//  WordsViewController.swift
//  WordJive
//
//  Created by Allen Spicer on 7/16/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//


import UIKit

class WordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var words: [String]?
    var wordList: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension WordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WordCell", forIndexPath: indexPath)
        
        if let word = wordList?[indexPath.row] {
            cell.textLabel?.text = word
            
            if let words = words where !words.contains(word) {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        return cell
    }
    
}