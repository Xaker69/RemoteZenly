import Cocoa

struct RegistrationModel: Codable {
    let type: RegistrationType
    var token: String?
    var nickname: String?
    var firstName: String?
    var secondName: String?
    var avatar: Data?
    var avatarName: String?
}

enum RegistrationType: String, Codable {
    case fb
    case vk
    case phone
}
