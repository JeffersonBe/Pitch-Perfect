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
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint: "wav")
            try audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl)
        } catch let error as NSError {
            print(error)
        }
        audioEngine = AVAudioEngine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    @IBAction func playAudioQuickly(sender: AnyObject) {
        audioPlayer.enableRate = true
        audioPlayer.currentTime = audioPlayer.currentTime
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }

    @IBAction func playAudioSlowly(sender: AnyObject?) {
        audioPlayer.enableRate = true
        audioPlayer.currentTime = audioPlayer.currentTime
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    @IBAction func playAudioChipmunkLike(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playAudioDarkVadorLike(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)

        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)

        do{
            try audioEngine.start()
        } catch let error as NSError {
            print(error)
        }
        
        audioPlayerNode.play()
    }
}
