//
//  AudioPlayerView.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//

import SwiftUI

struct AudioPlayerView: View {
	@StateObject private var viewModel: AudioPlayerViewModel
	
	init(audioFile: AudioFile) {
		_viewModel = StateObject(wrappedValue: AudioPlayerViewModel(audioFile: audioFile))
	}
	
	var body: some View {
		VStack {
				// 播放/暂停按钮
			Button(action: {
				if viewModel.audioFile.isPlaying {
					viewModel.player?.pause()
					viewModel.audioFile.isPlaying = false
				} else {
					viewModel.play()
				}
			}) {
				Image(systemName: viewModel.audioFile.isPlaying ? "pause.circle" : "play.circle")
					.resizable()
					.frame(width: 50, height: 50)
					.padding()
			}
			
				// 显示音频文本
			TranscriptView(viewModel: viewModel)
		}
		.padding()
	}
}
#Preview {
	AudioPlayerView(
		audioFile: AudioFile(
			title: "Title",
			url: "https://example.com/audio.mp3",
			duration: 0.5, transcript: nil
		)
	)
}
