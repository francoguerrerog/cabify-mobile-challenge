import Foundation
import RxSwift

protocol FindProducts {
    func execute() -> Single<Products>
}

class FindProductsDefault: FindProducts {
    private let productsService: ProductsService
    private let productsRepository: ProductsRepository
    
    init(_ productsService: ProductsService, _ productsRepository: ProductsRepository) {
        self.productsService = productsService
        self.productsRepository = productsRepository
    }
    
    func execute() -> Single<Products> {
        return productsService.find()
            .catchError({ (error) -> PrimitiveSequence<SingleTrait, Products> in
                return self.productsRepository.find()
            })
            .flatMap{ self.saveProducts($0) }
    }
    
    private func saveProducts(_ products: Products) -> Single<Products> {
        productsRepository.put(products)
        return .just(products)
    }
}
