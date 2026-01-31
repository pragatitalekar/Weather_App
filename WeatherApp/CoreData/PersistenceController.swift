import CoreData

final class PersistenceController {

    static let shared = PersistenceController()
    let container: NSPersistentContainer

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WeatherModel")

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data load failed: \(error)")
            }
        }
    }

    func saveChanges() {
        let context = container.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }

    func createLocation(name: String, lat: Double, long: Double) {
        let location = Location(context: container.viewContext)
        location.id = UUID()
        location.name = name
        location.latitude = lat
        location.longitude = long
        saveChanges()
    }

    func delete(_ location: Location) {
        container.viewContext.delete(location)
        saveChanges()
    }
}
