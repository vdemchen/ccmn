
import Foundation

extension NSError
{
    static let errorCodeNoUser = 4004
    static let errorCodeNoMeeting = 4005
    static let errorCodeOther = 404
    
    class func error(text: String?, code: Int) -> NSError
    {
        let description = (text != nil) ? text : ""
        
        let nError = NSError.init(domain: "com.meeting.cost.calculator", code: code, userInfo: [ NSLocalizedDescriptionKey : description! ])
        return nError
    }
    
    class func error(error: Error?, code: Int) -> NSError
    {
        let description = (error?.localizedDescription != nil) ? error?.localizedDescription : ""
        
        let nError = NSError.init(domain: "com.meeting.cost.calculator", code: code, userInfo: [ NSLocalizedDescriptionKey : description! ])
        return nError
    }
}
