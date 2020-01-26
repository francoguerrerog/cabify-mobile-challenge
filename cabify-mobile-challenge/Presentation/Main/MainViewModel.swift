import Foundation
import RxSwift

class MainViewModel {
    private let productsService: ProductsService
    
    private let disposeBag = DisposeBag()
    
    init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    func viewDidLoad() {
        productsService.find()
            .subscribe(onSuccess: { (products) in
                print(products)
            }).disposed(by: disposeBag)
    }
}
