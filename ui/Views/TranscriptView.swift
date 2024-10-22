import SwiftUI

struct TranscriptView: View {
	@ObservedObject var viewModel: AudioPlayerViewModel
	
	var body: some View {
		VStack {
			Text(viewModel.audioFile.title)
				.font(.title)
				.padding()
			
			List(viewModel.audioFile.transcript ?? [], id: \.id) { transcript in
				Button(action: {
						// 点击句子，音频跳转到对应时间点
					viewModel.seekToTime(time: transcript.startTime)
				}) {
					HStack {
						Text(transcript.sentence)
						Spacer()
						Text(formatTime(transcript.startTime))
							.foregroundColor(.gray)
					}
				}
			}
		}
	}
	
		// 时间格式化函数
	private func formatTime(_ time: TimeInterval) -> String {
		let minutes = Int(time) / 60
		let seconds = Int(time) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}
