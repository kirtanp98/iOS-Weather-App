

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let weather = fetchWeather(longitute: 37.8267, latitude: -122.4233)
    }

    
    //TODO: Make this in a delegate
    //Because we are not gaurentee to get the response and because it is a async task so we have to check if its done
    func fetchWeather(longitute: Double, latitude : Double) -> WeatherModel? {
        let urlString = "https://api.darksky.net/forecast/6fbcf7b85b9cd3021c8a39883c63389d/\(longitute),\(latitude)"
        var weatherObject : WeatherModel? = nil
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        weatherObject = try JSONDecoder().decode(WeatherModel.self, from: data)
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
            return weatherObject
        }
        return nil
    }
    
}

