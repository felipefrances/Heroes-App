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
                
                Image("bg-2")
                    .resizable()
                VStack {
                    
                    Text("HEROES")
                        .padding(.top, 200)
                        .font(Font.custom("PressStart2P-Regular", size: 100))
                       

                    Spacer()
                    
                    //                    ScrollViewReader { scrollProxy in
                    //                        ScrollView {
                    //                            Text(text)
                    //                                .id("texto")
                    //                                .contentTransition(.interpolate)
                    //                                .font(Font.custom("PressStart2P-Regular", size: 22))
                    //                                .onChange(of: text) { _ in
                    //                                    scrollProxy.scrollTo("texto", anchor: .bottom)
                    //                                }
                    //                            //  MUDAR A COR DA FONTE PARA VERDE???
                    // UM CLIQUE E O TEXTO APARECE TODO
                    //                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                    //                                .fixedSize(horizontal: false, vertical: true)
                    //                                .lineSpacing(10)
                    //                        }
                    //                        .frame(maxWidth: proxy.size.width * 0.75, maxHeight: proxy.size.height * 0.68)
                    //                    }
                    //
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
                The history of the Brazilian army is a story of diversity and unity. It goes back to the Battle of Guararapes, where blacks, Indians, and whites joined forces despite their races to defend their land and freedom against the invaders. This "fusion of races" was the embryo of the Brazilian army and represents what the Brazilian people are today, a mixture of all races and cultures. I was inspired by my personal journey and this history to create this project, which shows a military man paying homage to  military personnel of various races and genders. The military salute is a way of showing respect, recognition, and gratitude for his homeland and the people who work to defend it.
                                
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

//                .onAppear {
//                    let sound = "alemdohorizonterock3"
//                    if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
//                        do {
//                            let url = URL(fileURLWithPath: path)
//                            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
//                            self.audioPlayer?.numberOfLoops = -1 // Reproduz em loop infinito
//                            self.audioPlayer?.play()
//                        } catch {
//                            print("Erro ao carregar o som: \(error.localizedDescription)")
//                        }
//                    }
//                }
//            VStack {

//                Spacer()

//                HStack {

//                Spacer()
