//
//  Helper.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 15/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import Foundation
class Helper{

    
     func calculateResult(testRecord : Tests) -> Double{
        var result = 0.0
        if(calculateAge(NSDate(timeIntervalSinceReferenceDate: (testRecord.dateOfBirth))) <= 15){
            result = result + 1
        }
        if(testRecord.gender == "M"){
            result = result + 1
        }
        if(testRecord.hasMigrene){
            result = result + 1
        }
        if(testRecord.usesDrugs){
            result = result + 1
        }
        
        
        return result*25
    }
   private func calculateAge(birthday : NSDate) -> Int{
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let ageComponents = calendar.components(.Year,
                                                fromDate: birthday,
                                                toDate: NSDate(),
                                                options: [])
        
        return ageComponents.year
    }

}