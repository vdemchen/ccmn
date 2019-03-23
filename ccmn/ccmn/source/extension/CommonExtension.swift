
import Foundation
import UIKit

extension Date {
    func requestScreenFormatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d,  EEE"

        let str = dateFormatter.string(from: self)
        return str
    }
}

extension UIColor {
    static let mainAppColor = UIColor(red: 114.0 / 255.0, green: 13.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
    static let mainDarkAppColor = UIColor(red: 78.0 / 255.0, green: 13.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
    static let grayAppColor = UIColor(red: 103.0 / 255.0, green: 103.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
    static let linkTextColor = UIColor(red: 98.0 / 255.0, green: 0.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    static let redAppColor = UIColor(red: 227.0 / 255.0, green: 4.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0)
    static let elementsBorderAppColor = UIColor(red: 168.0 / 255.0, green: 136.0 / 255.0, blue: 160.0 / 255.0, alpha: 1.0)
}

extension UIFont {
    class func semiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-SemiBold", size: size)!
    }

    class func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Bold", size: size)!
    }

    class func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Medium", size: size)!
    }

    class func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Regular", size: size)!
    }

    class func light(size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Light", size: size)!
    }

    class func thin(size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Thin", size: size)!
    }
}

extension UIView {
    func addShadow() {
        layer.cornerRadius = frame.height / 2.0
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.3
    }

    func dropNewShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, maskToBounds: Bool = false) {
        layer.masksToBounds = maskToBounds
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIButton {
    func updateButtonWith(color: UIColor) {
        titleLabel?.font = UIFont.regular(size: 16.0)
        backgroundColor = color
    }
}

extension UITextField {
    func updateTextField() {
        font = UIFont.regular(size: 16.0)
        textColor = UIColor.black.withAlphaComponent(0.75)
    }
}

extension UILabel {
    func updateTopLabel() {
        textColor = UIColor.mainDarkAppColor
        font = UIFont.bold(size: 24.0)
    }
}

extension UIView {
    func addBorderToTextFieldContent() {
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.elementsBorderAppColor.cgColor
        layer.borderWidth = 1.0
    }
}
