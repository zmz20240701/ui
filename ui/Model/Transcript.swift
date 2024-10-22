//
//  Transcript.swift
//  ui
//
//  Created by 赵康 on 2024/10/22.
//

import Foundation

struct Transcript: Identifiable, Codable {
	var id: UUID?
	
	var sentence: String
	
	var startTime: TimeInterval
}
