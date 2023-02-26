//
//  NetworkWeatherManager.swift
//  weatherApp
//
//  Created by Рустам Т on 2/23/23.
//

import Foundation
import CoreLocation


class NetworkWeatherManager{
    
    var onCompletion: ((CurrentWeather)-> Void)?
    
    enum RequestType{
        case cityName (city: String)
        case coordinate (latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    func getWeather(requestType: RequestType){
        var urlString = ""
        switch requestType{
        case .cityName(let city):
            urlString = "https:api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        getRequest(urlString: urlString)
    }
    
    
//    func getWeather (city: String){
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
//        getRequest(urlString: urlString)
//    }
//
//
//    func getWeather (latitude: CLLocationDegrees, longitude: CLLocationDegrees){
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
//        getRequest(urlString: urlString)
//    }
    
    
    
   fileprivate func getRequest(urlString: String){
        guard let url = URL(string: urlString) else {return}
         let session = URLSession(configuration: .default)
         let task = session.dataTask(with: url) { data, response, error in
             if let data = data{
                 if let currentWeather = self.parseJSON(withData: data){
                     self.onCompletion?(currentWeather)
                 }
             }
         }
         task.resume()
    }
    
    
    
    
    
   fileprivate func parseJSON(withData: Data)-> CurrentWeather?{
        let decoder = JSONDecoder()
        do{
          let currentWeatherData =  try decoder.decode(CurrentWeatherData.self, from: withData)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil}
           return currentWeather
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
        
    }
    
}
