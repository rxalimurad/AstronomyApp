//
//  ContentView.swift
//  AstronomyApp
//
//  Created by Ali Murad on 10/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PictureOfTodayView(manager: NetworkManager())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
