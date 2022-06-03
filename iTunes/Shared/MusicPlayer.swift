//
//  MusicPlayer.swift
//  itune
//
//  Created by Bill Chang on 2022/6/3.
//

import Foundation
import AVFoundation

class MusicPlayer {
    private var player: AVPlayer?
    private var playerItem:AVPlayerItem?
    private var musicURL: URL?
    private var isPlaying: Bool = false
    
    private static var instance: MusicPlayer!
    
    /// A singleton instance of `ContentKeyManager`.
    public static var shared: MusicPlayer {
        if instance == nil {
            instance = MusicPlayer()
        }
        
        return instance
    }
    
    private init() {
    }
    
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
                // Playback cannot be stopped when device in silent mode
                try AVAudioSession.sharedInstance().setCategory(.playback)
                player?.play()
                isPlaying = true
            }
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}





