//
//  DashedBorderedImageView.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

class DashedBorderedImageView: UIImageView {

    var dashedBorderLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()

        if dashedBorderLayer == nil {
            dashedBorderLayer = CAShapeLayer()
            dashedBorderLayer?.strokeColor = UIColor.black.cgColor
            dashedBorderLayer?.lineDashPattern = [2, 2]
            dashedBorderLayer?.frame = self.bounds
            dashedBorderLayer?.fillColor = nil
            dashedBorderLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.width / 4).cgPath
            self.layer.addSublayer(dashedBorderLayer!)
        }

        dashedBorderLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.width / 4).cgPath
        dashedBorderLayer?.frame = self.bounds
    }
}
