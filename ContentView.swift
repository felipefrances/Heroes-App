import SwiftUI

// Desafio:
// 1. Fazer um botao que muda a imagem de militar_padrao pra militar_continencia
// 2. Em vez de mudar o state com a action do botao, modificar quando uma image é arrastada pra cima da outra. 
//     2.1 Fazer uma imagem ser "arrastavel" (DragGesture)
//     2.2 Detectar se a imagem está na regiao desejada pra mudar o state

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
    
    @State var aeroPosition: CGPoint = .zero
    @State var aeroSizeProportion: Double = 0.18
    
    @State var ebPosition: CGPoint = .zero
    @State var ebtSizeProportion: Double = 0.18
    
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
                VStack {
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
                        .frame(width: proxy.size.width * 0.18, height: proxy.size.height * 0.18)
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
                        .frame(width: proxy.size.width * 0.18, height: proxy.size.height * 0.18)
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
            .onChange(of: vetPosition, perform: { newValue in
                let thresholdX = proxy.size.width * 0.4
                let thresholdY = proxy.size.height * 0.4
                
                print("\nx", newValue.x)
                print("thresholdX", thresholdX)
                
                print("\ny", newValue.y)
                print("thresholdY", thresholdY)
                
                if newValue.x < thresholdX, newValue.y > thresholdY {
                    continencia = true
                    vetSizeProportion = milSizeProportion
                } else {
                    vetSizeProportion = 0.18
                    continencia = false
                }
            })
//            Replicando nos 3 bonecos restantes\
            
            .onChange(of: aeroPosition, perform: { newValue in
                let thresholdX = proxy.size.width * 0.4
                let thresholdY = proxy.size.height * 0.4
                
                print("\nx", newValue.x)
                print("thresholdX", thresholdX)
                
                print("\ny", newValue.y)
                print("thresholdY", thresholdY)
                
                if newValue.x < thresholdX, newValue.y > thresholdY {
                    continencia = true
                    vetSizeProportion = milSizeProportion
                } else {
                    vetSizeProportion = 0.18
                    continencia = false
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
