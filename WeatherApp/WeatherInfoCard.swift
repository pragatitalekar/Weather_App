import SwiftUI

struct WeatherInfoCard: View {

    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color.white.opacity(0.12))
        .cornerRadius(14)
    }
}
