	//
	//  Item.swift
	//  ui
	//
	//  Created by 赵康 on 2024/10/21.
	//

import Foundation

struct AudioFile: Codable, Identifiable {
	var id: UUID?
	var title: String
	var url: String
	var duration: TimeInterval
	var transcript: [Transcript]? = nil
	var isPlaying: Bool = false
	var isDownloading: Bool = false
	var downloadProgress: Double = 0
	var isDownloaded: Bool = false
}
