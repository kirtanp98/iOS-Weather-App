

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let url = URL(string: "https://api.darksky.net/forecast/6fbcf7b85b9cd3021c8a39883c63389d/37.8267,-122.4233") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(WeatherModel.self, from: data)
                        print(res.latitude)
                        print(res.longitude)
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
        }
    }


}

