//
//  Patients.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import Foundation
import CoreData


class Patients: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func  validatePatient() -> String? {
        if(self.patientName?.characters.count < 2){
            return Constants.ErrorMessages.kErrorPatientName
        }
        
        return nil
    }
    

}
