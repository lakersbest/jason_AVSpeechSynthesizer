//
//  ViewController.swift
//  0811_Outlet&Action
//
//  Created by JaBa CHIA on 2020/8/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var MesseageTextField: UITextField!
    @IBOutlet weak var speakButton: UIButton!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var speedSlider: UISlider!
    
    @IBOutlet weak var speedValueLable: UILabel!
    
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var pitchValueLable: UILabel!
    
    let speakMesseage = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 點空白處收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }

//    // 輸入完return收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true
    }
    
    // 按下按鈕說話
    @IBAction func speakButtonClick(_ sender: Any) {
        // 按下按鈕會收鍵盤
        view.endEditing(true)
        
        let messeage = AVSpeechUtterance(string: MesseageTextField.text!)
        
        messeage.rate = speedSlider.value
        messeage.pitchMultiplier = pitchSlider.value
        messeage.volume = volumeSlider.value
        
        // 語言SegmentedControl
        if languageSegmentedControl.selectedSegmentIndex == 0{
            messeage.voice = AVSpeechSynthesisVoice(language: "th-TH")
        }
        else if languageSegmentedControl.selectedSegmentIndex == 1{
            messeage.voice = AVSpeechSynthesisVoice(language: "zh-HK")
        }
        else if languageSegmentedControl.selectedSegmentIndex == 2{
            messeage.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        }
        
        if MesseageTextField.text != nil{
            // 播放（按下去圖案變成暫停）
            if !speakMesseage.isSpeaking, !speakMesseage.isPaused, speakButton.titleLabel!.text == "  按下去"{
                    speakMesseage.speak(messeage)
                    speakButton.setTitle(" 等我一下喔", for: UIControl.State.normal)
                    speakButton.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
            }
            // 講話暫停（按下去圖案變成播放）
            else if speakMesseage.isSpeaking == true, speakButton.titleLabel!.text == " 等我一下喔"{
                    speakMesseage.pauseSpeaking(at: AVSpeechBoundary.immediate)
                    speakButton.setTitle("  按下去", for: UIControl.State.normal)
                    speakButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
            }
            // 暫停完繼續講（按下去圖案變成暫停）
            else if speakMesseage.isPaused == true, speakButton.titleLabel!.text == "  按下去"{
                    speakMesseage.continueSpeaking()
                    speakButton.setTitle(" 等我一下喔", for: UIControl.State.normal)
                    speakButton.setImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
            }
            else{
                speakButton.setTitle("  按下去", for: UIControl.State.normal)
                speakButton.setImage(UIImage(systemName: "play.fill"), for: UIControl.State.normal)
            }
        }
    }
    
    // 滑動slider時顯示數值
    @IBAction func speedSliderChange(_ sender: Any) {
        speedValueLable.text = String(format: "%.1f", speedSlider.value)
    }
    @IBAction func pitchSliderChange(_ sender: Any) {
        pitchValueLable.text = String(format: "%.1f", pitchSlider.value)
    }
    
    // 隨機按鈕
    @IBAction func speedRandomClick(_ sender: Any) {
        speedSlider.value = Float.random(in: 0.1...3)
        speedValueLable.text = String(format: "%.1f", speedSlider.value)
    }
    
    @IBAction func pitchRandomClick(_ sender: Any) {
        pitchSlider.value = Float.random(in: 0.1...3)
        pitchValueLable.text = String(format: "%.1f", pitchSlider.value)
    }
    
    @IBAction func speedpitchRandomClick(_ sender: Any) {
        speedSlider.value = Float.random(in: 0.1...3)
        pitchSlider.value = Float.random(in: 0.1...3)
        speedValueLable.text = String(format: "%.1f", speedSlider.value)
        pitchValueLable.text = String(format: "%.1f", pitchSlider.value)
    }
    
    
}

