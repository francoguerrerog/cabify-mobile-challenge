import Foundation

struct Price: Codable {
    let amount: Double
    let currency: Currency

    enum Currency: Codable {

        enum Key: CodingKey {
            case rawValue
        }
        
        enum CodingError: Error {
            case unknownValue
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Key.self)
            let rawValue = try container.decode(Int.self, forKey: .rawValue)
            switch rawValue {
            case 0:
                self = .Euro
            default:
                throw CodingError.unknownValue
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Key.self)
            switch self {
            case .Euro:
                try container.encode(0, forKey: .rawValue)
            }
        }
        
        case Euro
    }
}
