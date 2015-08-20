//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jefferson Bonnaire on 17/08/2015.
//  Copyright © 2015 Jefferson Bonnaire. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var soundPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try soundPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint: "wav")
        } catch let error as NSError {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        soundPlayer.stop()
    }
    
    @IBAction func playAudioQuickly(sender: AnyObject) {
        soundPlayer.enableRate = true
        soundPlayer.currentTime = soundPlayer.currentTime
        soundPlayer.rate = 2.0
        soundPlayer.play()
    }

    @IBAction func playAudioSlowly(sender: AnyObject?) {
        soundPlayer.enableRate = true
        soundPlayer.currentTime = soundPlayer.currentTime
        soundPlayer.currentTime = 0.0
        soundPlayer.rate = 0.5
        soundPlayer.play()
    }
}
