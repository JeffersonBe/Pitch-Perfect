//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jefferson Bonnaire on 15/08/2015.
//  Copyright © 2015 Jefferson Bonnaire. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        //        let currentDateTime = NSDate()
        //        let formatter = NSDateFormatter()
        //        formatter.dateFormat = "ddMMyyyy-HHmmss"
        //        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let recordingName = "test"+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print(error.description)
        }
        
        do {
            try audioRecorder = AVAudioRecorder(URL: filePath!, settings: recordSettings as! [String : AnyObject])
        } catch let error as NSError {
            print(error.description)
        }
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        //Inside func stopAudio(sender: UIButton)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch let error as NSError {
            print(error.description)
        }
    }

    @IBAction func stopAudio(sender: AnyObject) {
        recordingInProgress.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setActive(false)
        } catch let error as NSError {
            print(error.description)
        }
    }
}