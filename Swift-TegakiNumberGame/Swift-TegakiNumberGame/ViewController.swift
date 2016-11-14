//
//  ViewController.swift
//  tegaki
//
//  Created by Yanase Yuji on 2016/11/03.
//  Copyright © 2016年 hikaruApp. All rights reserved.
//

// apple sample code address
// https://developer.apple.com/library/content/samplecode/MPSCNNHelloWorld/Listings/MPSCNNHelloWorld_SlimMPSCNN_swift.html

import UIKit
import MetalPerformanceShaders
import AVFoundation

class ViewController: UIViewController {
   
    // some properties used to control the app and store appropriate values
    // we will start with the simple 1 layer
    var deep = false
    var commandQueue: MTLCommandQueue!
    var device: MTLDevice!
    
    // Networks we have
    var neuralNetworkDeep: MNIST_Deep_ConvNN? = nil

    // MNIST dataset image parameters
    let mnistInputWidth  = 28
    let mnistInputHeight = 28
//    let mnistInputNumPixels = 784
    
    // Question number
    var questionNumber: uint = 0
    
    // SE
    var trueAudioPlayer: AVAudioPlayer!
    var falseAudioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var digitview: DrawView!
    @IBOutlet weak var digitAnserLabel: AnserLabel!
    @IBOutlet weak var labelAnser: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        digitview.callbackdelegate = self
        
        // Load default device.
        device = MTLCreateSystemDefaultDevice()
        
        // Create new command queue.
        commandQueue = device!.makeCommandQueue()
        
        // initialize the networks we shall use to detect digits
        neuralNetworkDeep  = MNIST_Deep_ConvNN(withCommandQueue: commandQueue)
        
        
        // Audio
        let trueAudioPath  = Bundle.main.path(forResource: "true",  ofType:"mp3")!
        let falseAudioPath = Bundle.main.path(forResource: "false", ofType:"mp3")!
        let trueAudioUrl  = URL(fileURLWithPath: trueAudioPath)
        let falseAudioUrl  = URL(fileURLWithPath: falseAudioPath)

        do {
            try trueAudioPlayer = AVAudioPlayer(contentsOf: trueAudioUrl)
            trueAudioPlayer.prepareToPlay()
        } catch {
            trueAudioPlayer = nil
        }
        
        do {
            try falseAudioPlayer = AVAudioPlayer(contentsOf: falseAudioUrl)
            falseAudioPlayer.prepareToPlay()
        } catch {
            falseAudioPlayer = nil
        }
        
        // 最初の問題を出す
        putOutQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClear(_ sender: Any) {
        print("clear")
        clerTouchView()
    }
    
    func drawviewCallback() {
        print("touch up")
        
        // 手書き認証
        let anserNumber = (uint)(tappedDetectDigit())
        
        // 表示
        digitAnserLabel.text = "\(anserNumber)"
        
        // 答え合わせ
        let flagCheck = checkAnser(qnum: questionNumber, anum: anserNumber)
        
        // SE 再生
        playSEaudio(flagTrueFals: flagCheck)
        
        // 正解
        if flagCheck {
            clerTouchView()
            putOutQuestion()
//            digitAnserLabel.clear()

        }
    }
    
    func tappedDetectDigit() -> uint{
        // get the digitView context so we can get the pixel values from it to intput to network
        let context = digitview.getViewContext()
        
        // validate NeuralNetwork was initialized properly
        assert(neuralNetworkDeep != nil)
        
        // putting input into MTLTexture in the MPSImage
        neuralNetworkDeep?.srcImage.texture.replace(region: MTLRegion( origin: MTLOrigin(x: 0, y: 0, z: 0),
size: MTLSize(width: mnistInputWidth, height: mnistInputHeight, depth: 1)),
                                             mipmapLevel: 0,
                                             slice: 0,
                                             withBytes: context!.data!,
                                             bytesPerRow: mnistInputWidth,
                                             bytesPerImage: 0)
        // run the network forward pass
        let label = (neuralNetworkDeep?.forward())!
        
        print("\(label)")
       
        return (uint)(label)
    }
    
    func clerTouchView() {
        digitview.lines = []
        digitview.setNeedsDisplay()
    }
    
    //
    // 出題
    // Question Label 表示
    func putOutQuestion(){
        questionNumber = rQuesitionNumber()
        labelQuestion.text = "\(questionNumber)"
    }
    
    // random 0-9
    func rQuesitionNumber() -> uint {
        return (uint)(arc4random_uniform(10))
    }
    
    //　答え合わせ
    func checkAnser(qnum: uint , anum : uint) -> Bool {
        if qnum == anum {
            return true
        }
        return false
    }
    
    //
    // SE audio
    func playSEaudio(flagTrueFals: Bool) {
        
        if flagTrueFals {
            playTrueAudio()
        } else {
            playFalseAudio()
        }
    }

    func playTrueAudio() {
        if trueAudioPlayer != nil {
            if trueAudioPlayer.isPlaying {
                self.trueAudioPlayer.currentTime = 0
            }
            self.trueAudioPlayer.play()
        }
    }
    
    func playFalseAudio() {
        if falseAudioPlayer != nil {
            if falseAudioPlayer.isPlaying {
                self.falseAudioPlayer.currentTime = 0
            }
            self.falseAudioPlayer.play()
        }
    }

}

