import UIKit

extension NSObject {
    class func className() -> String {
        return String(describing: self)
    }

    func setKeyboardHandlingEnabled(enabled: Bool) {
        if enabled {
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }

    @objc func handleKeyboard(keyboardNotification: NSNotification) {
        let duration = keyboardNotification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = UIViewAnimationCurve(rawValue: keyboardNotification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! Int)
        let keyboardWillBeShown = keyboardNotification.name == NSNotification.Name.UIKeyboardWillShow
        let keyboardFrame = keyboardNotification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect

        UIView.beginAnimations("KeyboardAnimationID", context: nil)
        UIView.setAnimationCurve(curve!)

        if keyboardWillBeShown {
            UIView.setAnimationDelegate(self)
        } else {
            UIView.setAnimationDelegate(nil)
        }

        UIView.setAnimationDuration(duration)

        keyboardStateChangeWithFrame(frame: keyboardFrame, willBeShown: keyboardWillBeShown)

        UIView.commitAnimations()
    }

    @objc func keyboardStateChangeWithFrame(frame: CGRect, willBeShown: Bool) {
    }

    class func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let targetType = (Bundle.main.bundleIdentifier == ModelsKeys.stagingBundle) ? "staging" : "release"

        let appVersion = String(format: "%@(%@)_%@", (version ?? "unknown_version"),
                                (buildNumber ?? "unknown_build_number"), targetType)

        return appVersion
    }
}

extension NSObject {
    class func isNewAppBuild() -> Bool {
        let previousIdentifier = UserDefaults.standard.string(forKey: ModelsKeys.keyPreviousDeviceIdentifier) ?? ""
        return previousIdentifier != UIDevice.current.identifierForVendor?.uuidString
    }
}
