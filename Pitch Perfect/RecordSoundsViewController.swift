//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jefferson Bonnaire on 15/08/2015.
//  Copyright © 2015 Jefferson Bonnaire. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordStatusLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        recordStatusLabel.text = "Tap to record"
        recordButton.enabled = true
        stopButton.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordStatusLabel.text = "Recording"
        stopButton.hidden = false
        recordButton.enabled = false
        let dirPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath: NSURL = NSURL.fileURLWithPathComponents(pathArray)!
        println(filePath)

        let recordSettings = [  AVEncoderAudioQualityKey:   AVAudioQuality.Min.rawValue,
                                AVEncoderBitRateKey:        16,
                                AVNumberOfChannelsKey:      2,
                                AVSampleRateKey:            44100.0]
        
        let session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        audioRecorder = AVAudioRecorder(URL: filePath, settings: recordSettings as! [String : AnyObject], error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording wasn't successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsViewController: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsViewController.receivedAudio = data
        }
    }

    @IBAction func stopAudio(sender: AnyObject) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}