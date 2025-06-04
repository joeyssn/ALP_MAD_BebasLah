//
//  SoundManager.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 05/06/25.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var soundEffectPlayer: AVAudioPlayer?
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    func playImportedSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
                soundEffectPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found in bundle: \(soundName).mp3")
        }
    }

    func pause() {
        soundEffectPlayer?.pause()
    }

    func resume() {
        soundEffectPlayer?.play()
    }

    func stop() {
        soundEffectPlayer?.stop()
        soundEffectPlayer = nil
    }

    var isPlaying: Bool {
        soundEffectPlayer?.isPlaying ?? false
    }
}

