
import Foundation

extension String
{
    var hasOnlyNewlineSymbols: Bool {
        return trimmingCharacters(in: CharacterSet.newlines).isEmpty
    }
    
    var localized: String
    {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func hasChars() -> Bool
    {
        if self.count <= 0
        {
            return false
        }
        else
        {
            let isCorrect = self.isWhiteSpacesOrNewlines()
            
            return isCorrect
        }
    }
    
    func isWhiteSpacesOrNewlines() -> Bool
    {
        let whiteSpaceNewLineCharSet = CharacterSet.whitespacesAndNewlines
        let nonWhiteSpaceNewlineStr = self.components(separatedBy: whiteSpaceNewLineCharSet).joined(separator: "")
        
        return nonWhiteSpaceNewlineStr.count > 0
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    func checkStringWith(regex: String?) -> Bool {
        guard let regex = regex else { return false }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func cutStringToCharacter(_ string: String, character: Character) -> String {
        return string.split(separator: character).first?.uppercased() ?? ""
    }
    
    func getDateFormISO8601() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }
    
}

