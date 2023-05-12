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
    
    @EnvironmentObject var audioService: AudioService
    
    @State var isBlinking = false
    
    @State var task: Task<(), Never>?
    
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
                                .font(Font.custom("PressStart2P-Regular", size: 18))
                                .foregroundColor(.black)
                                .onChange(of: text) { _ in
                                    scrollProxy.scrollTo("texto", anchor: .bottom)
                                }
                           
                                .fixedSize(horizontal: false, vertical: true)
                                .lineSpacing(7)
                                
                        }
                        .frame(maxWidth: proxy.size.width * 0.75, maxHeight: proxy.size.height * 0.68)
                    }
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
        .onDisappear {
            task?.cancel()
            task = nil
        }
        .onAppear {
            
            let fontURL = Bundle.main.url(forResource: "PressStart2P-Regular", withExtension: "ttf")
            CTFontManagerRegisterFontsForURL(fontURL! as CFURL, .process, nil)
            
            let textToInsert = """
                On April 19, 1648, the Battle of Guararapes marked the birth of the Brazilian army, as it brought together people of different races - including blacks, Indians, and whites - to defend their land and freedom against foreign invaders. This event symbolizes unity, reflecting the diversity of our nation today.
                
                As a military member, I value diversity and mutual respect, which are central themes of this app. Inspired by my 38 age and my fascination with old 8-bit games, my 20 years career in the military and my learnings at the Apple Developer Academy, this app showcases military salutes as a way of demonstrating respect and gratitude.

                It's a way use my new skills to express my appreciation to all military personnel who devote their lives to protecting their nations.
                """

            show(textToInsert: textToInsert)
            
            print("onAppear")
            
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
        
        
        text = ""
        
        task = Task {
            for character in textToInsert {
                try? await Task.sleep(for: .seconds(0.034))  //Ajustar velocidade do texto
                text.append(character)
            }
        }
    }
    
}
