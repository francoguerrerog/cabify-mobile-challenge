
import UIKit

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    private lazy var mainView = MainView.initFromNib()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
            
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        viewModel.viewDidLoad()
    }

    private func bindViewModel() {

    }
}
