//
//  MusicPlayerViewModel.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 04/09/22.
//

import Foundation
import AVFoundation

enum AudioStatus {
    case stopped,playing,pause,resume
}

class MusicPlayerViewModel : NSObject,ObservableObject {
    
    
    var timer = Timer()
    
    @Published var status: AudioStatus = .stopped
    
    @Published var musicRunningTime: TimeInterval = 0.0
    @Published var progressBarValue : Double = 0.0
    @Published var songDuration : TimeInterval = 0.0
    
    var audioPlayer: AVAudioPlayer?
    
//    @Published var currentTime: TimeInterval = 0.0
    
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            self.musicRunningTime += 1
            self.progressBarValue = self.musicRunningTime / self.songDuration
            
            if self.musicRunningTime >= self.songDuration {
                self.stop()
            }
            
        }
       }
    
    func pause() {
           timer.invalidate()
       }
    
    func stop() {
        timer.invalidate()
        musicRunningTime = 0
        progressBarValue = 0
    }
    
    func play(musicData:Data) {
        
        let audioSession = AVAudioSession.sharedInstance()
            do {
                // Set the audio session category, mode, and options.
                try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
            } catch {
                print("Failed to set audio session category.")
            }
      do {
        audioPlayer = try AVAudioPlayer(data:musicData)
      } catch {
        print(error.localizedDescription)
      }
        
      guard let audioPlayer = audioPlayer else { return }
        
      audioPlayer.delegate = self
      if audioPlayer.duration > 0.0 {
        audioPlayer.play()
        status = .playing
        self.songDuration = audioPlayer.duration
          self.musicRunningTime = 0
          self.progressBarValue = 0
        start()
      }
    }
    
    func pauseMusic() {
        
        guard let audioPlayer = audioPlayer else { return }
        
        audioPlayer.pause()
        status = .pause
        pause()
    }
    
    func resumeMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.play(atTime:audioPlayer.deviceCurrentTime)
        status = .playing
        start()
    }

    func stopPlayback() {
      audioPlayer?.stop()
      status = .stopped
      stop()
    }
}


extension MusicPlayerViewModel: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    status = .stopped
  }
}