//
//  TestsModel.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 15/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

//
import UIKit
import ObjectMapper

class TestsModel: Mappable {
    var testId : Int?
    var patientId : Int?
    var testDate: NSDate?
    var dateOfBirth: NSDate?
    var hasMigrene: Bool?
    var gender: String?
    var usesDrugs: Bool?
    var score : Double?

    
    required init?(_ map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        testId              <- map["testId"]
        patientId           <- map["patientId"]
        testDate            <- map["testDate"]
        dateOfBirth         <- map["dateOfBirth"]
        hasMigrene          <- map["hasMigrene"]
        gender              <- map["gender"]
        usesDrugs           <- map["usesDrugs"]
        score               <- map["score"]
    }
    
}
