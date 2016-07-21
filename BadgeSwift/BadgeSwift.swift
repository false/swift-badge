import UIKit

/**
 
 Badge view control for iOS and tvOS.
 
 Project home: https://github.com/marketplacer/swift-badge
 
 */
@IBDesignable public class BadgeSwift: UILabel {
  
  /// Background color of the badge
  @IBInspectable public var badgeColor: UIColor = UIColor.redColor() {
    didSet {
      setNeedsDisplay()
    }
  }
  
  /// Width of the badge border
  @IBInspectable public var borderWidth: CGFloat = 0 {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  /// Color of the bardge border
  @IBInspectable public var borderColor: UIColor = UIColor.whiteColor() {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  /// Badge insets that describe the margin between text and the edge of the badge.
  @IBInspectable public var insets: CGSize = CGSize(width: 5, height: 2) {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  // MARK: Badge shadow
  // --------------------------
  
  /// Opacity of the badge shadow
  @IBInspectable public var shadowOpacityBadge: CGFloat = 0.5 {
    didSet {
      layer.shadowOpacity = Float(shadowOpacityBadge)
      setNeedsDisplay()
    }
  }
  
  /// Size of the badge shadow
  @IBInspectable public var shadowRadiusBadge: CGFloat = 0.5 {
    didSet {
      layer.shadowRadius = shadowRadiusBadge
      setNeedsDisplay()
    }
  }
  
  /// Color of the badge shadow
  @IBInspectable public var shadowColorBadge: UIColor = UIColor.blackColor() {
    didSet {
      layer.shadowColor = shadowColorBadge.CGColor
      setNeedsDisplay()
    }
  }
  
  /// Offset of the badge shadow
  @IBInspectable public var shadowOffsetBadge: CGSize = CGSize(width: 0, height: 0) {
    didSet {
      layer.shadowOffset = shadowOffsetBadge
      setNeedsDisplay()
    }
  }
  
  /// Initialize the badge view
  convenience public init() {
    self.init(frame: CGRect())
  }
  
  /// Initialize the badge view
  override public init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  /// Initialize the badge view
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setup()
  }
  
    /// Add custom insets around the text
    public override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let rect = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        
        var insetsWithBorder = actualInsetsWithBorder()
        let rectWithDefaultInsets = rect.insetBy(dx: -insetsWithBorder.width, dy: -insetsWithBorder.height)
        
        // If width is less than height
        // Adjust the width insets to make it look round
        if rectWithDefaultInsets.width < rectWithDefaultInsets.height {
            insetsWithBorder.width = (rectWithDefaultInsets.height - rect.width) / 2
        }
        let result = rect.insetBy(dx: -insetsWithBorder.width, dy: -insetsWithBorder.height)
        
        return result
        
    }
  
  /// Draws the label with insets
  override public func drawTextInRect(rect: CGRect) {
    layer.cornerRadius = rect.height / 2
    
    let insetsWithBorder = actualInsetsWithBorder()
    let insets = UIEdgeInsets(
      top: insetsWithBorder.height,
      left: insetsWithBorder.width,
      bottom: insetsWithBorder.height,
      right: insetsWithBorder.width)
    
    let rectWithoutInsets = UIEdgeInsetsInsetRect(rect, insets)
    
    super.drawTextInRect(rectWithoutInsets)
  }
  
  /// Draw the background of the badge
    override public func drawRect(rect: CGRect) {
    let rectInset = rect.insetBy(dx: borderWidth/2, dy: borderWidth/2)
    let path = UIBezierPath(roundedRect: rectInset, cornerRadius: rect.height/2)
    
    badgeColor.setFill()
    path.fill()
    
    if borderWidth > 0 {
      borderColor.setStroke()
      path.lineWidth = borderWidth
      path.stroke()
    }
    
        super.drawRect(rect)
  }
  
  private func setup() {
    textAlignment = NSTextAlignment.Center
    clipsToBounds = false // Allows shadow to spread beyond the bounds of the badge
  }
  
  /// Size of the insets plus the border
  private func actualInsetsWithBorder() -> CGSize {
    return CGSize(
      width: insets.width + borderWidth,
      height: insets.height + borderWidth
    )
  }
  
  /// Draw the stars in interface builder
  @available(iOS 8.0, *)
  override public func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    setup()
    setNeedsDisplay()
  }
}
