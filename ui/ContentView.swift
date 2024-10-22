//
//  ContentView.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//
import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = AudioPlayerViewModel()
	
	var body: some View {
		NavigationView {
			List(viewModel.audioFiles) { audioFile in
				NavigationLink(destination: AudioPlayerView(viewModel: viewModel, audioFile: audioFile)) {
					Text(audioFile.title)
				}
			}
			.onAppear {
					// 当视图出现时加载音频文件数据
				viewModel.loadAudioFiles()
			}
			.navigationTitle("Audio Files")
		}
	}
}

#Preview {
	ContentView()
}
