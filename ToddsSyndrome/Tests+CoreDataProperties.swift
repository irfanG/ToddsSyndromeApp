//
//  Tests+CoreDataProperties.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tests {

    @NSManaged var testDate: NSTimeInterval
    @NSManaged var dateOfBirth: NSTimeInterval
    @NSManaged var hasMigrene: Bool
    @NSManaged var gender: String?
    @NSManaged var usesDrugs: Bool
    @NSManaged var patients: Patients?

}
