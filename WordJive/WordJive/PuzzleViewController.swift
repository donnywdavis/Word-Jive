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
    @IBOutlet weak var selectionLabel: UILabel!
    
    
    var labelArray = [UILabel]()
    var samplePuzzle = [String]()
    var currentWord = ""
    var i = 0
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
        buildSamplePuzzle()
        
        let width = 10
        let height = 10
        
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
        arrivalAnimation()
        
    }
    
    
    func labelCreator(a:Int, b:Int){
        //convert int to float
        let a10 = CGFloat(a*25)
        let b10 = CGFloat(b*25+50)
        
        //create unique frame on the view using these inputs
        let labelPlacement = CGRectMake(a10, b10, CGFloat(20), CGFloat(20))
        
        //create a label to hold each letter
        let newLabel = UILabel.init(frame: labelPlacement)
        newLabel.text = samplePuzzle[i]
        newLabel.font = UIFont.systemFontOfSize(20)
        newLabel.textAlignment = .Center
        newLabel.userInteractionEnabled = true
        newLabel.layer.cornerRadius = 5
        newLabel.clipsToBounds = true
        i = 1+i
        
        self.view.addSubview(newLabel)
    }
    
    
    @IBAction func lettersTouched(recognizer:UIPanGestureRecognizer) {
        
        //extract coordinates
        let placeOnView = recognizer.locationInView(self.view)
        
        
        switch recognizer.state {
        case .Began:
            
            
            if let subViewTouched = self.view.hitTest(placeOnView, withEvent: nil) as? UILabel {
                
                //change to expanding oval
                subViewTouched.backgroundColor = .redColor()
                subViewTouched.textColor = .whiteColor()
                
                //only append when label firing is unique
                if labelArray.last != subViewTouched{
                    labelArray.append(subViewTouched)}
                print(placeOnView) }
            
            
        case .Changed:
            if let subViewTouched = self.view.hitTest(placeOnView, withEvent: nil) as? UILabel {
                
                //change to expanding oval
                subViewTouched.backgroundColor = .redColor()
                subViewTouched.textColor = .whiteColor()
                
                //only append when label firing is unique
                if labelArray.last != subViewTouched{
                    labelArray.append(subViewTouched)}
                print(placeOnView) }
            
            
        case .Ended:
            printLabelArrayContents()
            //if word is valid
            if currentWord == "FED" || currentWord == "NDTJ"{
                //tag all labels with accesibitiy label "Correct"
                for label in labelArray{
                    label.accessibilityLabel = "Correct"
                    correctAnimation()
                }
            }
            //if not already a part of a correct word erase all color changes
            for label in labelArray{
                if label.accessibilityLabel != "Correct"{
                    label.backgroundColor = UIColor.clearColor()
                    label.textColor = UIColor.blackColor()
                }
            }
            currentWord = ""
            labelArray = []
            
        default:
            break
        }
    }
    
    func printLabelArrayContents(){
        for label in labelArray{
            currentWord.appendContentsOf(label.text!)
        }
        print(currentWord)
        selectionLabel.text = currentWord
    }
    
    func buildSamplePuzzle(){
        let array = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        samplePuzzle = array
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func correctAnimation(){
        for label in labelArray{
            UIView.animateWithDuration(1.0, animations: {
                label.frame.size.height = 23
                label.frame.size.width = 23
            })
        }
        
    }
    
    func arrivalAnimation(){
        for subViews in view.subviews{
            UIView.animateWithDuration(0.5, animations: {
                subViews.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            })
        }
        
    }
    
    
    
    
    
    
    
    
    
}
