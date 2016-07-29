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
    
    var fetchedResultsController: NSFetchedResultsController?
    var context: NSManagedObjectContext?
    
    var currentWordLabelArray = [UILabel]()
    var puzzleLabelArray = [UILabel]()
    var samplePuzzle = [String]()
    var solutionsArray = [String]()
    var currentWord = ""
    var i = 0
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var gameItem: AnyObject?
    var puzzle = [[String]]()
    var words = [String]()
    var wordList = [String]()
    var game: Game?
    var completedWords = [String]()
    
    func configureView() {
        // Update the user interface for the detail item.
        if let game = self.gameItem as? Game {
            self.game = game
            navigationController?.navigationItem.title = self.game?.title
            do {
                let puzzleWordsData = try NSJSONSerialization.JSONObjectWithData((self.game?.puzzle)!, options: .AllowFragments) as! [String: AnyObject]
                puzzle = puzzleWordsData["puzzle"] as! [[String]]
                wordList = (puzzleWordsData["words"] as! [[String: AnyObject]]).map{
                    dictionaryElement in
                    return dictionaryElement["word"] as! String
                }
                words = wordList
                
                
                //solutionsArray.appendContentsOf(words.objectForKey("words"))
            } catch {
                print("Cannot parse puzzle data.")
            }
            
            // add other items from core data
            
            //combine object access - place in viewdidload
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = fetchedResultsController?.managedObjectContext
        self.configureView()
        buildSamplePuzzle()
        setPuzzleSize()
        arrivalAnimation()
        setAnimation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Save the context.
        do {
            try context!.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    
    func setAnimation(){
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
        //newLabel.text = samplePuzzle[i]
        
        newLabel.text = puzzle[a-1][b-1]
        newLabel.font = UIFont.systemFontOfSize(25)
        newLabel.textAlignment = .Center
        newLabel.userInteractionEnabled = true
        newLabel.layer.cornerRadius = 5
        newLabel.clipsToBounds = true
        i = 1+i
        puzzleLabelArray.append(newLabel)
        self.view.addSubview(newLabel)
    }
    
    
    func setPuzzleSize(){
        
        //set width of puzzle from user input
        var x = Int((game?.width)!)
        //change user input to int
        //var x = Int(7)
        
        //set height of puzzle from user input
        var y = Int((game?.height)!)
        //var y = Int(10)
        
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
            if words.contains(currentWord){

                //tag all labels with accesibitiy label "Correct"
                for label in currentWordLabelArray{
                    label.accessibilityLabel = "Correct"
                    correctAnimation()
                }
                let currentWordIndex = words.indexOf(currentWord)
                words.removeAtIndex(currentWordIndex!)
                
                if words.isEmpty{
                    completeAnimation()
                    game?.completed = true
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

// MARK: Navigation

extension PuzzleViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WordsSegue" {
            let wordsVC = (segue.destinationViewController as? UINavigationController)?.topViewController as? WordsViewController
            wordsVC?.words = words
            wordsVC?.wordList = wordList
        }
    }
    
}
