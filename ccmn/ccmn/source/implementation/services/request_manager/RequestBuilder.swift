import Foundation

class RequestBuilder {}

extension RequestBuilder {
    class func getMenuSettings(completion: @escaping MenuHandler) {
        RequestManager.requestWithToken(
            url: MenuPaths.Request.menu.url(),
            parameters: nil,
            requestMethod: .get
        ) { (result) in
            switch result {
            case .success(let data):
                do {
                    let result: MenuModel = try JSONDecoder().decode(MenuModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}


//MARK: - Regist

extension RequestBuilder {
    class func registClient(
        completion: @escaping ClientHandler
        ) {
        
        let params = TempDataManager.shared.userDetailModel.getUploadParams()
        let imageData = TempDataManager.shared.userDetailModel.getUploadImage()
        
        RequestManager.requestWithTokenForForMultipart(
            url: ClientPaths.Request.empty.url(),
            parameters: params,
            requestMethod: .post,
            uploadData: imageData) { (result) in
                switch result {
                case .success(let data):
                    do {
                        let result: AccountsModel = try JSONDecoder().decode(AccountsModel.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
    }
    
    class func sendNewPhoneRestoreAccess(
        restoreToken: String,
        _ newPhone: String,
        completion: @escaping RestoreAccessStep4Handler
        ) {
        
        RequestBuilder.validatePhone(
            phone: newPhone
        ) { (result) in
            
            switch result {
            case .success(_):
                TempDataManager.shared.userAuthModel.setNewPhone(newPhone)
                
                RequestBuilder.restoreAccessStep4(
                    restoreToken: restoreToken,
                    newPhone: newPhone,
                    completion: { (result) in
                        switch result {
                        case .success(let model):
                            completion(.success(model))
                        case .error(let error):
                            completion(.error(error))
                        }
                })
                
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func initRegistration(
        phone: String,
        completion: @escaping InitRegistrationHandler
        ) {
        
        TempDataManager.shared.userAuthModel.validation(phone)
        let params = TempDataManager.shared.userAuthModel.paramsForRegistrationPhone()
        
        RequestManager.request(
            url: AuthPaths.Request.initRegistration.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model: InitRegistrationModel = try JSONDecoder().decode(InitRegistrationModel.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }

    class func validatePhone(
        phone: String,
        completion: @escaping ValidatePhoneHandler
        ) {
        
        let params = ["phone" : phone]
        
        RequestManager.request(
            url: AuthPaths.Request.checkPhone.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            //FIXME:  - Метод может работать не корректно, так как в запросе сервер ничего не присылает DATA == 0,
            //могуть быть проблемы из-за RequestManager-a
            //требует тестирования
            switch result {
            case .success(_):
                completion(.success(true))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func restoreAccessStep4(
        restoreToken: String,
        newPhone: String,
        completion: @escaping RestoreAccessStep4Handler
        ) {
        
        let parameters = [
            "restoreToken": restoreToken,
            "newPhone": newPhone
        ]
        
        RequestManager.request(
            url: AuthPaths.Request.restoreAccessStep4.url(),
            parameters: parameters,
            requestMethod: .post
        ) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model: RestoreAccessStep4Model = try JSONDecoder().decode(
                        RestoreAccessStep4Model.self,
                        from: data
                    )
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func compliteRegistration(
        completion: @escaping CompleteRegistrationHandler
        ){
        
        let params = TempDataManager.shared.userAuthModel.paramsForCompliteRegistration()
        RequestManager.request(
            url: AuthPaths.Request.completeRegistration.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model: CompleteRegistrationModel = try JSONDecoder().decode(
                        CompleteRegistrationModel.self,
                        from: data
                    )
                    TempDataManager.shared.userAuthModel.setAccessToken(accessToken: model.accessToken)
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func compliteRegistrationExist(
        restore: RestorePasscodeModel,
        completion: @escaping CompleteRegistrationHandler
        ){
        let params = TempDataManager.shared.userAuthModel.parapmsForComleteRegistrationExist(restore)
        
        RequestManager.request(
            url: AuthPaths.Request.completeRegistration.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model: CompleteRegistrationModel = try JSONDecoder().decode(
                        CompleteRegistrationModel.self,
                        from: data
                    )
                    TempDataManager.shared.userAuthModel.setAccessToken(accessToken: model.accessToken)
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func completeRestorePasscode(
        userQuestion: RestorePasscodeModel,
        completion: @escaping CompleteForgotPasscodeHandler
        ) {
        
        let userAuthModel = TempDataManager.shared.userAuthModel
        
        let params = userQuestion.generateParameters(
            deviceModel: userAuthModel.deviceModel,
            deviceOS: userAuthModel.deviceOs
        )
        
        RequestManager.request(
            url: AuthPaths.Request.completeForgotPasscode.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let model: CompleteForgotPasscodeModel = try JSONDecoder().decode(
                        CompleteForgotPasscodeModel.self,
                        from: data
                    )
                    TempDataManager.shared.userAuthModel.setAccessToken(accessToken: model.accessToken)
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func initRestoreAccess(
        phone: String,
        completion: @escaping InitRestoreAccessModelHandler
        ) {
        
        let params = TempDataManager.shared.userAuthModel.paramsForRestore1(phone)
        
        RequestManager.request(
            url: AuthPaths.Request.initRestoreAccess.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let model: InitRestoreAccessModel = try JSONDecoder().decode(
                        InitRestoreAccessModel.self,
                        from: data
                    )
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}


//MARK: - AUTH

extension RequestBuilder {
    
    class func login(
        passCode: String,
        completion: @escaping LoginHandler
        ){
        let params = TempDataManager.shared.userAuthModel.paramsForLogin(passCode)
        RequestManager.request(
            url: AuthPaths.Request.login.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model: LoginModel = try JSONDecoder().decode(LoginModel.self, from: data)
                    RequestUtilities.refreshTokens(model)
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func loginTouchFaceId(
        completion: @escaping LoginHandler
        ) {
        let params = TempDataManager.shared.userAuthModel.paramsForLogin(ModelsKeys.biometric)
        RequestManager.request(
            url: AuthPaths.Request.login.url(),
            parameters: params,
            requestMethod: .post) { (result) in
                switch result {
                case .success(let data):
                    do {
                        let model: LoginModel = try JSONDecoder().decode(LoginModel.self, from: data)
                        RequestUtilities.refreshTokens(model)
                        completion(.success(model))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
    }
    
    class func completeRestoreAccess(
        restoreToken: String,
        otpId: String,
        _ code: String,
        completion: @escaping CompleteRestoreAccessHandler
        ) {
        
        let params = TempDataManager.shared.userAuthModel.paramsForRestoreTokenAccess(restoreToken,otpId,code)
        RequestManager.request(
            url: AuthPaths.Request.completeRestoreAccess.url(),
            parameters: params,
            requestMethod: .post
        ) { (result) in
            switch result {
                
            case .success(let data):
                do {
                    let model: CompleteRestoreAccessModel = try JSONDecoder().decode(CompleteRestoreAccessModel.self, from: data)
                    TempDataManager.shared.userAuthModel.setAccessToken(accessToken: model.accessToken)
                    completion(.success(model))
                } catch {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    class func resendOtpCode(
        completion: @escaping ResendOtpHandler
        ) {
        let params = TempDataManager.shared.userAuthModel.paramsForResendOtpCode()
        RequestManager.request(
            url: AuthPaths.Request.resendOtp.url(),
            parameters: params,
            requestMethod: .post) { (result) in
                switch result {
                case .success(let data):
                    do {
                        let model: ResendOtpModel = try JSONDecoder().decode(ResendOtpModel.self, from: data)
                        TempDataManager.shared.userAuthModel.appendOtpCode(model: model)
                        completion(.success(model))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
    }
}

// MARK: Account

extension RequestBuilder {
    class func getClientAccounts(completion: @escaping AccountHandler) {
        RequestManager.requestWithToken(
            url: AccountsPaths.Request.empty.url(),
            parameters: nil,
            requestMethod: .get) { (result) in
                switch result {
                case .success(let data):
                    do {
                        let result: AccountsModel = try JSONDecoder().decode(AccountsModel.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
    }
}
