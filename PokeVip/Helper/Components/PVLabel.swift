import UIKit

public final class PVLabel: UILabel {

    private let fontType: PVFont.FontType
    private var style: Style?
    
    public init(
        _ fontType: PVFont.FontType = .arial25,
        textColor: PVColor = .white,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 0
    ) {
        self.fontType = fontType
        super.init(frame: .zero)
        self.textAlignment = alignment
        self.textColor = textColor.uiColor.withAlphaComponent(alpha)
        self.numberOfLines = numberOfLines
        self.font = PVFont.font(fontType: fontType)
    }

    public convenience init(
        _ style: Style,
        textColor: PVColor? = nil,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 0
    ) {
        var attributes: (PVFont.FontType, PVColor)
        switch style {
        case .body: attributes = PVLabelHelper.setupBody(style)
        case .title25, .title22: attributes = PVLabelHelper.setupTitle(style)
        }
        
        self.init(
            attributes.0,
            textColor: textColor ?? attributes.1,
            alignment: alignment,
            numberOfLines: numberOfLines
        )
        self.style = style
    }
    
    public enum Style: String, CaseIterable {
        case title25
        case title22
        case body
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
}

private class PVLabelHelper {
    static func setupTitle(_ style: PVLabel.Style) -> (PVFont.FontType, PVColor) {
        switch style {
        case .title25: return (.arial25, .white)
        case .title22: return (.arial22, .white)
        default: return (.arial25, .white)
        }
    }

    static func setupBody(_ style: PVLabel.Style) -> (PVFont.FontType, PVColor) {
        switch style {
        case .body: return (.arial20, .white)
        default: return (.arial20, .white)
        }
    }
}

