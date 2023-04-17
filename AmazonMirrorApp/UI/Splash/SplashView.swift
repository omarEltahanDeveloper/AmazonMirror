//
//  SplashView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 13/04/2023.
//

import SwiftUI

struct SplashView: View {
    @State var goProducts = false
    
    var body: some View {
        ZStack {
            Image("Splash").resizable().scaledToFit()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
