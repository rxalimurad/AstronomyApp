//
//  PictureOfTodayView.swift
//  AstronomyApp
//
//  Created by Ali Murad on 10/09/2022.
//

import SwiftUI

struct PictureOfTodayView: View {
    @ObservedObject var manager = NetworkManager()
    @State private var showSwitchDate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button {
                showSwitchDate.toggle()
            } label: {
                Image(systemName: "calendar")
                Text("Switch Day")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .popover(isPresented: $showSwitchDate) {
                SelectDateView(manage: self.manager)
            }

            
            if manager.image != nil {
                Image(uiImage: manager.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                Rectangle().fill(Color(.lightGray))
                    .frame(height: 400)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(manager.photoInfo.date)
                        .font(.title)
                    Text(manager.photoInfo.title)
                        .font(.headline)
                    Text(manager.photoInfo.description)
                    
                }
            }
            
        }
    }
}

struct PictureOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PictureOfTodayView()
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = UIImage(named: "previewImage")
        return view
    }
}
