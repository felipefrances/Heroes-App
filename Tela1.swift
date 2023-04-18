//
//  Tela1.swift
//  Heroes
//
//  Created by user on 18/04/23.
//

import Foundation
import SwiftUI

struct Tela1: View {


    @State var text = ""
    
//    @State var text = """
//I'm 38 years old, and I've been a military man for 20 years, transitioning to the software development field through the Academy Foundation program. As a military man, I had the chance to work with people of all races, genders, and religions, which taught me to value diversity and the importance of unity.
//
//The history of the Brazilian army is a story of diversity and unity. It goes back to the Battle of Guararapes, where blacks, Indians, and whites joined forces despite their races to defend their land and freedom against the invaders. This "fusion of races" was the embryo of the Brazilian army and represents what the Brazilian people are today, a mixture of all races and cultures. I was inspired by my personal journey and this history to create this project, which shows a military man paying homage to  military personnel of various races and genders. The military salute is a way of showing respect, recognition, and gratitude for his homeland and the people who work to defend it.
//
//Through this project, I want to promote diversity and mutual respect, values that I learned in the military, and apply them in a new area: technology.
//
//Note: In this project, the choice of an 8-bit arcade style for the app considers my childhood in the late 80s, when I played an electronic game for the first time on my older siblings' Atari. For the soundtrack, I made a chiptune version of one of my favorite songs, from a Brazilian pop-rock band from my home state.
//"""
    
    @EnvironmentObject var audioService: AudioService
    
    @State var isBlinking = false
    
    var body: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                
                Image("bg-2")
                    .resizable()
                
                VStack {
                    ScrollViewReader { scrollProxy in
                        ScrollView {
                            Text(text)
                                .id("texto")
                                .contentTransition(.interpolate)
                                .font(Font.custom("PressStart2P-Regular", size: 22))
                                .onChange(of: text) { _ in
                                    scrollProxy.scrollTo("texto", anchor: .bottom)
                                }
                            //  MUDAR A COR DA FONTE PARA VERDE???
                            // UM CLIQUE E O TEXTO APARECE TODO
                            
                            //                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .fixedSize(horizontal: false, vertical: true)
                                .lineSpacing(10)
                                
                        }
                        .frame(maxWidth: proxy.size.width * 0.75, maxHeight: proxy.size.height * 0.68)
                    }
                    
//                    NavigationLink(
//                        destination: Tela2().environmentObject(audioService)
//                    ) {
//                        VStack{
//                            HStack{
//                                Spacer()
//                                Image("skipbutton")
//                                    .opacity(isBlinking ? 0 : 1)
//                                    .onAppear {
//                                        withAnimation(.linear.repeatForever()) {
//                                            isBlinking = true
//
//                                        }
//                                    }
//                            }
//                        }
//                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            audioService.soundOn.toggle()
                        } label: {
                            Image(audioService.soundOn ? "speaker" : "mute") // if ternary
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: proxy.size.width * 0.1, height: proxy.size.width * 0.05)
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .clipShape(Circle())
                    }
                }
                .padding()

            }
            .ignoresSafeArea()
            

        }
        .onAppear {
            
            let fontURL = Bundle.main.url(forResource: "PressStart2P-Regular", withExtension: "ttf")
            CTFontManagerRegisterFontsForURL(fontURL! as CFURL, .process, nil)
            
            let textToInsert = """
                DdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDddddddddddddddddddddddddddddddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddDdddddddddddddddddddddddddddddddddddddddddddd
                """

            show(textToInsert: textToInsert)
            
            
        }
        .overlay(
            
            NavigationLink(
                destination: Tela2().environmentObject(audioService)
            ) {
                VStack{
                    HStack{
                        Spacer()
                        Image("skipbutton")
                            .opacity(isBlinking ? 0 : 1)
                            .onAppear {
                                withAnimation(.linear.repeatForever()) {
                                    isBlinking = true
                            
                                }
                            }
                    }
                }
            }
            
                .padding(.bottom, 210)
                .padding(.horizontal, 44) //Ajustar altura e padding do botao de skip do texto
            ,alignment: .bottomTrailing
        )
    }
    
    func show(textToInsert: String) {
        Task {
            for character in textToInsert {
                try! await Task.sleep(for: .seconds(0.034))  //Ajustar velocidade do texto
                text.append(character)
            }
        }
    }
    
}
