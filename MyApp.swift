import SwiftUI
import AVFoundation

@main
struct MyApp: App {
    
    @StateObject var audioService: AudioService = AudioService()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
                    .environmentObject(audioService)
                    .onAppear {
                        
                    }
            }
        }
    }
}

class AudioService: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?
    
    @Published var soundOn = true {
        didSet { // property observer
            if soundOn {
                audioPlayer?.play()
            } else {
                audioPlayer?.pause()
            }
        }
    }
    
    init() {
        let sound = "alemdohorizonterock3"
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
            do {
                let url = URL(fileURLWithPath: path)
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer?.numberOfLoops = -1 // Reproduz em loop infinito
                self.audioPlayer?.play()
            } catch {
                print("Erro ao carregar o som: \(error.localizedDescription)")
            }
        }
    }
    
}
