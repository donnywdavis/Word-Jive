//
//  CreditsViewController.swift
//  WordJive
//
//  Created by Donny Davis on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red: (237/255.0), green: (28/255.0), blue: (36/255.0), alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor(red: (247/255.0), green: (148/255.0), blue: (30/255.0), alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: (247/255.0), green: (148/255.0), blue: (30/255.0), alpha: 1.0), NSFontAttributeName: UIFont(name: "Pacifico", size: 24)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
