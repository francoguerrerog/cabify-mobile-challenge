import Foundation
import RxSwift

class InMemoryProductsRepository: ProductsRepository {
    private var products: Products?
    
    func put(_ products: Products) {
        self.products = products
    }
    
    func find() -> Single<Products> {
        guard let products = self.products else {
            return .error(DomainError.ProductsNotFound)
        }
        
        return .just(products)
    }
}
