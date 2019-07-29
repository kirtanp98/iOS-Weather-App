

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        
//        let weather = fetchWeather(longitute: 37.8267, latitude: -122.4233)

        
    }
    
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            setupLocationManager()
        } else {
            // Turn on
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        print("Location Manger Setup")
    }
    
    func checkLocationAuthorization() {
        print("Location Authorization Check")
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print(getLatLong())
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            checkLocationAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            print(getLatLong())
        case .denied:
            break
        @unknown default:
            break
        }
    }
    
    func getLatLong() -> Array<Any> {
        let currentLocation = locationManager.location
        let longitude = currentLocation?.coordinate.longitude as Any
        let latitude = currentLocation?.coordinate.latitude as Any
        
        return [latitude, longitude]
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

