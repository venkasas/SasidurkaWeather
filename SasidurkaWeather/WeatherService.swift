//  Sasidurka Venkatesan - 991542294
//  WeatherService.swift
//  SasidurkaWeather
//
//  Created by Sasidurka on 2024-11-28.
//

import Foundation

struct WeatherResponse: Decodable {
    let location: Location
    let current: Current
}

struct Location: Decodable {
    let name: String
    let country: String
}

struct Current: Decodable {
    let temp_c: Double
    let feelslike_c: Double
    let wind_kph: Double
    let wind_dir: String
    let humidity: Int
    let uv: Double
    let vis_km: Double
    let condition: Condition
}

struct Condition: Decodable {
    let text: String
}

class WeatherService {
    private let apiKey = "9097b48d85b8472aa2914623242911"

    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(latitude),\(longitude)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        print("Fetching weather data from: \(urlString)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching weather data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received from weather API")
                completion(nil)
                return
            }

            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print("Weather data received: \(weather)")
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}


