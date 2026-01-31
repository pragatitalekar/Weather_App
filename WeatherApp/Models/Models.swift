import Foundation

enum Weather {
    case sunny
    case foggy
    case snow
    case rainy
    case windy

    var icon: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .foggy:
            return "cloud.fog.fill"
        case .snow:
            return "snowflake"
        case .rainy:
            return "cloud.rain.fill"
        case .windy:
            return "wind"
        }
    }
}

struct Temperature {
    let min: Int
    let max: Int

    var temperatureText: String {
        "\(min) °C / \(max) °C"
    }
}

//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let latitude: Double
//    let longitude: Double
//    let weather: Weather
//    let temperature: Temperature
//}
