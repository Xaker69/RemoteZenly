import Foundation

struct RegistrationModel: Codable {
    let type: RegistrationType
    var token: String?
    var nickname: String?
    var firstName: String?
    var secondName: String?
}

enum RegistrationType: String, Codable {
    case fb
    case vk
    case phone
}
