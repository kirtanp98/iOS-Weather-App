

import Foundation

public class WeatherModel : Decodable {
    let latitude : Double
    let longitude: Double
    let currentWeather : currentWeatherModel
    
    public class currentWeatherModel : Decodable {
        let time : Date
        let summary : String
        let icon : String
        let precipProbability : Double
        let precipitaionType : String?
        let temperature : Double //Degrees Celcius
        let visibility : Double //Kilometers

        enum CodingKeys: String, CodingKey {
            case time
            case summary
            case icon
            case precipProbability
            case precipitaionType = "precipType"
            case temperature
            case visibility
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currentWeather = "currently"
    }
    
}


