//
//  Game+CoreDataProperties.swift
//  WordJive
//
//  Created by Donny Davis on 7/28/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Game {

    @NSManaged var completed: NSNumber?
    @NSManaged var height: NSNumber?
    @NSManaged var maxWordLength: NSNumber?
    @NSManaged var minWordLength: NSNumber?
    @NSManaged var title: String?
    @NSManaged var width: NSNumber?
    @NSManaged var numberOfWords: NSNumber?
    @NSManaged var puzzle: NSData?
    @NSManaged var completedWords: NSData?

}
