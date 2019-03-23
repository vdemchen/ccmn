import Foundation

extension Date {
    
    enum FormatsType: String {
        case questionType = "'YYYY'-'MM'"
        case isoSecondsType = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        case ddMMyyyWithSlashType = "dd / MM / yyyy"
        case exchangeCopletedType = "dd.MM.yyyy   HH:mm"
        case defaultType = "yyyy-MM-dd HH:mm:ss"
    }
    
    func formatToString(formatType: FormatsType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        return dateFormatter.string(from: self)
    }
    
    func isAdult() -> Bool {        
        return self <= Date.adult()
    }
    
    func isOld() -> Bool {
        return self > Date.old()
    }
    
    static func adult() -> Date{
        return dateBefore(year: 18, month: 0, day: 0)
    }
    
    static func old() -> Date {
        return dateAfter(year: 120, month: 0, day: 0)
    }
    
    static func maxDate() -> Date {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        component.year = year
        component.month = 12
        component.day = 31
        
        return calendar.date(from: component) ?? Date()
    }
    
    static func minDate() -> Date {
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        component.year = 1900
        component.month = 1
        component.day = 1
        
        return calendar.date(from: component) ?? Date()
    }
    
   static func dateBefore(year y:Int, month m:Int, day d:Int) -> Date {
       
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date) - y
        let month = calendar.component(.month, from: date) - m
        let day = calendar.component(.day, from: date) - d
        
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        component.year = year
        component.month = month
        component.day = day
        
        return calendar.date(from: component) ?? Date()
    }
    
    static func dateAfter(year y:Int, month m:Int, day d:Int) -> Date {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date) + y
        let month = calendar.component(.month, from: date) + m
        let day = calendar.component(.day, from: date) + d
        
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        component.year = year
        component.month = month
        component.day = day
        
        return calendar.date(from: component) ?? Date()
    }
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970)
    }
    
    func toStringTimestamp() -> String {   
        return String(format: "%lld", toMillis())
    }
    
    func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
}
