//
//  SwiftUIView.swift
//  AstronomyApp
//
//  Created by Ali Murad on 10/09/2022.
//

import SwiftUI
struct SelectDateView: View {
    
    @State private var date = Date()
    @ObservedObject var manage: NetworkManager
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Select a day").font(.headline)
            DatePicker(selection: $date, in : ...Date(), displayedComponents: .date) {
                Text("Select")
            }.labelsHidden()
            
            Button {
                self.manage.date = date
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Done")
            }

        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manage: NetworkManager())
    }
}
