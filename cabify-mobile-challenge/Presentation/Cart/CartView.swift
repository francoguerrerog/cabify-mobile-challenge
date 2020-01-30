import UIKit

class CartView: UIView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkOutButton: UIButton!
    
    static func initFromNib(owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> Self {
        
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        return nib.instantiate(withOwner: owner, options: options).first as! Self
    }
}
