import Foundation
import UIKit

protocol Coordinator {
}

class CoordinatorDefault {
    private let window: UIWindow

    private var viewNavigation: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = createMainViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewNavigation = navigationController
    }
    
    private func createMainViewController() -> MainViewController {
        let viewModel = MainViewModel()
        return MainViewController(viewModel: viewModel)
    }
    
    private func pushViewController(viewController: UIViewController) {
        guard let navigation = viewNavigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
