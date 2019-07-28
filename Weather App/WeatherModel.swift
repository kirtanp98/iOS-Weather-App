

import Foundation

public class WeatherModel : Codable {
    let latitude : Double
    let longitude: Double
    let currentWeather : currentWeatherModel
    
    public class currentWeatherModel : Codable {
        let time : Date
        let summary : String = ""
        let icon : String = ""
        let precipProbability : Double = 0.0
        let precipitaionType : String? = nil
        let temperature : Double = 0.0 //Degrees Celcius
        let visibility : Double = 0.0//Kilometers

        enum CodingKeys: String, CodingKey {
            case time
            case summary
            case icon
            case precipProbability
            case precipitaionType = "precipType"
            case temperature
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currentWeather = "currently"
    }
    
}


