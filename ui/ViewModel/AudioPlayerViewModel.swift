//
//  AudioPlayerViewModel.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//

import AVFoundation
import SwiftUI
class AudioPlayerViewModel: ObservableObject {
	@Published var audioFile: AudioFile
	var player: AVPlayer?
	
	init(audioFile: AudioFile) {
		self.audioFile = audioFile
	}
	
	private func setupPlayer() {
		guard let url = URL(string: audioFile.url) else { return }
		player = AVPlayer(url: url)
	}
	func play() {
		if player == nil {
			setupPlayer()
		}
		player?.play()
	}
	func seek(to time: TimeInterval) {
		player?.seek(to: CMTime(seconds: time, preferredTimescale: 1))
		
	}
	func seekToTime(time: TimeInterval) {
			// 将音频播放器跳转到指定的时间点
		let targetTime = CMTime(seconds: time, preferredTimescale: 600)
		player?.seek(to: targetTime)
		player?.play() // 跳转到时间点后开始播放
	}
}
