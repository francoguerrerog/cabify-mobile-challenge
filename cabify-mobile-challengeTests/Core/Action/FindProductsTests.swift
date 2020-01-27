import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

@testable import cabify_mobile_challenge

class FindProductsTests: XCTestCase {
    
    private let allProducts = CartFactoryTests.createProducts()
    private let productsRepository = ProductsRepositoryMock()
    private let productsService = ProductsServiceMock()
    private var findProducts: FindProductsDefault!
    private var products: MaterializedSequenceResult<Products>!
    
    func test_findProducts() {
        givenAnAction()
        
        whenExecute()
        
        thenFindService()
    }
    
    func test_saveProductsReposity() {
        givenAnAction()
        
        whenExecute()
        
        thenSaveProducts()
    }
    
    func test_findInRepoWhenNoServiceFailed() {
        givenAnAction()
        Given(productsService, .find(willReturn: .error(ApiError.urlError)))
        Given(productsRepository, .find(willReturn: .just(allProducts)))
        
        whenExecute()
        
        thenFindInRepo()
    }
    
    private func givenAnAction() {
        Given(productsService, .find(willReturn: .just(allProducts)))
        findProducts = FindProductsDefault(productsService, productsRepository)
    }
    
    private func whenExecute() {
        products = findProducts.execute().toBlocking().materialize()
    }
    
    private func thenFindService() {
        Verify(productsService, .once, .find())
    }
    
    private func thenSaveProducts() {
        Verify(productsRepository, .once, .put(.any))
    }
    
    private func thenFindInRepo() {
        Verify(productsRepository, .once, .find())
    }
}
