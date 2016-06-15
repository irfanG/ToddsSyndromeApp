//
//  NetworkController.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 15/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import  Foundation
import  ObjectMapper
import  Alamofire






class NetworkController{
    
//    //MARK: - Singleton -
//    static let sharedInstance = NetworkController()
//    
//    func setCallString(relativeURL : String, inlineParam: [String: AnyObject]) -> NSURL!{
//        
//        let s = Constants.URL.baseUrl + relativeURL
//        let st: NSURL? = NSURL(string: s)
//        return st
//    }
//    
//    //MARK: - GET USER TOKEN API CALL-
//    /*
//     ** get all records
//     */
//    func getAllRecords(completionHandler: (isSuccess: Bool, responseObject: PatientsModel) -> Void) {
//        let completion = completionHandler
//        let param = ["fb_token": NSUserDefaults.standardUserDefaults().valueForKey("fbToken") as! String]
//        
//        func sendRequest() {
//            Alamofire.request(.GET, setCallString(Constants.Services.GET_ALL_RECORDS, inlineParam:param), parameters: nil, encoding: .URL, headers: nil).responseObject{ (response: Response<PatientsModel, NSError>) in
//                debugPrint(response)
//            }
//        }
//    }
}

