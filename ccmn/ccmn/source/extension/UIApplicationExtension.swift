
import Foundation
import UIKit

extension UIApplication
{
    var statusBarView: UIView?
    {
        let statusBar = "statusBar"
        
        if responds(to: Selector((statusBar)))
        {
            return value(forKey: statusBar) as? UIView
        }
        
        return nil
    }
    
    class func bottomSafeArea() -> CGFloat {
        if #available(iOS 11.0, *) {
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
            
            return bottomPadding ?? 0.0
        }
        
        return 0.0
    }
}
