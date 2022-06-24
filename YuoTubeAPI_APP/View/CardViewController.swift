//
//  CardViewController.swift
//  YuoTubeAPI_APP
//
//  Created by user on 18.06.2022.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previosButton: UIButton!
    @IBOutlet weak var handleIcon: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    var data: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        playButton.setTitle("", for: .normal)
        nextButton.setTitle("", for: .normal)
        previosButton.setTitle("", for: .normal)
        
        
    }

}
