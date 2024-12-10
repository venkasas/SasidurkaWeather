// Sasidurka Venkatesan - 991542294
//  SasidurkaWeatherApp.swift
//  SasidurkaWeather
//
//  Created by Sasidurka on 2024-11-26.
//

import SwiftUI

@main
struct SasidurkaWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
