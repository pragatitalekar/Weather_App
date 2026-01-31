import SwiftUI
import CoreData

struct LocationListView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default
    )
    private var locations: FetchedResults<Location>

    @State private var searchText = ""

    // Filtered locations based on search
    private var filteredLocations: [Location] {
        if searchText.isEmpty {
            return Array(locations)
        } else {
            return locations.filter {
                $0.name?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredLocations) { location in
                        NavigationLink {
                            LocationDetailView(location: location)
                        } label: {
                            LocationRowView(location: location)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.black).ignoresSafeArea())
            .navigationTitle("Locations")
            .toolbar {
                NavigationLink("Add") {
                    AddLocationView()
                        .environment(\.managedObjectContext, viewContext)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
