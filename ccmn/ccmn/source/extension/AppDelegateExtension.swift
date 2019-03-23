import Foundation

extension AppDelegate {
    
    @objc func applicationDidTimeout(notification: NSNotification) {
        
        if UserDefaults.standard.bool(forKey: ModelsKeys.keyRegistrationComplete) {
            RouterService.openPinForUserRegist()
        } else {
            RouterService.openFirstScreen()
            LogoutService.logout()
        }
    }
    
    public func checkStateDateForAutoLogout() {
        let lastDate = UserDefaults.standard.object(forKey: ModelsKeys.keyDateForAutoLogout) as? Date
        let curectDate = Date()
        
        if let date = lastDate {
            guard let differenceInSeconds = Calendar.current.dateComponents([.second], from: date, to: curectDate).second else { return }
            if (differenceInSeconds > Int(AuthConfigModel().timeUser()) && !UserDefaults.standard.bool(forKey: ModelsKeys.keyAutoLogoutSent)) {
                NotificationCenter.default.post(name: .appTimeout, object: nil)
            }
            UserDefaults.standard.removeObject(forKey: ModelsKeys.keyAutoLogoutSent)
            UserDefaults.standard.removeObject(forKey: ModelsKeys.keyDateForAutoLogout)
        }
    }
}
