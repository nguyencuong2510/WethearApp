//
//  DataService.swift
//  WethearApp
//
//  Created by nguyencuong on 12/17/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import Foundation
class DataService {
    static let share = DataService()
    
    let urlPath = "http://api.apixu.com/v1/forecast.json?key=6e7472e7f53f418ebfd91542171212&q=hanoi&days=7"
    
    private var _weather: WeatherModel?
    
    var weather: WeatherModel?{
        set{
            if _weather == nil {
                getJSON()
            }
            _weather = newValue
        }
        get{
            return _weather
        }
    }
    
    
    func getJSON() {
        
        guard let url = URL(string: self.urlPath) else { return }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let datas = data else {return}
            DispatchQueue.main.async {
                guard let json = (try? JSONSerialization.jsonObject(with: datas, options: JSONSerialization.ReadingOptions.mutableContainers)) as? JSON else { return }
                self._weather = WeatherModel(json: json)
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "A"), object: nil)
            }
        }
        task.resume()
        
    }
    
}
