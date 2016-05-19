//
//  DetailViewController.swift
//  WordJive
//
//  Created by Donny Davis on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var gameItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let game = self.gameItem {
            navigationController?.navigationItem.title = game.valueForKey("title") as? String
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        let width = 11
        let height = 20
        
            
            //if something is input by user
            if ((1<width) && (1<height) &&
                (width<21) && (height<21)){
                
                //change user input to int
                var x = Int(width)
                var y = Int(height)
                
                //store x value for later
                let xSub = x
                
                //loop through y values (columns)
                while (y>0){
                    
                    //loop through x values (rows). One row for each y value
                    while (x>0) {
                        
                        //each time through fire label creator
                        labelCreator(x,b:y)
                        x = x-1
                    }
                    x = xSub
                    y = y-1
                }
                
            }
        
        
        
    
    
    self.configureView()
}

        func labelCreator(a:Int, b:Int){
            //convert int to float
            let a10 = CGFloat(a*25)
            let b10 = CGFloat(b*25+50)
            
            //create unique frame on the view using these inputs
            let labelPlacement = CGRectMake(a10, b10, CGFloat(20), CGFloat(20))
            
            //create a label with the frame
            let newLabel = UILabel.init(frame: labelPlacement)
            
            //substitute this text for specific index of array and loop through.
            newLabel.text = "A"
            newLabel.userInteractionEnabled = true
            self.view.insertSubview(newLabel, atIndex: a)
        }
    
    
    @IBAction func lettersTouched(recognizer:UIPanGestureRecognizer) {
        
        
        
        let placeOnView = recognizer.locationInView(self.view)
        
        switch recognizer.state {
        case .Changed:
            if let subViewTouched = self.view.hitTest(placeOnView, withEvent: nil) as? UILabel {
                subViewTouched.backgroundColor = .redColor()
                print(subViewTouched)
                print(placeOnView) }
        default:
            break
        }
    }

    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

