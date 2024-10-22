//
//  AudioPlayerViewModel.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//
import Foundation
import AVFoundation

@MainActor
class AudioPlayerViewModel: ObservableObject {
	@Published var audioFiles: [AudioFile] = []
	@Published var currentAudioFile: AudioFile? // 当前正在播放的音频文件
	 var player: AVPlayer?
	
	private var audioService = AudioService()
	
		// 加载音频文件
	func loadAudioFiles() {
		audioService.fetchAudioFiles { [weak self] result in
			DispatchQueue.main.async {
				switch result {
					case .success(let audioFiles):
						self?.audioFiles = audioFiles
					case .failure(let error):
						print("Error loading audio files: \(error)")
				}
			}
		}
	}
	
		// 播放音频
	func playAudio(file: AudioFile) {
		player = AVPlayer(url: URL(string: file.url)!)
		player?.play()
		currentAudioFile = file
	}
	
		// 跳转到指定时间点
	func seekToTime(time: TimeInterval) {
		let cmTime = CMTime(seconds: time, preferredTimescale: 1)
		player?.seek(to: cmTime)
	}
}
