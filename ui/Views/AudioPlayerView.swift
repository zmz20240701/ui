//
//  AudioPlayerView.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//

import SwiftUI

struct AudioPlayerView: View {
	@StateObject var viewModel: AudioPlayerViewModel
	var audioFile: AudioFile
	
	var body: some View {
		VStack {
			Text(audioFile.title)
				.font(.title)
				.padding()
			
				// 播放按钮
			Button(action: {
				viewModel.playAudio(file: audioFile) // 播放音频
			}) {
				Text("播放")
					.padding()
					.background(Color.blue)
					.foregroundColor(.white)
					.cornerRadius(8)
			}
			
			List(audioFile.transcript ?? [], id: \.id) { transcript in
				Button(action: {
						// 点击句子，音频跳转到对应时间点
					viewModel.seekToTime(time: transcript.startTime)
				}) {
					HStack {
						Text(transcript.sentence)
						Spacer()
						Text(formatTime(transcript.startTime))
							.foregroundColor(.gray)
					}
				}
			}
		}
	}
	
	private func formatTime(_ time: TimeInterval) -> String {
		let minutes = Int(time) / 60
		let seconds = Int(time) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}
