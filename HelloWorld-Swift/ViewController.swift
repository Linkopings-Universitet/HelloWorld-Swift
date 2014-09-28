//
//  ViewController.swift
//  HelloWorld-Swift
//
//  Created by Cenny Davidsson on 2014-09-24.
//  Copyright (c) 2014 Linköpings University. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // IBOutlet betyder att att denna är/kan kopplas till interface builder/storyboard.
    @IBOutlet weak var shaleLabel: UILabel!
    
    // Du kan instansiera dina properties med en closure.
    let audioPlayer:AVAudioPlayer = {
        
        // Hitta den exakta sökvägen till vår ljudfil aaa.wav
        let url = NSBundle.mainBundle().URLForResource("aaa", withExtension: "wav")
        
        // Skapa en ljudspelare som ska spela upp ljudet
        let player = AVAudioPlayer(contentsOfURL: url, error: nil)
        
        player.prepareToPlay()
        return player
    }()
    
    // Initialisera vår räknarvariabel. Denna ska hålla räkningen på hur många gånger
    // användaren skakat skärmen
    var shakeCount = 0
    
    
    // MARK: - UIViewController

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Gör så denna vy svarar på events
        becomeFirstResponder()
    }

    // MARK: - UIResponder
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        // Kollar att rörelsen var en skakning
        if motion == .MotionShake {
            // Skriv ut debug-skrift till loggen
            println("Skak!")
            
            // Spela upp ljudet
            playSound()
            
            // Öka skakräknaren
            shakeCount++
            
            // Uppdatera texten som visas på skärmen
            shaleLabel.text = "Du har skakat på skärmen \(shakeCount) gånger"
        }
    }
    
    // MARK: - User interaction
    
    func playSound() {
        
        // Kolla om ljudet redan spelas
        if audioPlayer.playing {
            
            // Stoppa det då och sätt spelaren till att börja från början
            // av ljudfilen nästa gång den spelas
            audioPlayer.stop()
            audioPlayer.currentTime = 0
        }
        
        // Spela ljudet!
        audioPlayer.play()
    }
}

