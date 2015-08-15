//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Jefferson Bonnaire on 15/08/2015.
//  Copyright © 2015 Jefferson Bonnaire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopRecording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        stopRecording.hidden = false
    }

    @IBAction func stopAudio(sender: AnyObject) {
        recordingInProgress.hidden = true
        stopRecording.hidden = true
    }
}

