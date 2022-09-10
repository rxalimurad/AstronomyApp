//
//  NetworkManager.swift
//  AstronomyApp
//
//  Created by Ali Murad on 10/09/2022.
//

import Foundation
import Combine
import SwiftUI


class NetworkManager: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    @Published var photoInfo = PhotoInfo()
    @Published var image: UIImage?
    @Published var date = Date()
    
    
    init() {
        let url = URL(string: Constants.baseURL)
        guard let fullURL = url?.withQuery([
            "api_key": Constants.key
        ]) else {
            return
        }
        
        print (fullURL)
        
        $date.removeDuplicates()
            .sink { value in
                self.image = nil
            }
            .store(in: &subscriptions)

        
        
        $date.removeDuplicates()
            .map {
                self.createURL(for: $0)
            }.flatMap({ url in
                URLSession.shared.dataTaskPublisher(for: url!)
                    .map(\.data)
                    .decode(type: PhotoInfo.self, decoder: JSONDecoder())
                    .catch { error in
                        Just(PhotoInfo())
                    }
            })
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        
        
        $photoInfo
            .filter { $0.url != nil }
            .map({ photoInfo in
                return URL(string: photoInfo.url!)!
                
            }).flatMap { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch { error in
                        return Just(Data())
                    }
            }.map { (out) -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
        
        
        
        
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("fetch complet finished")
//                case .failure(let failure):
//                    print("fetch completed with error: \(failure.localizedDescription)")
//                }
//            } receiveValue: { (data, response) in
//                if let description = String(data: data, encoding: .utf8) {
//                    print ("fetched new data \(description)")
//                }
//            }.store(in: &subscriptions)

        
        
        
        
        
    }
    
    func createURL(for date: Date) -> URL? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: date)
        
        let url = URL(string: Constants.baseURL)
        let fullURL = url?.withQuery([
            "api_key" : Constants.key,
            "date" : stringDate
        ])
        return fullURL
    }
    
}

