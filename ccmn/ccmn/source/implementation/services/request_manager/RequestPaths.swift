import Foundation

//MARK: - Domains

public enum BaseURL {
    static let domain = "http://dzing.ftclub.biz"
}

//MARK: - Paths

public class BasePaths {
    class func url() -> String {
        return BaseURL.domain + "/api"
    }
}


public enum AuthPaths {
    
    private static let endpoint = "/api/auth"
    
    enum Request: String {
        
        case login = "/login"
        case refresh = "/refresh"
        case initRegistration = "/init-registration"
        case resendOtp = "/resend-otp"
        case registrationStep2 = "/registration-step2"
        case completeRegistration = "/complete-registration"
        case blockDevice = "/block-device"
        case setAuthToken = "/set-auth-token"
        case setPushToken = "/set-push-token"
        case checkPhone = "/check-phone"
        case initForgotPasscode = "/init-forgot-passcode"
        case forgotPasscodeStep2 = "/forgot-passcode-step2"
        case completeForgotPasscode = "/complete-forgot-passcode"
        case initForgotPasscodeEmail = "/init-forgot-passcode-email"
        case forgotPasscodeEmailStep2 = "/forgot-passcode-email-step2"
        case forgotPasscodeEmailStep3 = "/forgot-passcode-email-step3"
        case forgotPasscodeEmailStep4 = "/forgot-passcode-email-step4"
        case completeForgotPasscodeEmail = "/complete-forgot-passcode-email"
        case initRestoreAccess = "/init-restore-access"
        case restoreAccessStep2 = "/restore-access-step2"
        case restoreAccessStep3 = "/restore-access-step3"
        case restoreAccessStep4 = "/restore-access-step4"
        case completeRestoreAccess = "/complete-restore-access"
        
        func url() -> String {
            return BaseURL.domain + AuthPaths.endpoint + self.rawValue
        }
    }
}

public enum ClientPaths {
    
    private static let endpoint = "/api/client"
    
    enum Request: String {
        
        case empty = ""
        
        case docs = "/docs"
        case changeAddress = "/change-address"
        case initChangeMainEmail = "/init-change-main-email"
        case completeChangeMainEmail = "/complete-change-main-email"
        case changeAvatarImage = "/change-avatar-image"
        case initChangeMainPphone = "/init-change-main-phone"
        case changeMainPhoneStep2 = "/change-main-phone-step2"
        case changeMainPhoneStep3 = "/change-main-phone-step3"
        case completeChangeMainPhone = "/complete-change-main-phone"
        case changeNameAndBirthdate = "/change-name-and-birthdate"
        case changePrivacy = "/change-privacy"
        case changeTariff = "/change-tariff"
        case checkEmail = "/check-email"
        case initConfirmEmail = "/init-confirm-email"
        case avatar = "/avatar"
        case tariffs = "/tariffs"
        case close = "/close"
        case locale = "/locale"
        
        case address = "/address"
        
        func url() -> String {
            return BaseURL.domain + ClientPaths.endpoint + self.rawValue
        }
        
        func searchCityAndStreetUrl(countryCode: String, postalCode: String) -> String {
             return BaseURL.domain + ClientPaths.endpoint + self.rawValue + "/\(countryCode)" + "/\(postalCode)"
        }
        
        func changeLocaleUrl(locale: String) -> String {
            return BaseURL.domain + ClientPaths.endpoint + self.rawValue + "/" + locale
        }
        
    }
}

public enum MenuPaths {
    
    private static let endpoint = "/api"
    
    enum Request: String {
        
        case menu = "/menu"
        
        func url() -> String {
            return BaseURL.domain + MenuPaths.endpoint + self.rawValue
        }
    }
}

public enum AccountsPaths {
    
    private static let endpoint = "/api/accounts"
    
    enum Request: String {
        
        case empty = ""
        case add = "/add"
        case activate = "/activate"
        case deactivate = "/deactivate"
        
        func url() -> String {
            return BaseURL.domain + AccountsPaths.endpoint + self.rawValue
        }
    }
}

public enum ConfigPaths {
    
    private static let endpoint = "/api/config"
    
    enum Request: String {
        
        case auth = "/auth"
        case client = "/client"
        
        func url() -> String {
            return BaseURL.domain + ConfigPaths.endpoint + self.rawValue
        }
    }
}

public enum ExchangePaths {
    
    private static let endpoint = "/api/exchange"
    
    enum Request: String {
        
        case convert = "/convert"
        case currencies = "/currencies"
        case rate = "/rate"
        case statement = "/statement"
        
        func url() -> String {
            return BaseURL.domain + ExchangePaths.endpoint + self.rawValue
        }
    }
}


