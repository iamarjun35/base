//
//  Constant.swift

import UIKit

//public let baseURL = "http://codobux.com/spacea/api/"
public let baseURL = "http://codobux.in/Indenn/public/api/"

public let imgbaseURL = "http://www.codobux.com/planup-web/"

public struct API {
    public static let getVehicleMake         =      baseURL+"getVehicleMake"
    public static let getVehicleModelByMakeId         =      baseURL+"getVehicleModelByMakeId"
    public static let signup         =      baseURL+"register-user/details"
}

/*********************************  Structures  ********************************/

public struct AppFont {
    public static let helventicaNeue     =     "HelveticaNeue"
    public static let museoSansRegular   =     "MuseoSans-100"
    public static let museoSansBold      =     "MuseoSans-500"
    
}
public struct AppColor {
    
}

public struct AppTitle {
    public static var forgotPassword   =    "Password Recovery"
}

public struct AppKey {
    public static let status                          = "status"
    public static let statusCode                      = "statusCode"
    public static let code                            = "code"
    public static let message                         = "message"
    public static let userdata                        = "userData"
    public static let data                            = "data"
    public static let accessToken                     = "token"
    public static let main                            = "Main"
    public static let auth                            = "auth"
    public static let AuthorizationKey                = "AuthorizationKey"
    public static let name                            = "name"
    public static let device_token                    = "device_token"
    public static let Usertoken = "Usertoken"
    public static let firstName = "firstName"
    public static let lastName = "lastName"
    public static let user_name = "user_name"
    public static let email = "email"
    public static let sex = "sex"
    public static let user_first_name = "user_first_name"
    public static let password = "password"
    public static let user_email = "user_email"
    public static let user_last_name = "user_last_name"
    public static let user_password = "user_password"
    public static let phone_number = "phone_number"
    public static let profile_picture = "profile_picture"
    public static let profile_image = "profile_image"

    //    public static let user_password = "user_password"
    //    public static let user_password = "user_password"
}



/************************************ Constant ***********************************/

let KAppDelegate: AppDelegate         =      UIApplication.shared.delegate as! AppDelegate
public let clientStoryBoard           =      UIStoryboard(name: "Client", bundle: nil)
public let mainStoryBoard             =      UIStoryboard(name: "Main", bundle: nil)
public let AppUserDefaults            =      UserDefaults.standard
public let AppNotificationCenter      =      NotificationCenter.default
public typealias KeyValue             =      [String : Any]
public let KEmptyParams             : [String : String]   = [:]
public let KPasswordMinLength         =       6
public let KDelayTime                 =       2.0
public let KTimeDuration              =       0.3
public let KOffline                   =       "Offline"
public var KSimulatorToken            =      "simulator123456statatic12345device123456token123456"
public let KPhoneMaxLength            =       12
public let KEmailMaxLength            =       100
public let KPasswordMaxLength         =       20

public let KFirstNameLength           =       20
public let KCommentLength             =       300
public var KLoading                   =        "Loading..."
public let KOk                        =        "Ok"
public let KCurrencySymbol                        =        "EGP"
public let KCancel                    =        "Cancel"
public let KYes                    =        "Yes"
public let KBusiness                    =        "business"
public let KGoogleKey                 =       "AIzaSyD5EWSujUianrRe6rykkYU0le3_AllWChY"

//AIzaSyDJZI1dgdJxrm8QDtNV9ZvYXXJf09arDDs
public let KTwitterConsumerKey              =       "hAWuW3gJF6k558zWXZAsJpOT7"
public let KTwitterSecretKey           =       "MGqa9kEdAE2XRsBRUkjpKWZUbfs9Ef3T5loFMS2p05hKapDopn"
public let kDefaultImage                   = #imageLiteral(resourceName: "background10")
public let kDefaultAdsImage                   = UIImage(named: "aerial-view-beach-beautiful-cliff-462162")!


/*********************************************************************************/



/************************************ Message ***********************************/
//Commom Messages
public let KAlertTitle                   =      "Plan Up"
public let KServerError                  =      "An error occurred, Please try again."
public let KInternetConnection           =      "Internet connection is not available."
public let kSessionExpired               =       "Session expired. Please login again"
public let KMinimumPassword              =       "Password length should be minimum \(KPasswordMinLength) characters."
public let KPasswordNotMatch             =       "Password and confirm password does not match."
public let KCheckCameraPermission        =       "You need to provide permission to access camera from settings."
public let KCheckGalleryPermission       =       "You need to provide permission to access gallery from settings."

//Message for Particular Application
public let KFirstNameTitle                  =      "Please enter first name"
public let KLastNameTitle                   =      "Please enter last name"
public let KLocationTitle                   =      "Please select location"
public let KPhoneNumberTitle                =      "Please enter phone"
public let KEmailTitle                      =      "Please enter email"
public let kValidEmailTitle                 =      "Please enter valid email"
public let KPasswordTitle                   =      "Please enter password"
public let KConPasswordTitle                =      "Please enter confirm password"
public let KNotMatchTitle                   =      "Password and confirm password not match"
public let kGenderTitle                     =      "Please select gender"
public let kUnKnownError                    =      "Something went wrong"
public let KTitle                           =      "Please enter title"
public let KDate                            =      "Please enter date and time"
public let KDressTitle                      =      "Please enter dress code"
public let KAddressTitle                    =      "Please enter address"
public let KDescriptionTitle                =      "Please enter description"
public let KErrorTitle                =      "Some error occurred"
public let KCurrentPasswordTitle                =      "Please error occurred"
public let KNewPasswordTitle                =      "Please error occurred"
public let KPasswordChangedTitle                  =      "Password updated successfully!"
public let KCheckLocationTitle                =      "Please check location services"

/************************************ NSNotification ***********************************/

extension NSNotification.Name{
    public static let callCheckNotification = Notification.Name("callCheckNotification")
    public static let callCheckPaymentStatus = Notification.Name("callCheckPaymentStatus")
    public static let callCheckHeight = Notification.Name("callCheckHeight")
}
