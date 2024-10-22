//
//  ContentView.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//
import SwiftUI

	// ContentView 展示音频播放器和句子列表
struct ContentView: View {
	var body: some View {
			// 创建示例的 AudioFile 和对应的 Transcript
		let transcript = [
			Transcript(id: UUID(), sentence: "First sentence", startTime: 0.0),
			Transcript(id: UUID(), sentence: "Second sentence", startTime: 10.0),
			Transcript(id: UUID(), sentence: "Third sentence", startTime: 20.0)
		]
		
		let audioFile = AudioFile(id: UUID(), title: "Sample Audio", url: "http://127.0.0.1", duration: 180.0, transcript: transcript)
		
			// 使用 AudioPlayerView 展示音频播放器和句子列表
		AudioPlayerView(audioFile: audioFile)
	}
}
#Preview {
	ContentView()
}
