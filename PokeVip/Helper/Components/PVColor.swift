import UIKit

public struct PVColor: Equatable {
    public let uiColor: UIColor
    public let cgColor: CGColor
    
    private init(uiColor: UIColor) {
        self.uiColor = uiColor
        self.cgColor = uiColor.cgColor
    }
    
    public static var clear: PVColor {
        PVColor(uiColor: .clear)
    }
    
    public static var white: PVColor {
        PVColor(uiColor: .white)
    }
    
    public static var black: PVColor {
        PVColor(uiColor: .black)
    }
    
    public static var gray2: PVColor {
        PVColor(uiColor: .systemGray2)
    }
    
    public static var gray5: PVColor {
        PVColor(uiColor: .systemGray5)
    }
    
    public static var buttonColor: PVColor {
        PVColor(uiColor: UIColor(242, 30, 117, 1))
    }
    
    public static var opacityBlack60: PVColor {
        PVColor(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6))
    }
    
    public static var bug: PVColor {
        PVColor(uiColor: UIColor(red: 122, green: 146, blue: 45, alpha: 1))
    }
    public static var dragon: PVColor {
        PVColor(uiColor: UIColor(red: 111, green: 53, blue: 252, alpha: 1))
    }
    public static var fairy: PVColor {
        PVColor(uiColor: UIColor(red: 214, green: 133, blue: 173, alpha: 1))
    }
    public static var fire: PVColor {
        PVColor(uiColor: UIColor(red: 238, green: 129, blue: 48, alpha: 1))
    }
    public static var ghost: PVColor {
        PVColor(uiColor: UIColor(red: 115, green: 87, blue: 151, alpha: 1))
    }
    public static var ground: PVColor {
        PVColor(uiColor: UIColor(red: 226, green: 191, blue: 101, alpha: 1))
    }
    public static var normal: PVColor {
        PVColor(uiColor: UIColor(red: 168, green: 167, blue: 122, alpha: 1))
    }
    public static var psychic: PVColor {
        PVColor(uiColor: UIColor(red: 249, green: 85, blue: 135, alpha: 1))
    }
    public static var steel: PVColor {
        PVColor(uiColor: UIColor(red: 183, green: 183, blue: 206, alpha: 1))
    }
    public static var dark: PVColor {
        PVColor(uiColor: UIColor(red: 112, green: 87, blue: 70, alpha: 1))
    }
    public static var electric: PVColor {
        PVColor(uiColor: UIColor(red: 247, green: 208, blue: 44, alpha: 1))
    }
    public static var fighting: PVColor {
        PVColor(uiColor: UIColor(red: 194, green: 46, blue: 40, alpha: 1))
    }
    public static var flying: PVColor {
        PVColor(uiColor: UIColor(red: 169, green: 143, blue: 243, alpha: 1))
    }
    public static var grass: PVColor {
        PVColor(uiColor: UIColor(red: 122, green: 199, blue: 76, alpha: 1))
    }
    public static var ice: PVColor {
        PVColor(uiColor: UIColor(red: 150, green: 217, blue: 214, alpha: 1))
    }
    public static var poison: PVColor {
        PVColor(uiColor: UIColor(red: 163, green: 62, blue: 161, alpha: 1))
    }
    public static var rock: PVColor {
        PVColor(uiColor: UIColor(red: 182, green: 161, blue: 54, alpha: 1))
    }
    public static var water: PVColor {
        PVColor(uiColor: UIColor(red: 99, green: 144, blue: 240, alpha: 1))
    }
    
    public static func == (lhs: PVColor, rhs: UIColor) -> Bool {
        var lRed: CGFloat = 0, lGreen: CGFloat = 0, lBlue: CGFloat = 0, lAlpha: CGFloat = 0
        lhs.uiColor.getRed(&lRed, green: &lGreen, blue: &lBlue, alpha: &lAlpha)
        var rRed: CGFloat = 0, rGreen: CGFloat = 0, rBlue: CGFloat = 0, rAlpha: CGFloat = 0
        rhs.getRed(&rRed, green: &rGreen, blue: &rBlue, alpha: &rAlpha)
        return lRed == rRed && lGreen == rGreen && lBlue == rBlue && lAlpha == rAlpha
    }
}

extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
    
    public static func pvColor(_ color: PVColor) -> UIColor {
        return color.uiColor
    }
}

extension CGColor {
    public static func pvColor(_ color: PVColor) -> CGColor {
        return color.cgColor
    }
}
