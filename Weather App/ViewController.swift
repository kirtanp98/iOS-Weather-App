

import UIKit
import MapKit

class ViewController: UIViewController, JSONFetcherDelegate {
    
    var jsonFetcher:JSONFetcher?
    var weather:WeatherModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: 40.493630, latitude: -74.504770)
    }
    
    func didFinishFetching(_ sender: JSONFetcher) {
        weather = jsonFetcher!.weather
        print(weather!.currentWeather.temperature)
    }
    
}

