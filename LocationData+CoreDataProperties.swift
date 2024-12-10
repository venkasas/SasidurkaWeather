//
//  LocationData+CoreDataProperties.swift
//  SasidurkaWeather
//
//  Created by Sasidurka on 2024-11-28.
//
//

import Foundation
import CoreData


extension LocationData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationData> {
        return NSFetchRequest<LocationData>(entityName: "LocationData")
    }

    @NSManaged public var city: String?
    @NSManaged public var condition: String?
    @NSManaged public var country: String?
    @NSManaged public var feelsLike: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var temperature: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var uvIndex: Double
    @NSManaged public var visibility: Double
    @NSManaged public var windDirection: String?
    @NSManaged public var windSpeed: Double

}

extension LocationData : Identifiable {

}
