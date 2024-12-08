//
//  RadioPlayer.swift
//  EasyMusicMac
//
//  Created by Platon on 08.12.2024.
//


import AVFoundation
import Combine

class RadioPlayer: ObservableObject {
    static let shared = RadioPlayer()

    private var player: AVPlayer?
    @Published var isPlaying: Bool = false
    @Published var trackTitle: String = "Unknown Track"

    func playStream(url: String) {
        guard let streamURL = URL(string: url) else { return }
        player = AVPlayer(url: streamURL)
        player?.play()
        isPlaying = true
    }

    func stop() {
        player?.pause()
        isPlaying = false
    }
}