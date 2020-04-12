//
//  ContentView.swift
//  MusicGenerator
//
//  Created by Henrique Figueiredo Conte on 05/04/20.
//  Copyright © 2020 Henrique Figueiredo Conte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentInputText: String = ""
    
    var buttonsWidth: CGFloat = ScreenSize.width * 0.15
    
    var body: some View {
        VStack() {
            inputTextField
            
            Spacer()
                .frame(height: ScreenSize.height * 0.25)
            
            controlBar
            
        }
        .background(Image("barBackground"))
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    var inputTextField: some View {
        TextField("Enter your text here", text: $currentInputText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: ScreenSize.width * 0.75, height: ScreenSize.height * 0.2, alignment: .leading)
            .font(.system(size: ScreenSize.width * 0.03))
    }
    
    var controlBar: some View {
        
        HStack {
            Button(action: {
                
            }) {
                Image("playIcon").resizable()
                    .frame(width: buttonsWidth, height: buttonsWidth, alignment: .center)
            }
            
            Button(action: {
                
            }) {
                Image("stopIcon").resizable()
                    .frame(width: buttonsWidth, height: buttonsWidth, alignment: .center)
            }
    
            Spacer()
                .frame(width: ScreenSize.width * 0.4)
            
            Button(action: {
                
            }) {
                Image("pauseIcon").resizable()
                    .frame(width: buttonsWidth, height: buttonsWidth, alignment: .center)
            }
        }
            .background(Image("caseBackground"))
            .frame(width: ScreenSize.width * 0.85, height: ScreenSize.height * 0.25, alignment: .center)
            .cornerRadius(40)
            .offset(y: 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
