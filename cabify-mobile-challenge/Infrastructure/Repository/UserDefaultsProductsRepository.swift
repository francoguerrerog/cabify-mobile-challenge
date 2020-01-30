import Foundation
import RxSwift

class UserDefaultsProductsRepository: ProductsRepository {
    
    private let productsKey = "KEY_PRODUCTS"
    private let defaults = UserDefaults.standard
    
    func put(_ products: Products) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: productsKey)
        }
    }
    
    func find() -> Single<Products> {
        if let savedProducts = defaults.object(forKey: productsKey) as? Data {
            let decoder = JSONDecoder()
            if let products = try? decoder.decode(Products.self, from: savedProducts) {
                return .just(products)
            }
        }
        
        return .error(DomainError.ProductsNotFound)
    }
}
