//
//  ApplicationData.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import UIKit
import Alamofire

/** This singleton class is used to store application level data. */
class ApplicationData: NSObject {

    // A Singleton instance
    static let sharedInstance = ApplicationData()
    
    
    //Headers
    static var authorizationHeaders : HTTPHeaders {
        
        get {
            return ["Content-Type" : "application/json"]
        }
    }
    
    //retun device Id
    static var deviceId: String {
        get {
            return UIDevice.current.identifierForVendor!.uuidString
        }
    }
    
    //retun device Name
    static var deviceName: String {
        get {
            return UIDevice.current.localizedModel
        }
    }
    
    
    //retun device version
    static var deviceVersion: String {
        get {
            return UIDevice.current.systemVersion
        }
    }
    
    static func buildVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary["CFBundleVersion"] as! String
        return "V \(build)"
    }
    
    //return UUID
    func getUUID() -> String {
        return UUID().uuidString
    }
    
}
