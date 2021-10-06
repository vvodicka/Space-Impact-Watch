//
//  HelpAndSettingsView.swift
//  Space Impact iOS
//
//  Created by Vladislav Vodicka on 07/05/2021.
//

import SwiftUI

struct HelpAndSettingsView: View {
    
    var body: some View {
        ZStack{
            Color("Licorice").ignoresSafeArea()
            VStack{
                Image("logo").resizable().aspectRatio(contentMode: .fit)
                Text("Use your apple watch to play").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 25))
                HStack {
                    Image("tutorial1").resizable().aspectRatio(contentMode: .fit).frame(height: 200, alignment: .leading)
                    Text("Rotate digital crown to move up and down").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 15)).padding()
                }.padding()
                HStack {
                    Image("tutorial2").resizable().aspectRatio(contentMode: .fit).frame(height: 200, alignment: .center)
                    Text("Swipe right to fire special weapon").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 15)).padding()
                }.padding()
                Spacer()
            }.padding()
        }
        
    }
}

struct HelpAndSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        HelpAndSettingsView()
    }
}
