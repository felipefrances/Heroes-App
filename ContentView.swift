import SwiftUI
import AVKit

//incluir botao de som que habilita e desabilita a musica.

struct ContentView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State var soundOn = true
    let soundbuttonProportion: Double = 1
    
    var body: some View {
        
        GeometryReader { proxy in
        
        ZStack {
            
            Image("bg-text")
                .resizable()
            
            VStack {
                
                Spacer()
                
                HStack {
                
                Spacer()
                    Button {
                        soundOn.toggle()
                    } label: {
                        if soundOn {
                            Image("speaker")
                                .resizable()
                                .frame(width: proxy.size.width * 0.03,
                                       height: proxy.size.width * 0.03)
                                .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
                            
                        } else {
                            Image("mute")
                                .resizable()
                                .frame(width: proxy.size.width * 0.03,
                                       height: proxy.size.width * 0.03)
                                .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
                            
                        }
                    }

                }
            }
            
            HStack{
                NavigationLink(destination: Tela2()) {
                    Image("start")
                }
            }
        }
    }
}
}

struct Tela2: View{
    
    
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
                        .border(.blue)
                    VStack {
                        Spacer()
                        Image(continencia ? "mil-cont" : "mil-padrao")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: proxy.size.width * (milSizeProportion/2),
                                height: proxy.size.height * milSizeProportion
                            )
                            .border(.red)
                    }
                    .padding(.leading, 50)
                    .padding(.bottom)
                    
                    .border(.blue)
                }
                //                .onAppear {
                //
                //                    aeroPosition = CGPoint(x: 0, y: 250)
                //                    ebPosition = CGPoint(x: 0, y: 500)
                //                    marPosition = CGPoint(x: 0, y: 750)
                //                }
                
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
                    
                    Image("mil-aer-1.png")
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
                .border(.green)
            }
            .padding()
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            
            //           botão de som - posicionamento e condicional de acionamento
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        soundOn.toggle()
                    } label: {
                        if soundOn {
                            Image("speaker")
                                .resizable()
                                .frame(width: proxy.size.width * 0.03,
                                       height: proxy.size.width * 0.03)
                                .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
                            
                        } else {
                            Image("mute")
                                .resizable()
                                .frame(width: proxy.size.width * 0.03,
                                       height: proxy.size.width * 0.03)
                                .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
                            
                        }
                    }

                    Button("X") {
                        soundOn.toggle()
                        
                    }
                    //                    Image(soundOn ? "speaker" : "mute")
                    //                        .resizable()
                    //                        .frame(width: proxy.size.width * 0.03, height: proxy.size.width * 0.03)
                    //                        .position(x: proxy.size.width * 0.95, y: proxy.size.height * 0.95)
                    //                }
                }
                
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
                    vetPosition.x = proxy.size.width * 0.6
                    vetPosition.y = proxy.size.height * 0.1
                    aeroPosition.x = proxy.size.width * 0.6
                    aeroPosition.y = proxy.size.height * 0.3
                    ebPosition.x = proxy.size.width * 0.6
                    ebPosition.y = proxy.size.height * 0.5
                    marPosition.x = proxy.size.width * 0.6
                    marPosition.y = proxy.size.height * 0.7
                }
            }
        }
        
    }
    
}
            
