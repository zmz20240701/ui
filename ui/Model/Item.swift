	//
	//  Item.swift
	//  ui
	//
	//  Created by 赵康 on 2024/10/21.
	//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
	@Published  var selectedPhotos: PhotosPickerItem? {
		didSet { Task { try await uploadVideo() } }
	}
	func uploadVideo() async throws {
		guard let item = selectedPhotos else { return }
		guard let videoData = try await item.loadTransferable(type: Data.self) else { return }
		print("videoData: \(videoData)")
	}
}

