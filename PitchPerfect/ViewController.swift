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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func recordAudio(sender: AnyObject) {
    recordingLabel.text = "Recording in Progress..."
  }
  
  @IBAction func stopRecording(sender: AnyObject) {
    recordingLabel.text = "Tap to Record"
  }
}

