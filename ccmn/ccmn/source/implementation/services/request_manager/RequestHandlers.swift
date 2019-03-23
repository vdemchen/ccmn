import Foundation

enum Result<T> {
    case success(T)
    case error(DzingError?)
}

//MARK: Base

typealias ApiConfigurationHandler = (Result<ApiConfigurationModel>) -> ()

//MARK: Auth handlers

typealias LoginHandler = (Result<LoginModel>) -> ()
typealias ResendOtpHandler = (Result<ResendOtpModel>) -> ()
typealias InitRegistrationHandler = (Result<InitRegistrationModel>) -> ()
typealias ValidatePhoneHandler = (Result<Bool>) -> ()
typealias InitRestoreAccessModelHandler = (Result<InitRestoreAccessModel>) -> ()
typealias CompleteForgotPasscodeHandler = (Result<CompleteForgotPasscodeModel>) -> ()
typealias CompleteRegistrationHandler = (Result<CompleteRegistrationModel>) -> ()
typealias RestoreAccessStep4Handler = (Result<RestoreAccessStep4Model>) -> ()
typealias CompleteRestoreAccessHandler = (Result<CompleteRestoreAccessModel>) -> ()
typealias ForgotPasscodeStep2Handler = (Result<ForgotPasscodeStep2Model>) -> ()
typealias InitForgotPasscodeHandler = (Result<InitForgotPasscodeModel>) -> ()
typealias RestoreAccessStep2Handler = (Result<RestoreAccessStep2Model>) -> ()
typealias RestoreAccessStep3Handler = (Result<RestoreAccessStep3Model>) -> ()
typealias RegistrationStep2Handler = (Result<RegistrationStep2Model>) -> ()
typealias SetAuthTokenModelHandler = (Result<SetAuthTokenModel>) -> ()
typealias SetPushTokenModelHandler = (Result<SetPushTokenModel>) -> ()
typealias BlockDeviceHandler = (Result<BlockDeviceModel>) -> ()

//MARK: Menu handlers

typealias MenuHandler = (Result<MenuModel>) -> ()

//MARK: Acounts handlers

typealias AccountHandler = (Result<GetAccountsModel>) -> ()
typealias AddCurrencyHandler = (Result<NewCurrencyModels>) -> ()
typealias DeactivateCurrencyHandler = (Result<Bool>) -> ()
typealias ActivateCurrencyHandler = (Result<NewCurrencyModels>) -> ()

//MARK: Client handlers

typealias ClientHandler = (Result<GetAccountsModel>) -> ()
typealias ChangeAvatarHandler = (Result<Bool>) -> ()
typealias ProfileDataHandler = (Result<ProfileDataModel>) -> ()
typealias SearchCityAndStreetHandler = (Result<SearchCityAndStreetModel>) -> ()
typealias CheckEmailHandler = (Result<Bool>) -> ()
typealias DeleteUserHandler = (Result<Bool>) -> ()
typealias ChangeLocaleHandler = (Result<Bool>) -> ()
typealias ChangePrivacyHandler = (Result<Bool>) -> ()
typealias ChangeAddressHandler = (Result<Bool>) -> ()
typealias InitConfrirmEmailHandler = (Result<Bool>) -> ()
typealias InitChangeMainEmailHandler = (Result<InitChangeMainEmailModel>) -> ()
typealias CompleChangeMainEmailHandler = (Result<Bool>) -> ()
typealias ChangeNameAndBirthdateHandler = (Result<Bool>) -> ()

typealias InitChangeMainPhoneHandler = (Result<InitChangeMainPhoneModel>) -> ()
typealias ChangeMainPhoneStep2Handler = (Result<ChangeMainPhoneStep2Model>) -> ()
typealias ChangeMainPhoneStep3Handler = (Result<ChangeMainPhoneStep3Model>) -> ()
typealias CompleteChangeMainPhoneHandler = (Result<Bool>) -> ()
typealias ChangeTariffHandler = (Result<ChangeTariffModel>) -> ()
typealias GetTariffsHandler = (Result<GetTariffsModel>) -> ()

//MARK: Config

typealias AuthConfigurateHandler = (Result<AuthConfigurateModel>) -> ()
typealias ClientConfigurationHandler = (Result<ClientConfigurationModel>) -> ()

//MARK: Exchange

typealias AcceptedCurrencyConvertHandler = (Result<AcceptedCurrencyConvertModel>) -> ()
typealias AccountСurrencyHandler = (Result<AccountСurrencyModels>) -> ()
typealias CurrencyRateHandler = (Result<CurrencyRateModel>) -> ()
typealias PDFExchangeHandler = (Result<Data>) -> ()
