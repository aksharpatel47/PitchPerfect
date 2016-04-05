//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Akshar Patel on 05/04/16.
//  Copyright © 2016 Akshar Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var stopRecordingButton: UIButton!
  @IBOutlet weak var recordButton: UIButton!
  
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
  
  @IBAction func recordAudio(sender: AnyObject) {
    recordingLabel.text = "Recording in Progress..."
    stopRecordingButton.enabled = true
    recordButton.enabled = false
  }
  
  @IBAction func stopRecording(sender: AnyObject) {
    recordingLabel.text = "Tap to Record"
    stopRecordingButton.enabled = false
    recordButton.enabled = true
  }
}

