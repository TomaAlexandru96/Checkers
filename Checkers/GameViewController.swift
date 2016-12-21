//
//  GameViewController.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

extension SKView {
    func changeSceneTo(sceneName scene: String) -> Void {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: scene) {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
        
            // Present the scene
            presentScene(scene)
        }
    
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
    }
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            view.changeSceneTo(sceneName: "GameScene")
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
