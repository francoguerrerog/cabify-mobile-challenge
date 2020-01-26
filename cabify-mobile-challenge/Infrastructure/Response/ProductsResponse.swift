import Foundation

struct ProductsResponse: Codable {
    let products: [ProductResponse]
    
    func toProducts() -> Products {
        return Products(products: products.map{ $0.toProduct() })
    }
}
