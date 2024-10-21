import SwiftUI
import PhotosUI

struct ContentView: View {
	@State private var selectedVideo: PhotosPickerItem? = nil
	@State private var uploadProgress: Double = 0.0
	@State private var isUploading: Bool = false
	
	var body: some View {
		VStack {
			PhotosPicker(selection: $selectedVideo, matching: .videos) {
				Text("选择视频")
			}
			.onChange(of: selectedVideo) { newItem in
				Task {
					if let videoItem = newItem {
						await uploadVideo(item: videoItem)
					}
				}
			}
			
			if isUploading {
				ProgressView(value: uploadProgress, total: 1.0)
					.padding()
			}
		}
	}
	
		// 上传视频到服务器
	func uploadVideo(item: PhotosPickerItem) async {
		do {
				// 获取视频数据
			guard let videoData = try await item.loadTransferable(type: Data.self) else { return }
			
				// 上传视频到 Vapor 服务器
			let uploadURL = URL(string: "http://localhost:8080/upload")!
			var request = URLRequest(url: uploadURL)
			request.httpMethod = "POST"
			
				// 使用 multipart 形式上传文件
			let boundary = UUID().uuidString
			request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
			
			let body = createMultipartBody(data: videoData, boundary: boundary, fileName: "video.mp4")
			let (responseData, response) = try await URLSession.shared.upload(for: request, from: body)
			
			if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
				print("上传成功")
			} else {
				print("上传失败，响应码: \(response)")
			}
			
		} catch {
			print("上传视频时出错: \(error.localizedDescription)")
		}
	}
	
		// 创建 multipart/form-data 请求体
	func createMultipartBody(data: Data, boundary: String, fileName: String) -> Data {
		var body = Data()
		let boundaryPrefix = "--\(boundary)\r\n"
		body.append(boundaryPrefix.data(using: .utf8)!)
		body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
		body.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
		body.append(data)
		body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
		return body
	}
}

#Preview {
	ContentView()
}
