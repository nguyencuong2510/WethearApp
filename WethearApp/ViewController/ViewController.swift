//
//  ViewController.swift
//  WethearApp
//
//  Created by nguyencuong on 12/17/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var maxtem_c: UILabel!
    @IBOutlet weak var mintemp_c: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(data(noti:)), name: NSNotification.Name.init("A"), object: nil)
    }
    
    @objc func data(noti: Notification) {
        guard let weather = DataService.share.weather else {
            return
        }
        self.temp_c.text = "\(weather.temp_c)"
        self.locationName.text = "\(weather.name), \(weather.country)"
        self.maxtem_c.text = "\(weather.forecastday[0].maxtemp_c)"
        self.mintemp_c.text = "\(weather.forecastday[0].mintemp_c)"
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.share.weather?.forecastday.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if let weather = DataService.share.weather, let icon = DataService.share.weather?.forecastday[indexPath.row].icon {
            print(icon)
            cell.date.text =  DataService.share.getDayOfWeekString(today: weather.forecastday[indexPath.row].date)
            cell.icon_Day.image = DataService.share.getImage(fromString: icon)
            cell.mintemp_c_Day.text = "\(weather.forecastday[indexPath.row].mintemp_c)"
            cell.maxtemp_c_Day.text = "\(weather.forecastday[indexPath.row].maxtemp_c)"
        }
        
        return cell
    }
    
    
}


