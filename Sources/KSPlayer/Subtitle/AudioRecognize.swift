//
//  AudioRecognize.swift
//  KSPlayer
//
//  Created by kintan on 2023/9/23.
//

import Foundation

public protocol AudioRecognize: SubtitleInfo {
    func append(frame: AudioFrame)
}

/// An `AudioRecognize` that also wants the audio as soon as it is read, ahead of playback:
/// up to `KSOptions.maxBufferDuration` for on-demand files, a few seconds for live streams.
/// `append(frame:)` keeps receiving the audio when it is rendered.
///
/// The look-ahead is a second decoder fed with the same packets, so it costs one more audio
/// decode and no extra network. Frames arrive in order on a background thread. After a seek
/// or an audio track change, `lookaheadDidFlush()` comes before the new frames.
public protocol AudioLookaheadRecognize: AudioRecognize {
    func appendLookahead(frame: AudioFrame)
    func lookaheadDidFlush()
}
