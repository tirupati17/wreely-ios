//
//  Constant.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 10/11/17.
//  Copyright © 2017 CelerStudio. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

enum ViewIdentifier : String {
    case login = "LoginView"

}

var isIPhoneX : Bool { return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 }
var isPlayce : Bool { return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String == "com.wreely.playce" }

let kTabBarHeight : CGFloat = isIPhoneX ? 73 : 49
let kToolBarHeight : CGFloat = 40

class WSConstant {
    //Workspace specific setting
    static var WorkspaceTintColor : UIColor {
        return UIColor.themeColor()
    }

    static var WorkspaceDisplayName : String {
        if isPlayce { //The Playce
            return "The Playce"
        } else { //The Workloft
            return "Workloft"
        }
    }

    static var WorkspaceMediumLogo : String {
        if isPlayce { //The Playce
            return "7-logo-medium"
        } else { //The Workloft
            return "8-logo-medium"
        }
    }
    
    static var WorkspaceLargeLogo : String {
        if isPlayce { //The Playce
            return "7-logo-large"
        } else { //The Workloft
            return "8-logo-large"
        }
    }
    
    static var WorkspaceAppleId : String {
        if isPlayce { //The Playce
            return "1455717998"
        } else { //The Workloft
            return "1453841889"
        }
    }
    
    static var WorkspaceAppleUrl : String {
        return "itms://itunes.apple.com/us/app/apple-store/id\(self.WorkspaceAppleId)?mt=8"
    }
    
    static var WorkspaceWebsiteUrl : String {
        if isPlayce { //The Playce
            return "https://theplayce.in/"
        } else { //The Workloft
            return "https://www.workloft.in"
        }
    }
    
    static var OneSignalKey : String {
        return "b760c5a5-cf5e-4a24-8629-8f7feb57a4b9"
    }
    static var MixPanelToken : String {
        return "3f6651d5c7ffd264fb50afe9fc595403"
    }
    
    static var GoogleMapKey : String {
        return "AIzaSyCxwjQZQX9ubjBm1yAfyvnP-hoyYsKGj1A"
    }
    
    static var UXCamKey : String {
        return "e2d866b51291360"
    }
    
    static var UserExperiorKey : String {
        return "971b9704-d0c3-45f6-ab4f-1abe79cdcae5" //"5671b758-1b2b-4aad-91c1-ce7d12e3eab5"//"2f6edf35-43d3-4951-8306-4bf0f688365a"
    }
    
    static var MapBoxToken : String {
        return "pk.eyJ1Ijoid3JlZWx5IiwiYSI6ImNqbDJra2VjdzFyazIzcm41Z2VueHBtZGkifQ.Es69bb5P7WbiCiDqSyCqf"
    }
    
    static var AppDateFormat : String {
        return "yyyy MMM dd HH:mm a"
    }
    
    static var GetServerDateFormat : DateFormatter {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = WSConstant.ServerDateFormat
        return dateFormatter
    }
    
    static var GetNormalDateFormat : DateFormatter {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = WSConstant.NormalDateFormat
        return dateFormatter
    }

    static var Get24HourTimeFormat : DateFormatter {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }

    static var GetTimeFormat : DateFormatter {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }
    
    static var NormalDateFormat : String {
        return "MMM dd"
    }
    
    static var ServerDateFormat : String {
        return "yyyy-MM-dd HH:mm:ss"
    }
    static var AppTitle : String {
        return "Wreely - Community Platform"
    }
    static var AppCustomFontMedium : String {
        return "FSMe-Regular" //there no medium font of FSMe
    }
    static var AppCustomFontRegular : String {
        return "FSMe-Regular"
    }
    static var AppCustomFontBold : String {
        return "FSMe-Bold"
    }
    
    static var StateArray : [String] {
        return  ["Andaman and Nicobar Islands","Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh","Chhattisgarh","Dadra and Nagar Haveli","Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Orissa","Pondicherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttaranchal","Uttar Pradesh","West Bengal"]
    }
}
