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
            }
        }
    }
}
