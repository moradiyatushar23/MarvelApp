//
//  AppConstants.swift
//  MarvelDemo
//
//  Created by iMac on 06/09/21.
//

import Foundation
import UIKit
 
struct AppConstants {

    static let AppName                              = ""
    static let serverUrl                            = "https://gateway.marvel.com/v1/public"
    
    static let publicKey = "e7f385204edfef87d169f1e220737b3e"
    static let privateKey = "0b1d907dea3ac91ff03cac7690afdbe7ab8287da"

    
    //MARK:  API Path
    struct URL {
        
        static let comics                       = "/comics?"
    }
    
    struct ScreenSize {
        static var SCREEN_WIDTH: CGFloat {
            get {
                return UIScreen.main.bounds.size.width
            }
        }
        
        static var SCREEN_HEIGHT: CGFloat {
            get {
                return UIScreen.main.bounds.size.height
            }
        }
        
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct SafeAreaSpace {
        
        static var SCREEN_BOTTOM_SPACE: CGFloat {
            get {
                return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
            }
        }
        
        static var SCREEN_TOP_SPACE: CGFloat {
            get {
                return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
            }
        }
    }
    
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPHONE_XS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
        static let IS_IPHONE_XS_MAX     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0

        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    }
}

