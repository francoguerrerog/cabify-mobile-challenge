import XCTest
import SwiftyMocky
import RxSwift
import RxTest

@testable import cabify_mobile_challenge

class ProductsViewModelTests: XCTestCase {
    
    private let findProducts = FindProductsMock()
    private let addProductToCart = AddProductToCartMock()
    private let coordinator = CoordinatorMock()
    private var viewModel: ProductsViewModel!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    private var productsObserver: TestableObserver<[Product]>!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        productsObserver = scheduler.createObserver([Product].self)
    }
    
    func test_findProducts() {
        givenAViewModel()
        
        whenViewDidLoad()
        
        thenFindProducts()
    }
    
    func test_emitProducts() {
        givenAViewModel()
        
        viewModel.output.products.subscribe(productsObserver).disposed(by: disposeBag)
        whenViewDidLoad()
        
        thenEmitProducts()
    }
    
    func test_addProductToCart() {
        givenAnAddProductScenario()
        
        whenSelectProduct()
        
        thenAddProductToCart()
    }
    
    func test_goToCart() {
        givenAViewModel()
        
        viewModel.selectContinueButton()
        
        thenGoToCart()
    }

    private func givenAViewModel() {
        Given(findProducts, .execute(willReturn: .just(CartFactoryTests.createProducts())))
        viewModel = ProductsViewModel(coordinator, findProducts, addProductToCart)
    }
    
    private func givenAnAddProductScenario() {
        Given(addProductToCart, .execute(product: .any, willReturn: .empty()))
        givenAViewModel()
        viewModel.viewDidLoad()
    }
    
    private func whenViewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    private func whenSelectProduct() {
        viewModel.selectProduct(0, 3)
    }
    
    private func thenFindProducts() {
        Verify(findProducts, .once, .execute())
    }
    
    private func thenEmitProducts() {
        let events = productsObserver.events
        XCTAssertEqual(events.count, 2)
    }
    
    private func thenAddProductToCart() {
        Verify(addProductToCart, .once, .execute(product: .any))
    }
    
    private func thenGoToCart() {
        Verify(coordinator, .once, .goToCart())
    }
}
