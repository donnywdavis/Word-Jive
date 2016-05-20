//
//  PuzzleViewController.swift
//  WordJive
//
//  Created by Donny Davis on 5/17/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import CoreData

class PuzzleViewController: UIViewController {
    
@IBOutlet weak var detailDescriptionLabel: UILabel!
    
let word:NSMutableString = ""
var gameItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()}}

    func configureView() {
        // Update the user interface for the detail item.
        if let game = self.gameItem {
            navigationController?.navigationItem.title = game.valueForKey("title") as? String
            
            // add other items from core data
            
            //combine object access - place in viewdidload
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        let width = 2
        let height = 3
                
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
            
            self.view.addSubview(newLabel)
        }
    
    
    @IBAction func lettersTouched(recognizer:UIPanGestureRecognizer) {
        
        //extract coordinates
        let placeOnView = recognizer.locationInView(self.view)
        
        
        switch recognizer.state {
        case .Changed:
            if let subViewTouched = self.view.hitTest(placeOnView, withEvent: nil) as? UILabel {
               
                //change to expanding oval
                subViewTouched.backgroundColor = .redColor()
              
                //only append when label firing is unique
                word.appendString(subViewTouched.text!)
                print(word)
                print(placeOnView) }
        default:
            break
        }
        //append text from the touched subview to an array.
        
    }

    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

