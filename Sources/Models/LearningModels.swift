import Foundation

struct Word: Identifiable, Codable {
    var id: String
    var english: String
    var turkish: String
    var pronunciation: String // IPA or simple phonetic
    var difficulty: Int // 1-3
    var mastered: Bool = false
}

struct WordPack {
    static let beginner: [Word] = [
        Word(id: "w1", english: "Resilience", turkish: "Direnc", pronunciation: "ri-zil-yens", difficulty: 1),
        Word(id: "w2", english: "Vibrant", turkish: "Canli", pronunciation: "vai-brunt", difficulty: 1),
        Word(id: "w3", english: "Achieve", turkish: "Basarmak", pronunciation: "a-chiv", difficulty: 1),
        Word(id: "w4", english: "Determine", turkish: "Belirlemek", pronunciation: "di-ter-min", difficulty: 1),
        Word(id: "w5", english: "Focus", turkish: "Odaklanmak", pronunciation: "fo-kus", difficulty: 1),
        Word(id: "w6", english: "Habit", turkish: "Aliskanlik", pronunciation: "ha-bit", difficulty: 1),
        Word(id: "w7", english: "Health", turkish: "Saglik", pronunciation: "helth", difficulty: 1),
        Word(id: "w8", english: "Improve", turkish: "Gelistirmek", pronunciation: "im-proov", difficulty: 1),
        Word(id: "w9", english: "Journey", turkish: "Yolculuk", pronunciation: "jur-nee", difficulty: 1),
        Word(id: "w10", english: "Knowledge", turkish: "Bilgi", pronunciation: "nol-ij", difficulty: 1)
    ]
    
    static let intermediate: [Word] = [
        Word(id: "i1", english: "Perseverance", turkish: "Azim", pronunciation: "per-si-veer-ens", difficulty: 2),
        Word(id: "i2", english: "Inevitably", turkish: "Kacinilmaz olarak", pronunciation: "in-ev-i-ta-bli", difficulty: 2),
        Word(id: "i3", english: "Sustainable", turkish: "Surdurulebilir", pronunciation: "sus-teyn-a-bul", difficulty: 2),
        Word(id: "i4", english: "Procrastinate", turkish: "Ertelemek", pronunciation: "pro-cras-ti-neyt", difficulty: 2)
    ]
}
