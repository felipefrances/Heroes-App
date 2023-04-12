import SwiftUI

//     2.2 Detectar se a imagem está na regiao desejada pra mudar o state


//está dando problema de escala no tamanho dos bonecos. Cada boneco aciona em uma coordenada diferente , mais abaixo da tela. Precisa consertar.

//criar uma condiçao que caso haja qualquer boneco dentro da coordenada estipulada para a continencia, o boneco permanece em continencia. atualmente com bug de dois bonecos na area

// Ajustar texto do background da primeira tela. Incluir a celebracao da "unity and diversity", "enjoy" e passar por correcao ortografica.

//incluir botao de som que habilita e desabilita a musica.

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("bg-text")
                .resizable()
            HStack{
                NavigationLink(destination: Tela2()) {
                    Image("start")
                }
            }
        }
    }
}

struct Tela2: View{
    
    
    @State var continencia = false
    
    let milSizeProportion: Double = 0.41
    
    @State var vetPosition: CGPoint = .zero
    @State var vetSizeProportion: Double = 0.18
    
    @State var aeroPosition: CGPoint = CGPoint(x: 0, y: 150)
    @State var aeroSizeProportion: Double = 0.18
    
    @State var ebPosition: CGPoint = CGPoint(x: 0, y: 300)
    @State var ebSizeProportion: Double = 0.18
    
    @State var marPosition: CGPoint = CGPoint(x: 0, y: 450)
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
//                    HStack {      //boneco duplicado. Excluir após teste final
//                    Image(continencia ? "mil-cont" : "mil-padrao")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(
//                            width: proxy.size.width * (milSizeProportion/2),
//                            height: proxy.size.height * milSizeProportion
//                        )
//                        .border(.red)
//                }
//                .padding(.leading, 50)
//
//                Spacer()
//                    .border(.blue)
//
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
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.accentColor)
//                        .frame(width: proxy.size.width * 0.18, height: proxy.size.height * 0.18)
//                        .position(x: aeroPosition.x, y: aeroPosition.y)
//                        .gesture(
//                            DragGesture().onChanged { value in
//                                aeroPosition = value.location
//                            }
//                        )

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
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.accentColor)
//                        .frame(width: proxy.size.width * 0.18, height: proxy.size.height * 0.18)
//                        .position(x: ebPosition.x, y: ebPosition.y)
//                        .gesture(
//                            DragGesture().onChanged { value in
//                                ebPosition = value.location
//                            }
//                        )

                    Image("mil-mar-br")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .frame(width: proxy.size.width * 0.18, height: proxy.size.height * 0.18)
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
            .onChange(of: [vetPosition, aeroPosition, ebPosition, marPosition]) { newValues in
                
                let thresholdX = proxy.size.width * 0.4
                let thresholdY = proxy.size.height * 0.4
                
                continencia = newValues.contains(where: { position in
                    return position.x < thresholdX && position.y > thresholdY
                })

            }
            
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
//                    continencia = true
                    vetSizeProportion = milSizeProportion
                } else {
                    vetSizeProportion = 0.18
//                    continencia = false
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
//                    continencia = true
                    aeroSizeProportion = milSizeProportion
                } else {
                    aeroSizeProportion = 0.18
//                    continencia = false
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
//                    continencia = true
                    ebSizeProportion = milSizeProportion
                } else {
                    ebSizeProportion = 0.18
//                    continencia = false
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
//                    continencia = true
                    marSizeProportion = milSizeProportion
                } else {
                    marSizeProportion = 0.18
//                    continencia = false
                }
            })
            
            
            // Replicar pros outros bonequinhos
            .onAppear {
                // colocar pontos iniciais corretos em todos os positions
                vetPosition.x = proxy.size.width * 0.5
                aeroPosition.x = proxy.size.width * 0.5
                ebPosition.x = proxy.size.width * 0.5
                marPosition.x = proxy.size.width * 0.5
            }
        }
    }
}


//import SwiftUI
////#-learning-task(conditionalCircle)
//
//struct ConditionalCircle: View {
//    @State var isOn = false
//    
//    var body: some View {
//        VStack {
//            /*#-code-walkthrough(conditionalCircle.circleView)*/
//            Circle()
//                .frame(maxHeight: 200)
//            /*#-code-walkthrough(conditionalCircle.foregroundColor)*/
//                .foregroundColor(/*#-code-walkthrough(conditionalCircle.ternary)*/ isOn ? .purple : .mint /*#-code-walkthrough(conditionalCircle.ternary)*/)
//            /*#-code-walkthrough(conditionalCircle.foregroundColor)*/
//            /*#-code-walkthrough(conditionalCircle.circleView)*/
//                .shadow(color: isOn ? .indigo : .orange, radius: 20)
//            
//                .scaleEffect(isOn ? 1 : 0.75)
//                .animation(.spring(), value: isOn)
//            
//            
//            Button("Press Me") {
//                isOn.toggle()
//            }
//        }
//    }
//}
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConditionalCircle().assess()
//    }
//}
