import UIKit

extension NSMutableAttributedString {
    func largeFontInString(fullString: String, cutString: String, sizeFont: UIFont) -> (NSMutableAttributedString) {
        let range = (fullString as NSString).range(of: cutString)
        let attributedText = NSMutableAttributedString(string: fullString, attributes: [
            .font: Fonts.GillSans.nova.ofSize(16),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
            ])
        attributedText.addAttribute(.font, value: sizeFont, range: range)
        return attributedText
    }
}
