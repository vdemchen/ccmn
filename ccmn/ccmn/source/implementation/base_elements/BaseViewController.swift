
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        title = ""

//        updateUi()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

//    func updateUi() {
//        view.backgroundColor = UIColor.white
//
//        var image = Asset.backButton.image
//        image = image.withAlignmentRectInsets(UIEdgeInsetsMake(0, 100, 0, -100))
//
//        navigationController?.navigationBar.backIndicatorImage = image
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
//        navigationItem.leftItemsSupplementBackButton = true
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//
//        navigationController?.navigationBar.activateDzingBar()
//    }
}
