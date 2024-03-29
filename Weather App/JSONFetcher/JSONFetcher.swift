

import Foundation

class JSONFetcher {
    
    var weather:WeatherModel?
    var delegate:JSONFetcherDelegate?
    
    init() {
        self.weather = nil
    }
    
    func fetchWeather(longitute: Double, latitude : Double, apikey: String) {
        let urlString = "https://api.darksky.net/forecast/\(apikey)/\(longitute),\(latitude)"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        self.weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                        self.didFetchJSON()
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
        }
    }
    
    func didFetchJSON() {
        delegate?.didFinishFetching(self)
    }
    
}
