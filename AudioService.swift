//
//  AudioService.swift
//  Heroes
//
//  Created by user on 18/04/23.
//

import Foundation
import AVFoundation

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
        let sound = "song1"
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
