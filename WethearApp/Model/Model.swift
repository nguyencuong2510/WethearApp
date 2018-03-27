//
//  Model.swift
//  WethearApp
//
//  Created by nguyencuong on 12/17/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>

class WeatherModel {
    
    var name: String
    var country: String
    var temp_c: Double
    var last_updated: String
    var humidity: Double
    var icon: String
    var forecastday : [Forecastday] = []
    
    init?(json: JSON) {
        guard let location = json["location"] as? JSON,
            let current = json["current"] as? JSON,
            let condition = current["condition"] as? JSON,
            let forecast = json["forecast"] as? JSON,
            let forecastday = forecast["forecastday"] as? [JSON],
            
            let name = location["name"] as? String,
            let country = location["country"] as? String,
            let temp_c = current["temp_c"] as? Double,
            let last_updated = current["last_updated"] as? String,
            let humidity = current["humidity"] as? Double,
            
            let icon = condition["icon"] as? String
            else { return nil }
        
        for forecastday in forecastday {
            if let ab = Forecastday(forecastdays: forecastday){
                self.forecastday.append(ab)
            }
        }
        
        self.name = name
        self.country = country
        self.temp_c = temp_c
        self.last_updated = last_updated
        self.humidity = humidity
        self.icon = icon
    }
}

class Forecastday {
    
    var date: String
    var maxtemp_c: Double
    var mintemp_c: Double
    var avghumidity: Double
    var icon: String
    
    init?(forecastdays: JSON) {
        guard let date = forecastdays["date"] as? String,
            let day = forecastdays["day"] as? JSON,
            let condition = day["condition"] as? JSON,
            
            let maxtemp_c = day["maxtemp_c"] as? Double,
            let mintemp_c = day["mintemp_c"] as? Double,
            let avghumidity = day["avghumidity"] as? Double,
            let icon = condition["icon"] as? String
            else { return nil }
        
        self.date = date
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.avghumidity = avghumidity
        self.icon = icon
    }
    
}






