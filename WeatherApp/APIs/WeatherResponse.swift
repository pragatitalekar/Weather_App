import Foundation

struct WeatherResponse: Decodable {
    let current: CurrentWeather
}

struct CurrentWeather: Decodable {

    let temperature2M: Double
    let windSpeed10M: Double
    let precipitation: Double
    let surfacePressure: Double

    enum CodingKeys: String, CodingKey {
        case temperature2M   = "temperature_2m"
        case windSpeed10M    = "wind_speed_10m"
        case precipitation
        case surfacePressure = "surface_pressure"
    }
}
