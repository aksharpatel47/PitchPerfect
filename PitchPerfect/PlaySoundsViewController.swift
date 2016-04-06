//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Akshar Patel on 05/04/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit
import AVFoundation

final class PlaySoundsViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var snailButton: UIButton!
  @IBOutlet weak var rabbitButton: UIButton!
  @IBOutlet weak var chipmunkButton: UIButton!
  @IBOutlet weak var darthvaderButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var audioDurationLabel: UILabel!
  
  // MARK: Properties
  var recordedAudioURL: NSURL!
  var audioFile: AVAudioFile!
  var audioEngine: AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: NSTimer!
  
  enum ButtonType: Int {
    case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb
  }
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAudio()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    stopAudio()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    configureUI(PlayingState.NotPlaying)
    do {
      let audioPlayer = try AVAudioPlayer(contentsOfURL: recordedAudioURL)
      let hours = Int(audioPlayer.duration / 3600)
      let minutes = Int(audioPlayer.duration / 60) - (hours * 60)
      let seconds = Int(audioPlayer.duration % 60)
      audioDurationLabel.text = "Length of Audio: \(hours)h:\(minutes)m:\(seconds)s"
    } catch {
      print(error)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Actions
  @IBAction func playSoundForButton(sender: UIButton) {
    switch ButtonType(rawValue: sender.tag)! {
    case .Slow:
      playSound(rate: 0.5)
    case .Fast:
      playSound(rate: 1.5)
    case .Chipmunk:
      playSound(pitch: 1000)
    case .Vader:
      playSound(pitch: -1000)
    case .Echo:
      playSound(echo: true)
    case .Reverb:
      playSound(reverb: true)
    }
    
    configureUI(PlayingState.Playing)
  }
  
  @IBAction func stopButtonPressed(sender: UIButton) {
    print("Stop Button Pressed")
    stopAudio()
  }
}
