import Foundation
import UIKit
import RxSwift

protocol Coordinator {
    func goToProducts()
    func goToCart()
    func goToRoot()
}

class CoordinatorDefault {
    private let window: UIWindow

    private var viewNavigation: UINavigationController?
    
    private let cart = Cart()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = createProductsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewNavigation = navigationController
        
        createCart()
    }
    
    private func createCart() {
        let createCartAction = Factory.createCartActionDefault()
        createCartAction.execute(cart)
    }
    
    private func createCartViewController() -> CartViewController {
        let getCartWithDiscounts = Factory.createGetCartWithDiscountsDefault()
        let deleteProductsFromCart = Factory.createDeleteProductsFromCartDefault()
        let checkOut = Factory.createCheckout()
        let viewModel = CartViewModel(self, getCartWithDiscounts, deleteProductsFromCart, checkOut)
        return CartViewController(viewModel: viewModel)
    }
    
    private func createProductsViewController() -> ProductsViewController {
        let findProducts = Factory.createFindProductsDefault()
        let addProductToCart = Factory.createAddProductToCartDefault()
        let viewModel = ProductsViewModel(self, findProducts, addProductToCart)
        return ProductsViewController(viewModel: viewModel)
    }
    
    private func pushViewController(viewController: UIViewController) {
        guard let navigation = viewNavigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}

extension CoordinatorDefault: Coordinator {
    func goToProducts() {
        let viewController = createProductsViewController()
        pushViewController(viewController: viewController)
    }
    
    func goToCart() {
        let viewController = createCartViewController()
        pushViewController(viewController: viewController)
    }
    
    func goToRoot() {
        guard let navigation = viewNavigation else { return }
        navigation.popToRootViewController(animated: true)
    }
}
