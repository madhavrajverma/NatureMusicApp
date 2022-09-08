//
//  AudioPlayerViewModek.swift
//  NatureSounds
//
//  Created by Lakshya  Verma on 09/09/22.
//

import Foundation
import AVFoundation
import UIKit

enum AudioStatus {
    case stopped,playing,pause,resume
}

class AudioPlayerViewModel : NSObject,ObservableObject {
    
    let musicDownloadManager = MusicDownloadManger.instance
    
    var timer = Timer()
    
    @Published var musicData = Data()
    @Published var status: AudioStatus = .stopped
    
    @Published var musicRunningTime: TimeInterval = 0.0
    @Published var progressBarValue : Double = 0.0
    @Published var songDuration : TimeInterval = 0.0
    
    @Published var isSongDownloadCompleted = false
    
    var audioPlayer: AVAudioPlayer?
    
    
    @Published var songList:[Song] = []
    @Published var currentSong:Song?
    @Published var category:String?
    
    var currentIndex  = 0
    
    

    @Published var isShowPlayer = false
    
//MARK: - Timer in Background
    override init() {
        
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func pauseWhenBackground(noti: Notification) {
        self.timer.invalidate()
        let shared = UserDefaults.standard
        shared.set(Date(), forKey: "savedTime")
    }
    
    @objc func willEnterForeground(noti: Notification) {
        if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
            let timeInterval = Date() - savedDate
            self.musicRunningTime += timeInterval
            start()

        }
    }
    
    func removeSavedDate() {
           if (UserDefaults.standard.object(forKey: "savedTime") as? Date) != nil {
               UserDefaults.standard.removeObject(forKey: "savedTime")
           }
       }
    
     func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
           let calendar = Calendar.current
           let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
           return(components.hour!, components.minute!, components.second!)
        }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            self.musicRunningTime += 1
            self.progressBarValue = self.musicRunningTime / self.songDuration
            
            if self.musicRunningTime >= self.songDuration {
                self.stop()
            }
        }
    }
    
    func reset() {
        stopPlayback()
        status = .stopped
        musicData = Data()
        musicRunningTime = 0
        progressBarValue = 0
        songDuration = 0
        removeSavedDate()
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func stop() {
        timer.invalidate()
        musicRunningTime = 0
        progressBarValue = 0
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        status = .stopped
        stop()
        
    }
    
//MARK: - Next Song & Previou Song
    func nextSong() {
        if currentIndex < songList.count - 1 {
            currentIndex +=  1
            currentSong = songList[currentIndex]
            playMusicDataFromURL()
        }
        
    }
    
    func prevSong() {
        if currentIndex > 0{
            currentIndex -=  1
            currentSong = songList[currentIndex]
            playMusicDataFromURL()
        }
        
    }
    
    
    func updateSongList(songs:[Song]) {
        self.songList = songs
    }
    
    
//MARK: - Music Methods
    func playMusicDataFromURL() {
        
        reset()
        
        guard let songUrl = self.currentSong?.url else {
            return
        }
        musicData = Data()
        self.isSongDownloadCompleted = false
        musicDownloadManager.fetchSongAtUrl(songUrl) { results in
            switch results {
            case .success(let data) :
                self.musicData = data
                self.isSongDownloadCompleted = true
                self.play(musicData: data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func play(musicData:Data) {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
            //            try audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
            
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
    
    // new functions
    func ShowPlayer() {
        if self.currentSong != nil {
            self.isShowPlayer = true
        }
    }
}


extension AudioPlayerViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        status = .stopped
        nextSong()
    }
}
