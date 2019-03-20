//
//  ForecastModuleTableViewHeader.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

class ForecastModuleTableViewHeader: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    static let desiredHeight: CGFloat = 50.0

    @IBOutlet weak private var headerLabel: UILabel!

    func configure(with title: String) {
        headerLabel.text = title
    }
}
