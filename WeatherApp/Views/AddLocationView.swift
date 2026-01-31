import SwiftUI
import MapKit

struct AddLocationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629),
        span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
    )

    var body: some View {
        Form {
            Section("Pick Location") {
                Map(coordinateRegion: $region)
                    .frame(height: 250)
                    .onTapGesture {
                        latitude = String(format: "%.4f", region.center.latitude)
                        longitude = String(format: "%.4f", region.center.longitude)
                    }
            }

            Section("Location Details") {
                TextField("City Name", text: $name)
                TextField("Latitude", text: $latitude)
                TextField("Longitude", text: $longitude)
            }

            Button("Save Location") {
                guard
                    !name.isEmpty,
                    let lat = Double(latitude),
                    let lon = Double(longitude)
                else { return }

                PersistenceController.shared.createLocation(
                    name: name,
                    lat: lat,
                    long: lon
                )
                dismiss()
            }
        }
        .navigationTitle("Add Location")
    }
}
