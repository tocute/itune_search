//
//  MusicPlayer.swift
//  itune
//
//  Created by Bill Chang on 2022/6/3.
//

import Foundation
import AVFoundation



class MusicPlayer {
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    var musicURL: URL?
    var isPlaying: Bool = false
    
    func playSong(musicURL: URL) {
        do {
            if self.musicURL == musicURL {
                if isPlaying {
                    player?.pause()
                    isPlaying = false
                } else {
                    player?.play()
                    isPlaying = true
                }
            } else {
                self.musicURL = musicURL
                let playerItem:AVPlayerItem = AVPlayerItem(url: musicURL)
                player = AVPlayer(playerItem: playerItem)
                try AVAudioSession.sharedInstance().setCategory(.playback)
                player?.play()
                isPlaying = true
            }
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}





