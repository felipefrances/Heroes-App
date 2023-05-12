import SwiftUI
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
}

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
