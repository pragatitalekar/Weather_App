import Foundation



struct WeatherEndpoint: APIEndpoint {

    let request: WeatherRequest

    var baseURL: String { "https://api.open-meteo.com" }
    var path: String { "/v1/forecast" }

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "latitude", value: "\(request.latitude)"),
            URLQueryItem(name: "longitude", value: "\(request.longitude)"),
            URLQueryItem(
                name: "current",
                value: "temperature_2m,wind_speed_10m,precipitation,surface_pressure"
            )
        ]
    }
}


