import UIKit

extension UIColor {
    @available(*, deprecated, message: "Цвет брать из DzingColors")
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    @available(*, deprecated, message: "Цвет брать из DzingColors")
    convenience init(red: Int, green: Int, blue: Int, alphaD:CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaD)
    }
    @available(*, deprecated, message: "Цвет брать из DzingColors")
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    @available(*, deprecated, message: "Цвет брать из DzingColors")
    struct dzingColor {
        
        //NEW
        static let yellowOrangeColor = UIColor(netHex: 0xffb600)
        static let concreteColor = UIColor(netHex: 0xf2f2f2)
        static let scorpionColor = UIColor(netHex: 0x5c5c5c)
        
        static let butterScotchColor = UIColor(netHex: 0xffc836)
        static let pumpkinColor = UIColor(netHex: 0xf06c00)
        
        static let pinkColor = UIColor(netHex: 0xb33fb6)
        static let purplyColor = UIColor(netHex: 0x4e109d)
        
        static let paleLavenderColor = UIColor(netHex: 0xe7dff1)
                
        static let darkIndigo = UIColor(netHex: 0x281459)
        static let indigoBlue = UIColor(netHex: 0x4e109d)

        static let coolGrey = UIColor(netHex: 0x9da2a7)
        static let dodgerBlue = UIColor(netHex: 0x3ea3ff)
        
        static let whiteSeparator = UIColor(red: 249, green: 249, blue: 249)
        
        static let quitScreenEndGr = UIColor(red: 40, green: 20, blue: 89)
        static let quitScreenStartGr = UIColor(red: 78, green: 16, blue: 157)
        
        static let quitConfirmButtonStartGr = UIColor(red: 179, green: 63, blue: 182)
        static let quitConfirmButtonEndGr = UIColor(red: 78, green: 16, blue: 157)
        
        static let quitConfirmButtonColore = UIColor(red: 179, green: 63, blue: 182)
        
        //OLD
        static let purplyTranslucent = UIColor(red: 113, green: 63, blue: 160, alphaD: 0.5)
        static let purplyLight = UIColor(red: 113, green: 63, blue: 160)
        static let purplyDark = UIColor(red: 62, green: 49, blue: 136)
        static let purply = UIColor(red: 83, green: 54, blue: 146)

        static let orangeDark = UIColor(red: 255, green: 130, blue: 9)
        static let orangeLight = UIColor(red: 254, green: 199, blue: 55)
        
        static let redDark = UIColor(red: 246, green: 87, blue: 52)
        static let redLight = UIColor(red: 255, green: 121, blue: 91)
        static let redTranslucent = UIColor(red: 246, green: 87, blue: 52, alphaD: 0.5)
        
        static let grayLight = UIColor(red: 215, green: 221, blue: 225)
        static let grayLight2 = UIColor(red: 215, green: 215, blue: 215)
        static let grayDark = UIColor(red: 194, green: 194, blue: 194)
        
        static let gray = UIColor(red: 99, green: 99, blue: 99)
        static let black = UIColor(red: 23, green: 31, blue: 36)
        
        static let blueDark = UIColor(red: 0, green: 114, blue: 188)
        static let blueLight = UIColor(red: 25, green: 219, blue: 216)
    }
}
