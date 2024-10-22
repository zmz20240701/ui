//
//  UploadVideo.swift
//  ui
//
//  Created by 赵康 on 2024/10/21.
//

import Foundation

class AudioService {
	private let url = "http://localhost:8080/index"
	
	func fetchAudioFiels() async throws -> [AudioFile] {
		let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
		let audioFiles = try JSONDecoder().decode([AudioFile].self, from: data)
		return audioFiles
	}
}
