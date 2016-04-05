//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Akshar Patel on 05/04/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var stopRecordingButton: UIButton!
  @IBOutlet weak var recordButton: UIButton!
  
  // MARK: Properties
  var audioRecorder: AVAudioRecorder!
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    stopRecordingButton.enabled = false
  }
  
  // MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "stopRecording" {
      let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
      playSoundsVC.recordedAudioURL = sender as! NSURL
    }
  }
  
  // MARK: Recording Functions
  @IBAction func recordAudio(sender: AnyObject) {
    recordingLabel.text = "Recording in Progress..."
    stopRecordingButton.enabled = true
    recordButton.enabled = false
    
    // Setting up Audio Recorder
    // Getting the path where the audio will be stored
    guard let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first else {
      return
    }
    
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let path = NSURL.fileURLWithPathComponents(pathArray)
    
    guard path != nil else {
      return
    }
    
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
      try audioRecorder = AVAudioRecorder(URL: path!, settings: [:])
    } catch {
      print(error)
      return
    }
    
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecording(sender: AnyObject) {
    recordingLabel.text = "Tap to Record"
    stopRecordingButton.enabled = false
    recordButton.enabled = true
    audioRecorder.stop()
  }
}

// MARK: - AVAudioRecorderDelegate
extension RecordSoundsViewController: AVAudioRecorderDelegate {
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegueWithIdentifier("stopRecording", sender: recorder.url)
    } else {
      print("Saving of Audio Recording failed.")
    }
  }
}

