//
//  Tests.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import Foundation
import CoreData


class Tests: NSManagedObject {
 

    func  validateTests() -> String? {
        if(self.dateOfBirth == 0){
            return Constants.ErrorMessages.kErrorPatientBirth
        }
        if(self.gender == nil){
            return Constants.ErrorMessages.kErrorPatientGender
        }
      
       
        return nil
    }

}
