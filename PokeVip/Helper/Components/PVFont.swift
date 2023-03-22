import UIKit

public class PVFont: UIFont {

    public enum FontType: String {
        case arial16, arial20, arial22, arial25
    }

    public static func arial(size: CGFloat = 14) -> UIFont? {
        return UIFont(name: "arial", size: size)
    }
}

extension PVFont {
    public static func font(fontType: PVFont.FontType) -> UIFont? {
        switch fontType {
        case .arial16, .arial20, .arial22, .arial25:
            return arialFont(fontType: fontType)
        }
    }

    private static func arialFont(fontType: PVFont.FontType) -> UIFont? {
        switch fontType {
        case .arial16: return PVFont.arial(size: 16)
        case .arial20: return PVFont.arial(size: 20)
        case .arial22: return PVFont.arial(size: 22)
        case .arial25: return PVFont.arial(size: 25)
        }
    }
}
