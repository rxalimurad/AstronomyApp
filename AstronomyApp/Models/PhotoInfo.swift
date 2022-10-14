//
//  PhotoInfo.swift
//  AstronomyApp
//
//  Created by Ali Murad on 10/09/2022.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: String?
    var copyright: String?
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
        
    }
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(String.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.description = ""
        self.title = ""
        self.date = ""
    }
    
    static func createDefault() -> PhotoInfo {
        var photoInfo = PhotoInfo()
        photoInfo.title = "Galaxy by the Lake"
        photoInfo.description = "This 180 degree panoramic night skyscape captures our Milky Way Galaxy as it arcs above the horizon on a winter's night in August. Near midnight, the galactic center is close to the zenith with the clear waters of Lake Traful, Neuquen, Argentina, South America, planet Earth below. Zodiacal light, dust reflected sunlight along the Solar System's ecliptic plane, is also visible in the region's very dark night sky. The faint band of light reaches up from the distant snowy peaks toward the galaxy's center. Follow the arc of the Milky Way to the left to find the southern hemisphere stellar beacons Alpha and Beta Centauri. Close to the horizon bright star Vega is reflected in the calm mountain lake."
        photoInfo.date = "2022-09-09"
        return photoInfo
    }
    
}
