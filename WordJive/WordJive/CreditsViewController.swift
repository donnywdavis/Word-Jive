//
//  CreditsViewController.swift
//  WordJive
//
//  Created by Donny Davis on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var iOSDevelopersLabel: UILabel!
    @IBOutlet weak var allenLabel: UILabel!
    @IBOutlet weak var oliverLabel: UILabel!
    @IBOutlet weak var donnyLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var javaDevelopersLabel: UILabel!
    @IBOutlet weak var daneLabel: UILabel!
    @IBOutlet weak var scottLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iOSDevelopersLabel.layer.masksToBounds = true
        iOSDevelopersLabel.layer.cornerRadius = 10
        javaDevelopersLabel.layer.masksToBounds = true
        javaDevelopersLabel.layer.cornerRadius = 10
        
        UIView.animateWithDuration(0.5) {
            self.allenLabel.center.x += self.view.bounds.width
        }
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: [.CurveEaseOut], animations: {
            self.oliverLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, options: [.CurveEaseOut], animations: {
            self.donnyLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: [.CurveEaseOut], animations: {
            self.nickLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.6, options: [.CurveEaseOut], animations: {
            self.daneLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.7, options: [.CurveEaseOut], animations: {
            self.scottLabel.center.x += self.view.bounds.width
            }, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        allenLabel.center.x -= view.bounds.width
        oliverLabel.center.x -= view.bounds.width
        donnyLabel.center.x -= view.bounds.width
        nickLabel.center.x -= view.bounds.width
        daneLabel.center.x -= view.bounds.width
        scottLabel.center.x -= view.bounds.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
