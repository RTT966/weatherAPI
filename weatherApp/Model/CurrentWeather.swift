//
//  CurrentWeather.swift
//  weatherApp
//
//  Created by Рустам Т on 2/23/23.
//

import Foundation

struct CurrentWeather{
    let cityName: String
    let tempreture: Double
    
    var tempToString: String{
        (String(format: "%.1f", tempreture) + "℃")
    }
    
    let feelsLikeTemp:Double
    var feelsLikeTempToString: String{
        ("feels like" + " " + (String(format: "%.1f", feelsLikeTemp) + "℃"))
    }
    
    let conditionCode: Int
    var weatherImage: String{
        switch conditionCode{
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign.app.fill"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData){
        cityName = currentWeatherData.name
        tempreture = currentWeatherData.main.temp
        feelsLikeTemp = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
