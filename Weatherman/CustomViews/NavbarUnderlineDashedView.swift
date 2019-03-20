//
//  NavbarUnderlineDashedView.swift
//  Weatherman
//
//  Created by Dmitryj on 20/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import UIKit

class NavbarUnderlineDashedView: UIView {

    override func draw(_ rect: CGRect) {

        let colors: [UIColor] = [.purple, .orange, .green, .blue, .yellow, .red]
        let step = self.bounds.width / 6.0
        var currentPosition = self.bounds.minX

        // "fill"
        let fillPath = UIBezierPath()
        let startFillPoint = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        fillPath.move(to: startFillPoint)
        let endFillPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        fillPath.addLine(to: endFillPoint)
        fillPath.lineWidth = self.height
        UIColor.lightGray.withAlphaComponent(0.8).setStroke()
        fillPath.stroke()

        for color in colors {

            // stroke
            let bottomStrokePath = UIBezierPath()
            let dashes: [CGFloat] = [2, 5]

            let startStrokePointBottom = CGPoint(x: currentPosition, y: self.bounds.midY + self.bounds.height / 4)
            bottomStrokePath.move(to: startStrokePointBottom)
            let endStrokePointBottom = CGPoint(x: currentPosition + step, y: self.bounds.midY + self.bounds.height / 4)
            bottomStrokePath.addLine(to: endStrokePointBottom)

            bottomStrokePath.setLineDash(dashes, count: dashes.count, phase: 0.0)
            bottomStrokePath.lineWidth = self.height / 2
            bottomStrokePath.lineCapStyle = .square
            color.setStroke()
            bottomStrokePath.stroke()

            let topStrokePath = UIBezierPath()

            let startStrokePointTop = CGPoint(x: currentPosition, y: self.bounds.midY - self.bounds.height / 4)
            topStrokePath.move(to: startStrokePointTop)
            let endStrokePointTop = CGPoint(x: currentPosition + step, y: self.bounds.midY - self.bounds.height / 4)
            topStrokePath.addLine(to: endStrokePointTop)

            topStrokePath.setLineDash(dashes, count: dashes.count, phase: 2)
            topStrokePath.lineWidth = self.height / 2
            topStrokePath.lineCapStyle = .square
            color.setStroke()
            topStrokePath.stroke()

            currentPosition += step
        }
    }
}
