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
    
    
    var currentWordLabelArray = [UILabel]()
    var puzzleLabelArray = [UILabel]()
    var samplePuzzle = [String]()
    var solutionsArray = [String]()
    var currentWord = ""
    var i = 0
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
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
        
        
        //change user input to int
        var x = Int(7) //width
        var y = Int(10) //height
        
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
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVectorMake(0, 0.8)
        animator.addBehavior(gravity)
        collision = UICollisionBehavior()
        collision.collisionMode = UICollisionBehaviorMode.Boundaries
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
    }
    
    
    func labelCreator(a:Int, b:Int){
        //convert int to float
        let a10 = CGFloat(a*35)
        let b10 = CGFloat(b*35+50)
        
        //create unique frame on the view using these inputs
        let labelPlacement = CGRectMake(a10, b10, CGFloat(30), CGFloat(30))
    
        
        //create a label to hold each letter
        let newLabel = UILabel.init(frame: labelPlacement)
        newLabel.text = samplePuzzle[i]
        newLabel.font = UIFont.systemFontOfSize(25)
        newLabel.textAlignment = .Center
        newLabel.userInteractionEnabled = true
        newLabel.layer.cornerRadius = 5
        newLabel.clipsToBounds = true
        i = 1+i
        puzzleLabelArray.append(newLabel)
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
                subViewTouched.textColor = .yellowColor()
                
                //only append when label firing is unique
                if currentWordLabelArray.last != subViewTouched{
                    currentWordLabelArray.append(subViewTouched)}
                }
            
            
        case .Changed:
            if let subViewTouched = self.view.hitTest(placeOnView, withEvent: nil) as? UILabel {
                
                //change to expanding oval
                subViewTouched.backgroundColor = .redColor()
                subViewTouched.textColor = .yellowColor()
                
                //only append when label firing is unique
                if currentWordLabelArray.last != subViewTouched{
                    currentWordLabelArray.append(subViewTouched)}
                }
            
            
        case .Ended:
            printLabelArrayContents()
            
            //check word against array of correct answers instead of individually
            if solutionsArray.contains(currentWord){

                //tag all labels with accesibitiy label "Correct"
                for label in currentWordLabelArray{
                    label.accessibilityLabel = "Correct"
                    correctAnimation()
                }
                let currentWordIndex = solutionsArray.indexOf(currentWord)
                solutionsArray.removeAtIndex(currentWordIndex!)
                
                if solutionsArray.isEmpty{
                    completeAnimation()
                }
            }
            //if not already a part of a correct word erase all color changes
            for label in currentWordLabelArray{
                if label.accessibilityLabel != "Correct"{
                    label.backgroundColor = UIColor.clearColor()
                    label.textColor = UIColor.blackColor()
                }
            }
            currentWord = ""
            currentWordLabelArray = []
            
        default:
            break
        }
    }
    
    
    func printLabelArrayContents(){
        for label in currentWordLabelArray{
            currentWord.appendContentsOf(label.text!)
        }
        print(currentWord)
        selectionLabel.text = currentWord
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func correctAnimation(){
        for label in currentWordLabelArray{
            UIView.animateWithDuration(1.0,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.2,
                                       initialSpringVelocity: 5,
                                       options: UIViewAnimationOptions.CurveEaseOut,
                                       animations: {
                label.frame.size.height = 35
                label.frame.size.width = 35
                                        }, completion: nil)
            }
        }
    
    
    
    func arrivalAnimation(){

        for subViews in view.subviews{
            UIView.animateWithDuration(0.01,
                                       animations: {
                subViews.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
            })
        }
        for subViews in view.subviews{
            UIView.animateWithDuration(0.50,
                                       animations: {
                subViews.transform = CGAffineTransformMakeRotation(0.0)
            }, completion: nil)
        }
        
    }
    
    func completeAnimation(){
        for labels in puzzleLabelArray{
                    gravity.addItem(labels)
                    collision.addItem(labels)
        }

    }
    
    
    func buildSamplePuzzle(){
        let array = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        samplePuzzle = array
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        samplePuzzle.appendContentsOf(array)
        
        solutionsArray = ["FED","ON","AT", "OH"]
        
        
    }
    
}
