//
//  AppDelegate.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 19/12/17.
//  Copyright © 2017 Celerstudio. All rights reserved.
//

import UIKit
import Firebase
import Fabric
import Answers
import OneSignal
import Mixpanel
import SwiftLocation
//import GoogleMaps
//import Siren
//import Appsee
//import UXCam
import UserExperior

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let sharedDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    var window: UIWindow?
    var userExperiorInstance:UserExperiorInstance!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initDefaults(launchOptions)
        if #available(iOS 10, *) {
            setupRemoteNotifications(application)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //Siren.shared.checkVersion(checkType: .daily)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //Siren.shared.checkVersion(checkType: .daily)
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    func setRootViewController(_ rootController: UIViewController) {
        self.window?.rootViewController = rootController
    }
    
    func showMainTab() {
        let tabbar = SWTabBar.init()
        let menuItems = tabbar.createTabData()
        let tabController = SWTabBarController(incomingArray: menuItems)
        AppDelegate.sharedDelegate.setRootViewController(tabController)
    }
    
    func showMainView() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: "WSHomeViewController")
        let nv = UINavigationController.init(rootViewController: vc)
        AppDelegate.sharedDelegate.setRootViewController(nv)
    }
    
    func showLogin() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: WSOTPView.storyboardIdentifier)
        let nv = WSNavigationController.init(rootViewController: vc)
        AppDelegate.sharedDelegate.setRootViewController(nv)
    }
    
    func logout() {
        WSSession.activeSession().logout()
        self.showLogin()
    }
    
    func firebaseLogin() {
        if (WSSession.activeSession().currentUser().memberFirKey?.isEmpty)! {
            WSFirebaseRequest.firebaseUserSignUp(WSSession.activeSession().currentUser().emailId!, WSSession.activeSession().currentUser().emailId!, { (user) in
                WSRequest.userFirebaseKeyUpdate(user.uid!, { (response) in
                    WSRequest.updateDataForCurrentUser(WSSession.activeSession().currentUser().toJSON())
                }, failure: { (error) in
                    print(error)
                })
            }) { (error) in
                print(error)
            }
        } else {
            WSFirebaseRequest.firebaseUserLogin(WSSession.activeSession().currentUser().emailId!, WSSession.activeSession().currentUser().emailId!, { (user) in
                WSRequest.updateDataForCurrentUser(WSSession.activeSession().currentUser().toJSON())
            }) { (error) in
                print(error)
            }
        }
    }
    
    func initDefaults(_ launchOptions:  [UIApplication.LaunchOptionsKey: Any]?) {
        Mixpanel.initialize(token: WSConstant.MixPanelToken, launchOptions: launchOptions, flushInterval: 10, instanceName: WSConstant.AppTitle, automaticPushTracking: false, optOutTrackingByDefault: false)

        //Appsee.start()
        //UXCam.start(withKey: WSConstant.UXCamKey)
    
        
        userExperiorInstance = UserExperior.initialize(WSConstant.UserExperiorKey)
        
        Fabric.with([Answers.self])
        FirebaseApp.configure()
        
        /*Firebase APNS */
        //Messaging.messaging().delegate = self
        //Messaging.messaging().isAutoInitEnabled = true
        
        //GMSServices.provideAPIKey(WSConstant.GoogleMapKey)

        setupOneSignal(launchOptions)
        setupAppAppearance()
        WSConnectionManager.sharedInstance.startMonitoringReachability()
        checkForUpdate()
    }
        
    func checkForUpdate() {
//        let siren = Siren.shared
//        
//        // Optional: Defaults to .option
//        siren.alertType = .force
//
//        // Optional: Change the various UIAlertController and UIAlertAction messaging. One or more values can be changes. If only a subset of values are changed, the defaults with which Siren comes with will be used.
//        siren.alertMessaging = SirenAlertMessaging(updateTitle: "New version available!",
//                                                   updateMessage: "Updating your apps gives you access to the latest features and performance improvements",
//                                                   updateButtonMessage: "Update Now",
//                                                   nextTimeButtonMessage: "OK, next time it is!")
//
//        // Optional: Set this variable if you would only like to show an alert if your app has been available on the store for a few days.
//        // This default value is set to 1 to avoid this issue: https://github.com/ArtSabintsev/Siren#words-of-caution
//        // To show the update immediately after Apple has updated their JSON, set this value to 0. Not recommended due to aforementioned reason in https://github.com/ArtSabintsev/Siren#words-of-caution.
//        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 3
//
//        // Replace .immediately with .daily or .weekly to specify a maximum daily or weekly frequency for version checks.
//        // DO NOT CALL THIS METHOD IN didFinishLaunchingWithOptions IF YOU ALSO PLAN TO CALL IT IN applicationDidBecomeActive.
//        siren.checkVersion(checkType: .daily)
    }
    
    func setupOneSignal(_ launchOptions:  [UIApplication.LaunchOptionsKey: Any]?) {
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: WSConstant.OneSignalKey,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
    func setupAppAppearance() {
        let barButtonAppearance = UIBarButtonItem.appearance()
        var fontAttribute = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.init(name: WSConstant.AppCustomFontBold, size: 14) ?? UIFont.systemFont(ofSize: 14)]
        var fontDisabledAttribute = [NSAttributedString.Key.foregroundColor : UIColor.init(white: 1, alpha: 0.5), NSAttributedString.Key.font : UIFont.init(name: WSConstant.AppCustomFontBold, size: 14) ?? UIFont.systemFont(ofSize: 14)]
        barButtonAppearance.setTitleTextAttributes(fontAttribute, for: .normal)
        barButtonAppearance.setTitleTextAttributes(fontAttribute, for: .highlighted)
        barButtonAppearance.setTitleTextAttributes(fontDisabledAttribute, for: .disabled)
        barButtonAppearance.setTitleTextAttributes(fontAttribute, for: .focused)

        let appearance = UINavigationBar.appearance()
        appearance.backgroundColor = UIColor.white
        
        appearance.barTintColor = UIColor.themeColor()
        appearance.tintColor = UIColor.white
        appearance.backIndicatorImage = UIImage.init(named: ".png")
        appearance.titleTextAttributes = fontAttribute
        
        fontAttribute = [NSAttributedString.Key.font : UIFont.init(name: WSConstant.AppCustomFontRegular, size: 12) ?? UIFont.systemFont(ofSize: 12)]
        UISegmentedControl.appearance().setTitleTextAttributes(fontAttribute, for: .normal)
    }

//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.hexString()
//        print("Device APNS Token: " + deviceTokenString)
//        Defaults[.deviceToken] = deviceTokenString
//        Messaging.messaging().apnsToken = deviceToken as Data
//    }

}

//extension AppDelegate : MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        print("Firebase registration token: \(fcmToken)")
//
//        // TODO: If necessary send token to application server.
//        // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
//}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
    
    func setupRemoteNotifications(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
}
