//
//  ViewController.swift
//  Module 4 Timer
//
//  Created by Jeff Kohl on 6/6/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = Timer()
    var timer2 = Timer()
    var countdownSelected: Int?
    var player: AVAudioPlayer!

    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var pickerWheel: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBAction func pickerWheel_action(_ sender: UIDatePicker) { countdownSelected = Int(pickerWheel.countDownDuration)
    }
    
    @IBAction func startTimerButton(_ sender: UIButton) {
        if timerButton.currentTitle == "Stop Music" {
            player.stop()
            timerButton.setTitle("Start Time", for: .normal)
        } else{
            timer2.invalidate()
            
            timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.countDown) , userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            timeRemaining.text = ""
            timerButton.setTitle("Start Timer", for: .normal)
        
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM YYYY HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            timeLabel.text = dateFormatter.string(from: Date())
                    
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.ticker) , userInfo: nil, repeats: true)
            
            pickerWheel.datePickerMode = UIDatePicker.Mode.countDownTimer
            
            pickerWheel.preferredDatePickerStyle = UIDatePickerStyle.wheels
            
            var dateFormatter_background = DateFormatter()
            dateFormatter_background.dateFormat = "a"
            dateFormatter_background.locale = Locale(identifier: "en_US_POSIX")
            if dateFormatter_background.string(from: Date()) == "PM" {
                background.isHidden = true
            }
            else {
                background.isHidden = false
            }
            
        }
        
        
            
    @objc func ticker() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM YYYY HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        var dateFormatter_countdown = DateFormatter()
        dateFormatter_countdown.dateFormat = "a"
        dateFormatter_countdown.locale = Locale(identifier: "en_US_POSIX")
        
        timeLabel.text = dateFormatter.string(from: Date())
        
        if dateFormatter_countdown.string(from: Date()) == "PM" {
            background.isHidden = true
        }
        else {
            background.isHidden = false
        }
    }


    
    @objc func countDown() {
                if countdownSelected! >= 0 {
                    
                    var (h, m, s) = secondsConversion(countdownSelected!)
                    
                    timeRemaining.text = "Time Remaining \(h):\(m):\(s)"
                    countdownSelected! -= 1
                } else {
                    timerButton.setTitle("Stop Music", for: .normal)
                    timer2.invalidate()
                    
                   playSound()
                }
    }
    
    func secondsConversion(_ seconds: Int) -> (String, String, String) {
        var hr = seconds / 3600
        var min = (seconds % 3600) / 60
        var sec = (seconds % 3600) % 60
        
        var hour: String
        var minute: String
        var second: String
        
        if hr < 10 {
            hour = "0\(hr)"
        } else {
            hour = "\(hr)"
        }
        
        if min < 10 {
            minute = "0\(min)"
        } else {
            minute = "\(min)"
        }
        
        if sec < 10 {
            second = "0\(sec)"
        } else {
            second = "\(sec)"
        }
        
        return (hour, minute, second)
    }
    
    func playSound() {
           let url = Bundle.main.url(forResource: "Recording", withExtension: "m4a")
           player = try! AVAudioPlayer(contentsOf: url!)
           player.play()
        }
}

