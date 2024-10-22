//
//  UploadVideo.swift
//  ui
//
//  Created by 赵康 on 2024/10/21.
//

import Foundation

class AudioService {
	@MainActor
	func fetchAudioFiles(
		completion: @escaping @Sendable (Result<[AudioFile], Error>) -> Void
	) {
		guard let url = URL(string: "http://localhost:8080/audio") else {
			completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
			}
			
			guard let data = data else {
				completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
				return
			}
			
			do {
				let audioFiles = try JSONDecoder().decode([AudioFile].self, from: data)
				completion(.success(audioFiles))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}
}
