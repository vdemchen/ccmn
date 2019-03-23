
import UIKit

class BaseTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        selectionStyle = UITableViewCellSelectionStyle.none
        clipsToBounds = true
    }

    class func nib() -> UINib {
        return UINib(nibName: className(), bundle: Bundle.main)
    }

    class func identifier() -> String {
        return className()
    }

    class func height() -> CGFloat {
        return 0.0
    }
}
