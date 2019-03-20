//
//  DashedView.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

class DashedView: UIView {

    override func draw(_ rect: CGRect) {

        let  path = UIBezierPath()

        let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        path.move(to: p0)

        let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        path.addLine(to: p1)

        let  dashes: [CGFloat] = [3, 2]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineWidth = self.height
        path.lineCapStyle = .square
        UIColor.lightGray.set()
        path.stroke()
    }
}
