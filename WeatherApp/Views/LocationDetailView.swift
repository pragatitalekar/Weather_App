import SwiftUI
import CoreData

struct LocationDetailView: View {

    @ObservedObject var location: Location
    @StateObject private var viewModel: DetailViewModel

    init(location: Location) {
        self.location = location

        let networkService = HttpNetworking()
        let weatherService = WeatherService(networkService: networkService)

        _viewModel = StateObject(wrappedValue: DetailViewModel(weatherService: weatherService))
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()

            VStack(spacing: 24) {

                Text(location.name ?? "Unknown Location")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Image(systemName: "cloud.sun.fill")
                    .font(.system(size: 120))
                    .foregroundColor(.yellow)

                VStack(spacing: 25) {
                    HStack(spacing: 25) {
                        WeatherInfoCard(
                            title: "TEMP",
                            value: viewModel.temperature.map { "\(Int($0))°" } ?? "--"
                        )

                        WeatherInfoCard(
                            title: "WIND",
                            value: viewModel.windSpeed.map { "\(Int($0)) km/h" } ?? "--"
                        )
                    }

                    HStack(spacing: 16) {
                        WeatherInfoCard(
                            title: "PRESSURE",
                            value: viewModel.surfacePressure.map { "\(Int($0)) hPa" } ?? "--"
                        )

                        WeatherInfoCard(
                            title: "RAIN",
                            value: viewModel.precipitation.map { String(format: "%.1f mm", $0) } ?? "--"
                        )
                    }
                }

                Spacer()
            }
            .padding()
        }
        .task {
            await viewModel.fetchWeather(for: location)
        }
    }
}
