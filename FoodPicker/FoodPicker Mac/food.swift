import Foundation

struct Food: Equatable, Identifiable, Codable {
    let id: UUID
    var name: String
    var image: String

    // 初始化器
    init(name: String, image: String) {
        self.id = UUID() // 自動生成新的 UUID
        self.name = name
        self.image = image
    }

    static let examples = [
        Food(name: "漢堡", image: "🍔"),
        Food(name: "沙拉", image: "🥗"),
        Food(name: "披薩", image: "🍕"),
        Food(name: "義大利麵", image: "🍝"),
        Food(name: "雞腿便當", image: "🍗🍱"),
        Food(name: "刀削麵", image: "🍜"),
        Food(name: "火鍋", image: "🍲"),
        Food(name: "牛肉麵", image: "🐄🍜"),
        Food(name: "關東煮", image: "🍢"),
        Food(name: "壽司", image: "🍣")
    ]
}
