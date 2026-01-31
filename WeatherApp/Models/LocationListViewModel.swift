import Foundation
import CoreData
import Combine
@MainActor
final class LocationListViewModel: ObservableObject {

    @Published var locations: [Location] = []

    private let context = PersistenceController.shared.container.viewContext

    init() {
        fetchLocations()
    }

    func fetchLocations() {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Location.name, ascending: true)
        ]

        do {
            locations = try context.fetch(request)
        } catch {
            print("❌ Failed to fetch locations:", error)
        }
    }

    func deleteLocation(_ location: Location) {
        context.delete(location)
        PersistenceController.shared.saveChanges()
        fetchLocations()
    }
}
