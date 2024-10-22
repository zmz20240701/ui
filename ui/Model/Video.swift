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
	
		// 自定义解码方法
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decodeIfPresent(UUID.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		url = try container.decode(String.self, forKey: .url)
		duration = try container.decode(TimeInterval.self, forKey: .duration)
		transcript = try container.decodeIfPresent([Transcript].self, forKey: .transcript)
		
			// 为缺失的字段提供默认值
		isPlaying = try container.decodeIfPresent(Bool.self, forKey: .isPlaying) ?? false
		isDownloading = try container.decodeIfPresent(Bool.self, forKey: .isDownloading) ?? false
		downloadProgress = try container.decodeIfPresent(Double.self, forKey: .downloadProgress) ?? 0
		isDownloaded = try container.decodeIfPresent(Bool.self, forKey: .isDownloaded) ?? false
	}
}
