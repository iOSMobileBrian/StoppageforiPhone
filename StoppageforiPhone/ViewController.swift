//
//  ViewController.swift
//  Stoppage
//
//  Created by Brian Surface on 8/3/15.
//  Copyright (c) 2015 Adamantium Mettle. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    // set up variables
    
    var timer: Timer?
    
    var countDownTime: TimeInterval = 0
    
    var warningSignalPlayer: AVAudioPlayer!
    
    var countDownOverPlayer: AVAudioPlayer!
    
    var audioPath = Bundle.main.path(forResource: "Warning Siren", ofType: "mp3")
    
    var audioPath1 = Bundle.main.path(forResource: "Air Horn", ofType: "mp3")
    
    var error:NSError?
    
    
    
    
    // set up IBOutlets and IBActions
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var pauseResetLabel: UIButton!
    
    @IBAction func startButtonPressed(sender: UIButton) {
        
        if timer == nil && countDownTime > 0.0 {
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateTime), userInfo: nil, repeats: true)
            
            pauseResetLabel.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
            
            
        }

        
        
    }
    
    @IBAction func pauseButtonPressed(sender: AnyObject) {
        
        if timer != nil{
            timer!.invalidate()
            timer = nil
            
            pauseResetLabel.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
        } else {
            
            countDownTime = 0.0
            timeLabel.text = "00:00.0"
            pauseResetLabel.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
        }

        
        
    }
    
    
    
      
    @IBAction func fiveMinutes(sender: UIButton) {
        
     countDownTime =  countDownTime + 300
        
        timeLabel.text = dateStringFromTimeInterval(timeInterval: countDownTime)
        
        if timer == nil{
            
            pauseResetLabel.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
        }


        
        
    }
    
    
    @IBAction func oneMinute(sender: AnyObject) {
        
      countDownTime =  countDownTime + 60
        
        timeLabel.text = dateStringFromTimeInterval(timeInterval: countDownTime)
        
        if timer == nil{
            
            pauseResetLabel.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
        }


    }
    
    
    
    @IBAction func thirtySeconds(sender: UIButton) {
        
     countDownTime =   countDownTime + 30
        
        timeLabel.text = dateStringFromTimeInterval(timeInterval: countDownTime)
        
        if timer == nil{
            
            pauseResetLabel.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
        }

        
    }
    
    
    
    @IBAction func timeOutWarning(sender: UIButton) {
        
        
        error = nil
        
        do {
            warningSignalPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        } catch let error1 as NSError {
            error = error1
            warningSignalPlayer = nil
        }
        
        warningSignalPlayer.play()
        
        
        
        
    }
    
    
    @objc func updateTime(){
        
        
        if countDownTime > 0.09 {
            
            countDownTime = countDownTime - 0.1
            
            print(countDownTime)
            timeLabel.text = dateStringFromTimeInterval(timeInterval: countDownTime)
            
        }else{
            countDownTime = 0.0
            timer!.invalidate()
            countDownTime = 0.0
            timeLabel.text = "00:00.0"
            
            
            countDownOverPlayer = try? AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath1!) as URL)
            
            countDownOverPlayer.play()
           
            
            timer = nil
        }
    }
    
    
    func dateStringFromTimeInterval(timeInterval: TimeInterval) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss.S"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        
        
        return dateFormatter.string(from: date as Date)
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

