//
//  TamaraLearnMorePopup.swift
//  TamaraSDK
//
//  Created by Admin on 10/28/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import UIKit

public class TamaraLearnMorePopup: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public init() {
        super.init(nibName: "TamaraLearnMorePopup", bundle: Bundle(for: TamaraLearnMorePopup.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tap(_ sender: Any) {
        guard let url = URL(string: "https://tamara.co/") else {return}
        UIApplication.shared.canOpenURL(url)
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
