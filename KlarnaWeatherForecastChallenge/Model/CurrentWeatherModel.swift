//
//  CurrentWeatherModel.swift
//  KlarnaWeatherForecastChallenge
//
//  Created by Mehmet Can Seyhan on 2019-07-04.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherModel: Codable {
    var latitude:Double?
    var longitude:Double?
    var timezone:String?
    var currently:Currently?
}

struct Currently: Codable {
    var time:Int?
    var summary:String?
    var icon:String?
    var precipIntensity:Double?
    var precipProbability:Double?
    var temperature:Double?
    var apparentTemperature:Double?
    var dewPoint:Double?
    var humidity:Double?
    var pressure:Double?
    var windSpeed:Double?
    var windGust:Double?
    var windBearing:Double?
    var cloudCover:Double?
    var uvIndex:Double?
    var visibility:Double?
    var ozone:Double?
}

extension Currently {
    var iconImage: UIImage? {
        switch icon {
        case "clear-day":
            return UIImage(named: "clear-day")!
        case "clear-night":
            return UIImage(named: "clear-night")!
        case "rain":
            return UIImage(named: "rain")!
        case "snow":
            return UIImage(named: "snow")!
        case "sleet":
            return UIImage(named: "sleet")!
        case "wind":
            return UIImage(named: "wind")!
        case "fog":
            return UIImage(named: "fog")!
        case "cloudy":
            return UIImage(named: "cloudy")!
        case "partly-cloudy-day":
            return UIImage(named: "partly-cloudy")!
        case "partly-cloudy-night":
            return UIImage(named: "cloudy-night")!
        default:
            return UIImage(named: "default")!
        }
    }
}
