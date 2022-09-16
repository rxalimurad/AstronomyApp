//
//  PictureOfTodayView.swift
//  AstronomyApp
//
//  Created by Ali Murad on 10/09/2022.
//

import SwiftUI

struct PictureOfTodayView: View {
    @ObservedObject var manager: NetworkManager
    @State private var showSwitchDate: Bool = false
    @State private var date = Date()
    
    
    init(manager: NetworkManager) {
        self.manager = manager
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack(alignment: .bottom) {
                if manager.image != nil {
                    Image(uiImage: manager.image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity, height: .infinity, alignment: .center)
                } else {
                    LoadingAnimationBox()
                }
                VStack(alignment: .center, spacing: 0) {
                    DatePicker(selection: $manager.date, in : ...Date(), displayedComponents: .date) { }
                        .tint(.white)
                        .accentColor(.orange)
                        .colorMultiply(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                       
                        
                }.foregroundColor(.white)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(manager.photoInfo.date)
                        .font(.title)
                        .padding([.leading, .trailing], 20)
                    Text(manager.photoInfo.title)
                        .font(.headline)
                        .padding([.leading, .trailing], 20)
                    Text(manager.photoInfo.description)
                        .padding([.leading, .trailing], 20)
                    
                }
            }
            
        }.ignoresSafeArea()
    }
}

struct PictureOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PictureOfTodayView(manager: NetworkManager())
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = UIImage(named: "previewImage")
        return view
    }
}
