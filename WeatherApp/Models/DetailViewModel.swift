import Foundation
import Combine
import CoreData

@MainActor
final class DetailViewModel: ObservableObject {

    @Published var temperature: Double?
    @Published var windSpeed: Double?
    @Published var precipitation: Double?
    @Published var surfacePressure: Double?

    private let weatherService: WeatherService

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }

    func fetchWeather(for location: Location) async {
        // Use cached data if recent
        if let lastUpdated = location.lastUpdated,
           lastUpdated > Date().addingTimeInterval(-3600) {

            temperature = location.temperature
            windSpeed = location.windSpeed
            precipitation = location.precipitation
            surfacePressure = location.surfacePressure
            return
        }

        do {
            let response = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )

            // Update published properties
            temperature = response.current.temperature2M
            windSpeed = response.current.windSpeed10M
            precipitation = response.current.precipitation
            surfacePressure = response.current.surfacePressure

            // Update Core Data
            location.temperature = response.current.temperature2M
            location.windSpeed = response.current.windSpeed10M
            location.precipitation = response.current.precipitation
            location.surfacePressure = response.current.surfacePressure
            location.lastUpdated = Date()

            try location.managedObjectContext?.save()
        } catch {
            print("Weather fetch failed:", error)
        }
    }
}
