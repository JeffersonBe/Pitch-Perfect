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
    @IBOutlet weak var stopAudioButton: UIButton!

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = false
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopAudioButton.hidden = true
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playAudioQuickly(sender: AnyObject) {
        playAudioWithVariableSpeed(2.0)
    }

    @IBAction func playAudioSlowly(sender: AnyObject?) {
        playAudioWithVariableSpeed(0.5)
    }

    @IBAction func playAudioChipmunkLike(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playAudioDarkVadorLike(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }

    func playAudioWithVariablePitch(pitch: Float){
        stopAudioButton.hidden = false
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
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    func playAudioWithVariableSpeed(Speed: Float) {
        stopAudioButton.hidden = false
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = Speed;
        audioPlayer.play()
    }
}
