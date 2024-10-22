//
//  AudioViewModel.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//

import Foundation

class AudioViewModel: ObservableObject {
	@Published var audioFiles: [AudioFile] = []
	
	private let audioService = AudioService()
	
	func fetchAudioFiles() async {
		do {
			audioFiles = try await audioService.fetchAudioFiels()
		} catch {
			print(error)
		}
	}
}
