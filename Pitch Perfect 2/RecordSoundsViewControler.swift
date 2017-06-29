//
//  RecordSoundsViewControler.swift
//  Pitch Perfect 2 Class Code 
//
//  Created by Andres Gonzalez on 6/15/17.
//  Copyright © 2017 Andres Gonzalez. All rights reserved.
//  Removed upper case labels to lower case 

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate{

    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopRecording: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecording.isEnabled=false
    }
//  record audio
    
    @IBAction func recordAudio(_ sender: Any) {
        recordLabel.text = "Recording in Progress"
        stopRecording.isEnabled = true
        recordButton.isEnabled = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    
}
    // stop recording 

   @IBAction func stopRecording(_ sender: Any) {
    recordButton.isEnabled = true
    stopRecording.isEnabled = false
    recordLabel.text = "Tap to Record"

    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    
     if flag{
            performSegue(withIdentifier: "stopRecording", sender:audioRecorder.url)
        } else {
        }
    }
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "stopRecording" {
    let playSoundsVC = segue.destination as! PlaySoundsViewController
    let recordedAudioURL = sender as! URL
    playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}
