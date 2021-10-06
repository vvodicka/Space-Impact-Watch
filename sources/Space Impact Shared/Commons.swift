//
//  Commons.swift
//  Space Impact
//
//  Created by Vladislav Vodicka on 01/12/2020.
//
import SpriteKit

public enum VibrationType : Int {
    case notification = 0
    case success = 3
    case failure = 4
    case click = 8
}

public enum NukeType {
    case line
    case missle
    case laser
}

protocol InterfaceDelegate {
    func vibrate(_ : VibrationType)
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}

extension SKNode {
    var positionInScene: CGPoint? {
        if let scene = scene, let parent = parent {
            return parent.convert(position, to:scene)
        } else {
            return nil
        }
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

protocol GameControllerDelegate {
    func presentGameOverController(context: (score: Int, level: Int, victory: Bool, ranked: Bool))
    func loadLevel(context : (score: Int, level: Int))
}
