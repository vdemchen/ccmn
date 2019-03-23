import Foundation
import Alamofire

public enum ResultRequest {
    case success(Data)
    case error(DzingError?)
}

public typealias JSON = [String : Any]
public typealias Completion = (ResultRequest) -> ()

class RequestManager {
    
    class func
        request(
        url: String,
        parameters: JSON?,
        requestMethod: HTTPMethod,
        completion: @escaping Completion
        ) {
        
        if Connectivity.isConnectedToInternet == false {
            let error = RequestUtilities.getBadConnectionError()
            Alert.showAlertInTopViewController(title: LocString("Error"), message: error.message)
            completion(.error(nil))
            return
        }
        
        Alamofire.request(
            url,
            method: requestMethod,
            parameters: parameters,
            encoding: JSONEncoding.default
            ).responseData { (response) in
                
                guard let statusCode = response.response?.statusCode else { return }
                
                if statusCode == 200{
                    if let data = response.data {
                        RequestUtilities.printData(data)
                        completion(.success(data))
                    } else {
                        completion(.error(RequestUtilities.getDzingEmptyError()))
                    }
                    return
                } else if statusCode >= 400 && statusCode <= 500{
                    if let data = response.result.value {
                        let error = RequestUtilities.parsedErrors(data: data, code: statusCode)
                        completion(.error(error))
                    } else {
                        completion(.error(RequestUtilities.getDzingEmptyError()))
                    }
                }
        }
    }
    
    class func requestWithToken(
        url: String,
        parameters: JSON?,
        requestMethod: HTTPMethod,
        _ encoding: URLEncoding? = nil,
        completion: @escaping Completion
        ) {
        
        guard let token = TempDataManager.shared.userAuthModel.accessToken else {
            completion(.error(RequestUtilities.getEmptyAccessTokenError()))
            return
        }
        
        if Connectivity.isConnectedToInternet == false {
            let error = RequestUtilities.getBadConnectionError()
            Alert.showAlertInTopViewController(title: LocString("Error"), message: error.message)
            completion(.error(nil))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        Alamofire.request(
            url,
            method: requestMethod,
            parameters: parameters,
            encoding: encoding ?? JSONEncoding.default,
            headers: headers
            ).responseData { (response) in
                
                guard let statusCode = response.response?.statusCode else {
                    completion(.error(RequestUtilities.getErrorWithMessageAndCode(404, message: "Server error")))
                    return
                }
                
                if statusCode == 200 {
                    if let data = response.data {
                        RequestUtilities.printData(data)
                        //MARK: - IF DATA = 0 bites we have  Error Domain=NSCocoaErrorDomain Code=3840 "No value." UserInfo={NSDebugDescription=No value.}
                        //need fix it
                        completion(.success(data))
                    } else {
                        completion(.error(RequestUtilities.getDzingEmptyError()))
                    }
                } else if statusCode >= 400 && statusCode <= 500 && statusCode != 401 {
                    if let data = response.result.value {
                        let error = RequestUtilities.parsedErrors(data: data, code: statusCode)
                        completion(.error(error))
                    } else {
                        completion(.error(RequestUtilities.getDzingEmptyError()))
                    }
                } else if statusCode == 401 {
                    self.refreshAccsesToken(completion: { (result) in
                        switch result {
                        case .success(_):
                            RequestManager.requestWithToken(
                                url: url,
                                parameters: parameters,
                                requestMethod: requestMethod,
                                completion: { (result) in
                                    switch result {
                                    case .success(let data):
                                        completion(.success(data))
                                    case .error(let error):
                                        completion(.error(error))
                                    }
                            })
                        case .error(let error):
                            completion(.error(error))
                        }
                    })
                } else {
                    completion(.error(RequestUtilities.getErrorWithMessageAndCode(statusCode, message: "Server error")))
                }
        }
    }
    
    class func requestWithTokenForForMultipart(
        url: String,
        parameters: JSON?,
        requestMethod: HTTPMethod,
        uploadData: Data?,
        completion: @escaping Completion
        ) {
        
        guard let token = TempDataManager.shared.userAuthModel.accessToken else {
            completion(.error(RequestUtilities.getEmptyAccessTokenError()))
            return
        }
        
        if Connectivity.isConnectedToInternet == false {
            let error = RequestUtilities.getBadConnectionError()
            Alert.showAlertInTopViewController(title: LocString("Error"), message: error.message)
            completion(.error(nil))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)","Content-type": "multipart/form-data"]
        
        let urlRequest: URLRequest?
        do {
            let request = try URLRequest(url: url, method: requestMethod, headers: headers)
            urlRequest = request
        } catch {
            completion(.error(RequestUtilities.getBadConnectionError()))
            return
        }
        
        guard let request = urlRequest else {
            completion(.error(RequestUtilities.getDzingEmptyError()))
            return
        }
        
        Alamofire.upload(
            multipartFormData: { (multipart) in
                
                //FIXME: - Исправить установку параметров
                
                if let param = parameters {
                    for (key, value) in param {
                        multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                }
                
                if let data = uploadData {
                    multipart.append(data, withName: "avatarImage", fileName: "avatarImage.png", mimeType: "image/png")
                }
        },
            with: request,
            encodingCompletion: { (encodingResult) in
                
                switch encodingResult {
                    
                case .success(let request, _, _):
                    request.responseData(completionHandler: { (dataResponce) in
                        guard let data = dataResponce.data else {
                            completion(.error(RequestUtilities.getDzingEmptyError()))
                            return
                        }
                        RequestUtilities.printData(data)
                        completion(.success(data))
                    })
                case .failure(let error):
                    completion(.error(RequestUtilities.getErrorWithMessageAndCode(-3, message: error.localizedDescription)))
                }
        })
    }
    
    class private func refreshAccsesToken(completion: @escaping LoginHandler) {
        
        let userAuth = TempDataManager.shared.userAuthModel
        let userDetailModel = TempDataManager.shared.userDetailModel
        
        guard let refreshToken = userAuth.refreshToken,
            let phone = userDetailModel.phone,
            let deviceId = userAuth.deviceId,
            let appId = userAuth.appId else{
                completion(.error(RequestUtilities.getErrorWithMessageAndCode(-4, message: "Empty data user")))
                return
        }
        
        let params = TempDataManager.shared.userAuthModel.paramsForRefreshToken(
            refreshToken,
            phone,
            deviceId,
            appId
        )
        
        RequestManager.request(
            url: AuthPaths.Request.refresh.url(),
            parameters: params,
            requestMethod: .post) { (result) in
                
                switch result {
                case .success(let data):
                    do {
                        let model: LoginModel = try JSONDecoder().decode(LoginModel.self, from: data)
                        RequestUtilities.refreshTokens(model)
                    } catch {
                        completion(.error(RequestUtilities.getBadConnectionError()))
                    }
                case .error(let error):
                    completion(.error(error))
                }  
        }
    }
}
