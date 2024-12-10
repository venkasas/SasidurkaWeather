//  Sasidurka Venkatesan - 991542294
//  Persistence.swift
//  SasidurkaWeather
//
//  Created by Sasidurka on 2024-11-26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Add sample data for previews
        for _ in 0..<5 {
            let newItem = LocationData(context: viewContext)
            newItem.id = UUID()
            newItem.city = "Toronto"
            newItem.country = "Canada"
            newItem.temperature = 22.0
            newItem.feelsLike = 24.0
            newItem.condition = "Partly Cloudy"
            newItem.windSpeed = 15.0
            newItem.windDirection = "NW"
            newItem.humidity = 60
            newItem.uvIndex = 5.0
            newItem.visibility = 10.0
            newItem.timestamp = Date()
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SasidurkaWeather") 
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

