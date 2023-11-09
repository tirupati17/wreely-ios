import Foundation
import UIKit

extension UIStoryboard {
    
    enum Storyboard : String {
        case main
        var filename: String {
            return rawValue.capitalized
        }
    }
        
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
//    funcinstantiateViewController(withIdentifier identifier: String) -> UIViewController {
//        return self.instantiateViewController(withIdentifier: identifier)
//    }
}
