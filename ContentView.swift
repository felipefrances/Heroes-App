import SwiftUI

//incluir botao de som que habilita e desabilita a musica.

//TELA 01

struct ContentView: View {


   @State var text = ""
    
    @State var vetPosition: CGPoint = .zero
    @State var vetSizeProportion: Double = 0.18
    
    @State var aeroPosition: CGPoint = .zero
    @State var aeroSizeProportion: Double = 0.18
    
    @State var ebPosition: CGPoint = .zero
    @State var ebSizeProportion: Double = 0.18
    
    @State var marPosition: CGPoint = .zero
    @State var marSizeProportion: Double = 0.18
    
    @EnvironmentObject var audioService: AudioService
    
    fileprivate func charactersHStack(proxy: GeometryProxy) -> some View {
        return HStack {
            
            Image("mil-cont")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(
                    width: proxy.size.width * (vetSizeProportion/2),
                    height: proxy.size.height * vetSizeProportion
                )
            
            
            
            Image("mil-vet")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(
                    width: proxy.size.width * (vetSizeProportion/2),
                    height: proxy.size.height * vetSizeProportion
                )
            
            
            Image("mil-aer")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(
                    width: proxy.size.width * (aeroSizeProportion/2),
                    height: proxy.size.height * aeroSizeProportion
                )
            
            
            Image("mil-ebw.png")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(
                    width: proxy.size.width * (ebSizeProportion/2),
                    height: proxy.size.height * ebSizeProportion
                )
            
            
            
            Image("mil-mar-br")
            
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(
                    width: proxy.size.width * (marSizeProportion/2),
                    height: proxy.size.height * marSizeProportion
                )
            
        }
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                
                Image("Bg-1")
                    .resizable()
                VStack {
                    
//                    Text("Use the app in landscape position")
//                        .font(Font.custom("PressStart2P-Regular", size: 14))
//                    .background(Color.green.opacity(0.20))
//                    .clipShape(Rectangle())
                       
                    Spacer()
                    
                    VStack (spacing: 50){
                        NavigationLink(
                            destination: Tela1().environmentObject(audioService)
                        ) {
                            Image("start")
                        }
                        charactersHStack(proxy: proxy)
                    }
                    .padding(.bottom, 300)
                    .frame(height: proxy.size.height/2)
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
                                                On April 19, 1648, the Battle of Guararapes marked the birth of the Brazilian army, as it brought together people of different races - including blacks, Indians, and whites - to defend their land and freedom against foreign invaders. This event symbolizes unity, reflecting the diversity of our nation today.
                                                
                                                As a military member, I value diversity and mutual respect, which are central themes of this app. Inspired by 38 age and my fascination with old 8-bit games, my 20 years career in the military and my learnings at the Apple Developer Academy, this app showcases military salutes as a way of demonstrating respect and gratitude.

                                                 It a way to express my appreciation to all military personnel, whether Brazilian or not, who devote their lives to protecting their nations.

                                                For the best experience, please use your device in landscape orientation.
                                
                """
            
            
            show(textToInsert: textToInsert)
            
            
        }
    }
    
    func show(textToInsert: String) {
        Task {
            for character in textToInsert {
                try! await Task.sleep(for: .seconds(0.05))
                text.append(character)
            }
        }
    }
    
}

