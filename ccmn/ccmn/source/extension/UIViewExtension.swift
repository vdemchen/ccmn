import UIKit

// MARK: - Shake

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }
}

extension UIView {
    public func circleView() {
        layer.cornerRadius = bounds.height == 0.0 ? bounds.height : frame.size.height / 2
    }
    
    class func Nib() -> UIView {
        return UINib(nibName: self.className(), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
}

//MARK: - Gradient

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

public enum GradientDirection {
    case leftToRight
    case rightToLeft
    case upToDown
    case downToUp
}

extension UIView {
    public func setGradientLayer(
        start: UIColor,
        end: UIColor,
        direction: GradientDirection? = nil,
        bounds: CGRect? = nil
    ) {
        let gradient = CAGradientLayer()

        gradient.colors = [
            start.cgColor,
            end.cgColor,
        ]

        if let direction = direction {
            switch direction
            {
            case .leftToRight:
                gradient.calculatePoints(for: 0)
            case .rightToLeft:
                gradient.calculatePoints(for: 180)
            case .upToDown:
                gradient.calculatePoints(for: 90)
            case .downToUp:
                gradient.calculatePoints(for: 270)
            }
        } else {
            gradient.calculatePoints(for: 0)
        }

        layoutIfNeeded()

        if let bounds = bounds {
            gradient.frame = bounds
        } else {
            gradient.frame = self.bounds
        }

        layer.insertSublayer(gradient, at: 0)
    }

    func removeGradient(_ animation: Bool = false, _ duration: CFTimeInterval = 0.1)  {
        
        guard let sublayers = self.layer.sublayers else { return }
        
        for layer in sublayers {
            guard let gradient = layer as? CAGradientLayer else { continue }
            
            if animation == true {
                CATransaction.begin()
                CATransaction.setAnimationDuration(duration)
                CATransaction.setCompletionBlock({
                    gradient.removeFromSuperlayer()
                    }
                )
                gradient.opacity = 0.0
                CATransaction.commit()
            } else {
                gradient.removeFromSuperlayer()
            }
        }
    }
    
}
