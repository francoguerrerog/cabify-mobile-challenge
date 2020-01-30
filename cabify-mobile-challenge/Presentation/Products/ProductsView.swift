import UIKit

class ProductsView: UIView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var continueButton: UIButton!
    
    static func initFromNib(owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> Self {
        
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        return nib.instantiate(withOwner: owner, options: options).first as! Self
    }
}
