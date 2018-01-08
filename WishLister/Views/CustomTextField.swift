
import UIKit

// Extension to UIColor to allow setting the color value by hex value.
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        // Verify that we have valid values.
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    // Initializes and sets color by hex value.
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
}

@IBDesignable
internal class CustomTextField: UITextField {
    
    // MARK: - IBInspectable
    @IBInspectable internal var tintCol: UIColor = UIColor(netHex: 0x707070)
    @IBInspectable internal var fontCol: UIColor = UIColor(netHex: 0x707070)
    @IBInspectable internal var shadowCol: UIColor = UIColor(netHex: 0x707070)
    
    // MARK: - Properties
    internal var textFont = UIFont(name: "Helvetica Neue", size: 14.0)
    
    override internal func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 230, green: 230, blue: 230)
        self.layer.cornerRadius = 15
        self.tintColor = tintCol
        self.textColor = fontCol
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 255, green: 255, blue: 255).cgColor
        
        if let phText = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: phText, attributes: [NSAttributedString.Key.foregroundColor: UIColor(netHex: 0xB3B3B3)])
        }
        
        if let fnt = textFont {
            self.font = fnt
        } else {
            self.font = UIFont(name: "Helvetica Neue", size: 14.0)
        }
    }
    
    // Placeholder text
    override internal func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    // Editable text
    override internal func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
