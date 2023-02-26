//
//  ViewController.swift
//  weatherApp
//
//  Created by Рустам Т on 2/22/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temprLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var manager = NetworkWeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lazy var locationManager: CLLocationManager = {
            let lm = CLLocationManager()
            lm.delegate = self
            lm.desiredAccuracy = kCLLocationAccuracyKilometer
            lm.requestWhenInUseAuthorization()
            return lm
        }()
        
        manager.onCompletion = { [weak self] currentWeather in
            guard let self =  self else {return}
            self.updateUI(currentWeather: currentWeather)
            print(currentWeather.cityName)
        }
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
        
    }


    @IBAction func search(_ sender: UIButton) {
        createAlert(title: "Search", message: "Введите город", style: .alert){ [unowned self] city in
            self.manager.getWeather(requestType: .cityName(city: city))
        }
    }
    
    
    func updateUI(currentWeather: CurrentWeather){
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.temprLabel.text = currentWeather.tempToString
            self.feelsLikeLabel.text = currentWeather.feelsLikeTempToString 
            self.cloudImage.image = UIImage(systemName: currentWeather.weatherImage)
        }
        
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        self.manager.getWeather(requestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
