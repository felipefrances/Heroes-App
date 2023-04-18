import SwiftUI

//incluir botao de som que habilita e desabilita a musica.

//TELA 01

struct ContentView: View {


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
                    
                    NavigationLink(
                        destination: Tela2().environmentObject(audioService)
                    ) {
                        Image("start")
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

struct Tela2: View{
    
    @EnvironmentObject var audioService: AudioService
    
    @State var soundOn = true
    @State var continencia = false
    
    let milSizeProportion: Double = 0.41
    
    @State var vetPosition: CGPoint = .zero
    @State var vetSizeProportion: Double = 0.18
    
    @State var aeroPosition: CGPoint = .zero
    @State var aeroSizeProportion: Double = 0.18
    
    @State var ebPosition: CGPoint = .zero
    @State var ebSizeProportion: Double = 0.18
    
    @State var marPosition: CGPoint = .zero
    @State var marSizeProportion: Double = 0.18
    
    var body: some View {
        GeometryReader { proxy in

            HStack(alignment: .bottom) {
                
                ZStack {
                    
                    Image("bandeira")
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Spacer()
                        Image(continencia ? "mil-cont" : "mil-padrao")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: proxy.size.width * (milSizeProportion/2),
                                height: proxy.size.height * milSizeProportion
                            )
                    }
                    .padding(.leading, 50)
                    .padding(.bottom)
                }
              
                ZStack {
                    Image("mil-vet")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .frame(
                            width: proxy.size.width * (vetSizeProportion/2),
                            height: proxy.size.height * vetSizeProportion
                        )
                        .position(x: vetPosition.x, y: vetPosition.y)
                        .gesture(
                            DragGesture().onChanged { value in
                                vetPosition = value.location
                            }
                        )
                    
                    Image("mil-aer")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .frame(
                            width: proxy.size.width * (aeroSizeProportion/2),
                            height: proxy.size.height * aeroSizeProportion
                        )
                        .position(x: aeroPosition.x, y: aeroPosition.y)
                        .gesture(
                            DragGesture().onChanged { value in
                                aeroPosition = value.location
                            }
                        )
                    
                    Image("mil-ebw.png")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .frame(
                            width: proxy.size.width * (ebSizeProportion/2),
                            height: proxy.size.height * ebSizeProportion
                        )
                        .position(x: ebPosition.x, y: ebPosition.y)
                        .gesture(
                            DragGesture().onChanged { value in
                                ebPosition = value.location
                            }
                        )
                    
                    
                    Image("mil-mar-br")
                    
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .frame(
                            width: proxy.size.width * (marSizeProportion/2),
                            height: proxy.size.height * marSizeProportion
                        )
                        .position(x: marPosition.x, y: marPosition.y)
                        .gesture(
                            DragGesture().onChanged { value in
                                marPosition = value.location
                            }
                        )
                }
            }
            .padding()
            .background(
                ZStack {
                    Image("bg-2")
                        .resizable()
                    
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
            )
            
            //           botão de som - posicionamento e condicional de acionamento
         
            
            
//            VStack {
//
//                Spacer()
//
//                HStack {
//
//                    Spacer()
//
//                    Button {
//                        soundOn.toggle()
//                    } label: {
//                        if soundOn {
//                            Image("speaker")
//                                .resizable()
//                                .frame(width: proxy.size.width * 0.03,
//                                       height: proxy.size.width * 0.03)
//                                .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
//                            
//                        } else {
//                            Image("mute")
//                                .resizable()
//                                .frame(width: proxy.size.width * 0.03,
//                                       height: proxy.size.width * 0.03)
//                                .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
//                            
//                        }
//                    }

                        
               //     }
                    //                    Image(soundOn ? "speaker" : "mute")
                    //                        .resizable()
                    //                        .frame(width: proxy.size.width * 0.03, height: proxy.size.width * 0.03)
                    //                        .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
                    //                }
             //   }
                
                //            if (soundOn = true){
                //                ebSizeProportion = milSizeProportion
                //            } else {
                //                ebSizeProportion = 0.18
                //            }
                
                //mudanca mateus para continencia ser na area e nao por boneco.
                //            .onChange(of: [vetPosition, aeroPosition, ebPosition, marPosition]) { newValues in
                //
                //                let thresholdX = proxy.size.width * 0.4
                //                let thresholdY = proxy.size.height * 0.4
                //
                //                continencia = newValues.contains(where: { position in
                //                    return position.x < thresholdX && position.y > thresholdY
                //                })
                //
                //            }
                
                //Boneco 1: Mudanca do tamanho do veterano dentro da area delimitada.
                
                .onChange(of: vetPosition, perform: { newValue in
                    
                    let thresholdX = proxy.size.width * 0.4
                    let thresholdY = proxy.size.height * 0.4
                    
                    print("\nx", newValue.x)
                    print("thresholdX", thresholdX)
                    
                    print("\ny", newValue.y)
                    print("thresholdY", thresholdY)
                    
                    // Condicional para mudanca do padrao para continencia, quando vet dentro da área delimitada pelas constantes thresholdX e thresholdY
                    
                    if newValue.x < thresholdX, newValue.y > thresholdY {
                        continencia = true
                        vetSizeProportion = milSizeProportion
                    } else {
                        vetSizeProportion = 0.18
                        continencia = false
                    }
                })
                
                //boneco 2: Mudanca do tamanho do aero dentro da area delimitada.
                
                .onChange(of: aeroPosition, perform: { newValue in
                    let thresholdX = proxy.size.width * 0.4
                    let thresholdY = proxy.size.height * 0.4
                    
                    print("\nx", newValue.x)
                    print("thresholdX", thresholdX)
                    
                    print("\ny", newValue.y)
                    print("thresholdY", thresholdY)
                    
                    // Condicional para mudanca do padrao para continencia, quando aero dentro da área delimitada pelas constantes thresholdX e thresholdY
                    
                    if newValue.x < thresholdX, newValue.y > thresholdY {
                        continencia = true
                        aeroSizeProportion = milSizeProportion
                    } else {
                        aeroSizeProportion = 0.18
                        continencia = false
                    }
                })
                
                //Boneco 3: Mudanca do tamanho do eb dentro da area delimitada.
                
                .onChange(of: ebPosition, perform: { newValue in
                    let thresholdX = proxy.size.width * 0.4
                    let thresholdY = proxy.size.height * 0.4
                    
                    print("\nx", newValue.x)
                    print("thresholdX", thresholdX)
                    
                    print("\ny", newValue.y)
                    print("thresholdY", thresholdY)
                    
                    // Condicional para mudanca do padrao para continencia, quando eb dentro da área delimitada pelas constantes thresholdX e thresholdY
                    
                    if newValue.x < thresholdX, newValue.y > thresholdY {
                        continencia = true
                        ebSizeProportion = milSizeProportion
                    } else {
                        ebSizeProportion = 0.18
                        continencia = false
                    }
                })
                
                //Boneco 4: Mudanca do tamanho do mar dentro da area delimitada.
                
                .onChange(of: marPosition, perform: { newValue in
                    let thresholdX = proxy.size.width * 0.4
                    let thresholdY = proxy.size.height * 0.4
                    
                    print("\nx", newValue.x)
                    print("thresholdX", thresholdX)
                    
                    print("\ny", newValue.y)
                    print("thresholdY", thresholdY)
                    
                    // Condicional para mudanca do padrao para continencia, quando mar dentro da área delimitada pelas constantes thresholdX e thresholdY
                    
                    if newValue.x < thresholdX, newValue.y > thresholdY {
                        continencia = true
                        marSizeProportion = milSizeProportion
                    } else {
                        marSizeProportion = 0.18
                        continencia = false
                    }
                })
                
                // Posicionamento inicial dos bonecos vet, aero, eb, mar
                .onAppear {
                    if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                        vetPosition.x = proxy.size.height * 0.6
                        vetPosition.y = proxy.size.width * 0.08
                        aeroPosition.x = proxy.size.height * 0.6
                        aeroPosition.y = proxy.size.width * 0.28
                        ebPosition.x = proxy.size.height * 0.6
                        ebPosition.y = proxy.size.width * 0.48
                        marPosition.x = proxy.size.height * 0.6
                        marPosition.y = proxy.size.width * 0.68
                    } else {
                        vetPosition.x = proxy.size.width * 0.6
                        vetPosition.y = proxy.size.height * 0.08
                        aeroPosition.x = proxy.size.width * 0.6
                        aeroPosition.y = proxy.size.height * 0.28
                        ebPosition.x = proxy.size.width * 0.6
                        ebPosition.y = proxy.size.height * 0.48
                        marPosition.x = proxy.size.width * 0.6
                        marPosition.y = proxy.size.height * 0.68
                    }
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
