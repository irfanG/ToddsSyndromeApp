//
//  Constants.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import Foundation

struct Constants {
    
    struct URL {
        static let baseUrl = "http://somebackend:8080/"
        
    }
    
    struct NotificationKey {
        
    }
    
    
    struct Services {
        static let GET_ALL_RECORDS = "service/getRecords/page/{pageNumber}"
        static let ADD_PATIENT_REDORD = "service/savePatientRecord/{patientId}"
        static let GET_PATIENT_REDORD = "service/getPatientRecord/{patientId}"
        
    }
    
    struct CellIdentifiers {
        static let kCellRecordScore = "RecordScoreCell"
        static let kCellPatientScore = "PatientScoreCell"
        static let kCellProgressBar = "ProgressBarCell"
        
    }
    struct Controllers {
        static let kHomeVC = "HomeVC"
        static let kStartVC = "StartVC"
        static let kNewRecordVC = "NewRecordVC"
        
    }

    struct StaticTexts {
        static let kTextWelcome = "Welcome to Todds Syndrome App"
        static let kTextSwipeLeft = "< Help"
        static let kTextSwipeRight = "Swipe to Start >"
        static let kTextDontShow = "Don't show this screen"
        static let kCancel = "Cancel"
        static let kContinue = "Continue"
        static let kAge = "Enter patient date of birth"
        static let kGender = "Select patient gender"
        static let kMigrene = "Does patient suffer from migrenes?"
        static let kDrugs = "Does patient use hallucinogenic drugs?"
        static let kCalculate = "Calculate Todd's Syndrome risk factor:"
        static let kMale = "M"
        static let kFemale = "F"
        static let kYes = "Y"
        static let kNo = "N"
        static let kOften = "Often"
        static let kRare = "Rare"
        static let kResultExplanation = "The patients calculated result:"
        
    }
    
    struct  ErrorMessages {
        static let kErrorPatientName = "Please enter patient name"
        static let kErrorPatientNameMoreCharacters = "Patient name must contain at least 2 characters"
        static let kErrorPatientBirth = "Please enter patient birth date"
        static let kErrorPatientGender = "Please select patient gender"
        static let kErrorPatientMigrene = "Please chose how often patient has migrene"
        static let kErrorPatientDrugs = "Please chose is patient uses heavy drugs"
        static let kErrorSavingData = "Error saving data"
        
    }
}