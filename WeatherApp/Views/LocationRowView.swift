//
//  LocationRowView.swift
//  BreezeWeather
//
//  Created by rentamac on 1/28/26.
//
import SwiftUI

struct LocationRowView: View {

    let location: Location

    var body: some View {
        HStack(spacing: 16) {
            // Weather Icon
            Image(systemName: weatherIcon(for: location))
                .font(.system(size: 30))
                .foregroundColor(.yellow)

            VStack(alignment: .leading, spacing: 4) {
                Text(location.name ?? "Unknown")
                    .font(.headline)
                    .foregroundColor(.white)

                if let lastUpdated = location.lastUpdated {
                    Text(lastUpdated, style: .time)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("--:--")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            // Temperature
            Text("\(Int(location.temperature ?? 0))°")
                .font(.title2)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.12))
        .cornerRadius(12)
    }

    // Simple mapping: choose an icon based on precipitation/wind/temp
    private func weatherIcon(for location: Location) -> String {
        if location.precipitation > 0 {
            return "cloud.rain.fill"
        }
        return "sun.max.fill"
    }

}

