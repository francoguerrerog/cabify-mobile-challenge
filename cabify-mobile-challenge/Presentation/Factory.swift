import Foundation

struct Factory {
    
    private static let cartRepository = InMemoryCartRepository()
    private static let productsService = ApiProductsService()
    private static let productsRepository = UserDefaultsProductsRepository()
    
    public static func createCartActionDefault() -> CreateCartDefault {
        return CreateCartDefault(cartRepository)
    }
    
    public static func createFindProductsDefault() -> FindProductsDefault {
        return FindProductsDefault(productsService, productsRepository)
    }
    
    public static func createAddProductToCartDefault() -> AddProductToCartDefault {
        return AddProductToCartDefault(cartRepository)
    }
    
    public static func createGetCartWithDiscountsDefault() -> GetCartWithDiscountsDefault {
        let voucherCondition = Voucher2_for_1Condition()
        let tshirtCondition = Tshirt3OrMoreCondition()
        let discountService = DiscountsServiceDefault([voucherCondition, tshirtCondition])
        return GetCartWithDiscountsDefault(cartRepository, discountService)
    }
    
    public static func createDeleteProductsFromCartDefault() -> DeleteProductsFromCartDefault {
        return DeleteProductsFromCartDefault(cartRepository)
    }
    
    public static func createCheckout() -> CheckoutDefault {
        return CheckoutDefault(cartRepository)
    }
}
