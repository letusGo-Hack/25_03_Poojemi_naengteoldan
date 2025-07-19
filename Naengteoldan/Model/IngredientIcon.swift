//
//  IngredientEmoji.swift
//  Naengteoldan
//
//  Created by COMI on 7/19/25.
//

enum IngredientIcon: String, CaseIterable {
  // 채소
  case carrot = "🥕"
  case potato = "🥔"
  case corn = "🌽"
  case redPepper = "🌶️"
  case cucumber = "🥒"
  case lettuce = "🥬"
  case broccoli = "🥦"
  case mushroom = "🍄"
  case garlic = "🧄"
  case onion = "🧅"
  case peanut = "🥜"
  case chestnut = "🌰"
  case eggplant = "🍆"
  case sweetPotato = "🍠"

  // 해산물
  case fish = "🐟"
  case squid = "🦑"
  case lobster = "🦞"
  case shrimp = "🦐"
  case clam = "🐚"
  case crab = "🦀"
  case octopus = "🐙"
  case shrimpTempura = "🍤"

  // 주요 재료
  case egg = "🥚"
  case milk = "🥛"
  case butter = "🧈"
  case cheese = "🧀"
  case salt = "🧂"
  case honey = "🍯"
  case bread = "🍞"
  case meat = "🥩"
  case poultry = "🍗"
  case bacon = "🥓"
  case sausage = "🌭"

  // 곡물 / 탄수화물
  case rice = "🍚"
  case pasta = "🍝"
  case flour = "🌾"
  case popcorn = "🍿"

  // 과일
  case apple = "🍎"
  case banana = "🍌"
  case grape = "🍇"
  case lemon = "🍋"
  case strawberry = "🍓"
  case watermelon = "🍉"

  // 조미료 / 기타
  case soySauce = "🫙"
  case ketchup = "🍅"

  /// 재료 이름
  var name: String {
    switch self {
    case .carrot: return "당근"
    case .potato: return "감자"
    case .corn: return "옥수수"
    case .redPepper: return "고추"
    case .cucumber: return "오이"
    case .lettuce: return "양상추"
    case .broccoli: return "브로콜리"
    case .mushroom: return "버섯"
    case .garlic: return "마늘"
    case .onion: return "양파"
    case .peanut: return "땅콩"
    case .chestnut: return "밤"
    case .eggplant: return "가지"
    case .sweetPotato: return "고구마"

    case .fish: return "생선"
    case .squid: return "오징어"
    case .lobster: return "바닷가재"
    case .shrimp: return "새우"
    case .clam: return "조개"
    case .crab: return "게"
    case .octopus: return "문어"
    case .shrimpTempura: return "튀김 새우"

    case .egg: return "달걀"
    case .milk: return "우유"
    case .butter: return "버터"
    case .cheese: return "치즈"
    case .salt: return "소금"
    case .honey: return "꿀"
    case .bread: return "빵"
    case .meat: return "고기"
    case .poultry: return "닭고기"
    case .bacon: return "베이컨"
    case .sausage: return "소시지"

    case .rice: return "밥"
    case .pasta: return "파스타 면"
    case .flour: return "밀가루"
    case .popcorn: return "팝콘"

    case .apple: return "사과"
    case .banana: return "바나나"
    case .grape: return "포도"
    case .lemon: return "레몬"
    case .strawberry: return "딸기"
    case .watermelon: return "수박"

    case .soySauce: return "간장"
    case .ketchup: return "케첩"
    }
  }
}
