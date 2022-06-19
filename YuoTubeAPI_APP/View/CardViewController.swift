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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        playButton.setTitle("", for: .normal)
        nextButton.setTitle("", for: .normal)
        previosButton.setTitle("", for: .normal)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
