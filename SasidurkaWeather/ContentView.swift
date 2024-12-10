//  Sasidurka Venkatesan - 991542294
//  ContentView.swift
//  SasidurkaWeather
//
//  Created by Sasidurka on 2024-11-26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: LocationData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \LocationData.timestamp, ascending: false)]
    ) private var items: FetchedResults<LocationData>

    @StateObject private var locationManager = LocationManager()
    @State private var weather: WeatherResponse?

    var body: some View {
        VStack {
            if let weather = weather {
                VStack {
                    Text("City: \(weather.location.name), \(weather.location.country)")
                    Text("Temperature: \(weather.current.temp_c)°C")
                    Text("Feels Like: \(weather.current.feelslike_c)°C")
                    Text("Condition: \(weather.current.condition.text)")
                    Text("Wind: \(weather.current.wind_kph) km/h (\(weather.current.wind_dir))")
                    Text("Humidity: \(weather.current.humidity)%")
                    Text("UV Index: \(weather.current.uv)")
                    Text("Visibility: \(weather.current.vis_km) km")
                }

                Button("Save Weather Data") {
                    saveWeatherData(weather)
                }
            } else {
                Text("Fetching Weather...")
            }

            List {
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        Text("\(item.city ?? "Unknown City"), \(item.country ?? "Unknown Country")")
                        Text("Temperature: \(item.temperature)°C")
                        Text("Condition: \(item.condition ?? "Unknown Condition")")
                        if let timestamp = item.timestamp {
                            Text("Updated: \(timestamp, formatter: itemFormatter)")
                        }
                    }
                }
            }
        }
        .onAppear {
            if let location = locationManager.location {
                WeatherService().fetchWeather(latitude: location.latitude, longitude: location.longitude) { weather in
                    self.weather = weather
                }
            }
        }
    }

    private func saveWeatherData(_ weather: WeatherResponse) {
        let newItem = LocationData(context: viewContext)
        newItem.id = UUID()
        //newItem.city = weather.location.name
       // newItem.country = weather.location.country
        newItem.temperature = weather.current.temp_c
        newItem.feelsLike = weather.current.feelslike_c
        newItem.condition = weather.current.condition.text
        newItem.windSpeed = weather.current.wind_kph
        newItem.windDirection = weather.current.wind_dir
        newItem.humidity = Int16(weather.current.humidity)
        newItem.uvIndex = weather.current.uv
        newItem.visibility = weather.current.vis_km
        newItem.timestamp = Date()

        do {
            try viewContext.save()
        } catch {
            print("Failed to save weather data: \(error)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
