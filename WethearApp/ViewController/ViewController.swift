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
    @IBOutlet weak var last_Update: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(data(noti:)), name: NSNotification.Name.init("A"), object: nil)
        DataService.share.getJSON()
    }
    
    @objc func data(noti: Notification) {
        guard let weather = DataService.share.weather else {
            return
        }
        self.temp_c.text = "\(weather.temp_c)"
        self.locationName.text = "\(weather.name), \(weather.country)"
        self.last_Update.text = weather.last_updated
        self.maxtem_c.text = "\(weather.forecastday[0].maxtemp_c)"
        self.mintemp_c.text = "\(weather.forecastday[0].mintemp_c)"
    }


}

