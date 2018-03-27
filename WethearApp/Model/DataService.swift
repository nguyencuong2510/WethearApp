//
//  DataService.swift
//  WethearApp
//
//  Created by nguyencuong on 12/17/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import Foundation
import UIKit


class DataService {
    static let share = DataService()
    
    let urlPath = "http://api.apixu.com/v1/forecast.json?key=a8adf2859d80488a85d135701181701&q=Hanoi&days=7"
    
    private var _weather: WeatherModel?
    
    var weather: WeatherModel?{
        set{
            _weather = newValue
        }
        get{
            if _weather == nil {
                getJSON()
            }
            return _weather
        }
    }
    
    func getImage(fromString: String) -> UIImage? {
        let path = "http:\(fromString)"
        guard let url = URL(string: path),
            let data = try? Data(contentsOf: url)
            else { return UIImage(named: "default") }
        return UIImage(data: data)
    }
    
    func getDayOfWeekString(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if formatter.date(from: today) != nil {
            let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let myComponents = myCalendar.component(.weekday, from: formatter.date(from: today)!)
            switch myComponents {
            case 1:
                return "Chủ Nhật"
            case 2:
                return "Thứ Hai"
            case 3:
                return "Thứ Ba"
            case 4:
                return "Thứ Tư"
            case 5:
                return "Thứ Năm"
            case 6:
                return "Thứ Sáu"
            case 7:
                return "Thứ Bảy"
            default:
                print("Error fetching days")
                return "Day"
            }
        } else {
            return nil
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
