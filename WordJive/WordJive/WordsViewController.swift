//
//  WordsViewController.swift
//  WordJive
//
//  Created by Allen Spicer on 7/16/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//


import UIKit

class WordsViewController: UIViewController {
    
    var solutionsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        placeSolutionsFromArrayOnView()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func placeSolutionsFromArrayOnView(){
        solutionsArray = ["FED", "ON", "AT", "OH"]
        var i = 0
        while i < solutionsArray.count{
        let width = view.frame.width
        let rect = CGRectMake(0, CGFloat(20*i+100), width, 20)
        let newLabel = UILabel.init(frame: rect)
        newLabel.text = solutionsArray[i]
        newLabel.textAlignment = .Center
        self.view.addSubview(newLabel)
            i = i + 1

        }
        
    }
    
    
    
    
    
    
    
    
}