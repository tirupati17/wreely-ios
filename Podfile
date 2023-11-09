platform :ios, :deployment_target => "9.1"
use_frameworks!

def pods
    
    #pod 'UserExperior', :http => 'https://userexperior-35559.firebaseapp.com/download/ios_sdk/1.0.0/UserExperior.zip'
    pod 'UserExperior', '4.0.6'
    #analytics
    pod 'Fabric'
    pod 'Answers'
    pod 'Mixpanel-swift'
    
    #database
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    #pod 'Firebase/Messaging'
    
    pod 'Firebase/Storage'
    pod 'Firebase/Firestore'

    #notification
    pod 'OneSignal', '>= 2.6.2', '< 3.0'

    #network
    pod 'Alamofire', '~> 4.7.3'
    
    #imageview
    pod 'Kingfisher'
    pod 'Letters'

    #datepicker
    pod 'ScrollableDatepicker', :git => 'https://github.com/iamjason/ScrollableDatepicker', :branch => 'swift-4'

    #parser
    pod 'SwiftyJSON'
    
    #logger
    pod 'Log' #colorfull log based on type
    
    #alert
    pod 'SCLAlertView'
    pod 'Toast-Swift', '~> 4.0.0'

    #indicator
    pod 'NVActivityIndicatorView'
    
    #list-placeholder
    #pod 'ListPlaceholder' #not in use
    #pod 'SkeletonView' #not in use

    #rx
    #pod 'RxSwift',    '~> 4.0'

    #model
    pod 'ObjectMapper', '~> 3.1'
    
    #animation
    pod 'ParallaxHeader', '~> 2.0.0'
    
    #location
    pod 'SwiftLocation', '~> 3.2.3'
    pod 'LocationPickerViewController'

    #map
    #pod 'GoogleMaps' #not in use

    #reachability
    pod 'ReachabilitySwift' #in future may be
    
    #userdefault
    pod 'SwiftyUserDefaults'

    #sidemenu
    pod 'InteractiveSideMenu'

    #icons
    pod 'FontAwesome.swift'

    #popup
    pod 'PopupDialog', '~> 0.7'
    
    #weview
    #pod 'SwiftWebVC' #Outdated not available for swift 4.2 Removed it

    #app-update-notify
    #pod 'Siren'

    #datetools
    pod 'DateToolsSwift'

    #autolayout
    #pod 'SnapKit', '~> 4.0.0'
    
    #utilities
    #pod 'SwiftLint' #not in use
    #pod 'LBTAComponents' #not in use
    pod 'OnlyPictures'
    pod 'Lightbox'
    pod 'YPImagePicker' # https://github.com/Yummypets/YPImagePicker
    pod 'KMPlaceholderTextView', '~> 1.4.0'
    pod 'Cloudinary', '~> 2.0'
    #pod 'MessageKit' #not in use
    pod 'GrowingTextView', '~> 0.5'
    #pod 'NotificationBannerSwift'

    #design
    pod 'Material', :git => 'https://github.com/CosmicMind/Material.git', :branch => 'development'
    pod 'Motion', :git => 'https://github.com/CosmicMind/Motion.git', :branch => 'development'
end

target 'WreelySocial' do
    pods
end

target 'WreelySocialTests' do
#    pod 'Quick'
#    pod 'Nimble'
#    pod 'RxBlocking', '~> 4.0'
#    pod 'RxTest',     '~> 4.0'
end

post_install do |installer|
    swift4_0_targets = ["ParallaxHeader", "InteractiveSideMenu", "Letters", "OnlyPictures", "SCLAlertView"]

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if swift4_0_targets.include? target.name
                config.build_settings['SWIFT_VERSION'] = '4.0'
            else
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
    end
end
