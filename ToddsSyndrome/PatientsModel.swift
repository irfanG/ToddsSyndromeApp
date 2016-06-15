//
//  PatientsModel.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 15/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//
import UIKit
import ObjectMapper

class PatientsModel: Mappable {
    var patiendId : Int?
    var patientname : String?
        
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        patiendId          <- map["patientId"]
        patientname         <- map["patientName"]
    }
    
}
