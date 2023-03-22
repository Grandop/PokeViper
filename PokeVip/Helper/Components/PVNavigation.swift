import Foundation
import UIKit

public class ODNavigation {
    public static let shared = ODNavigation()

    public enum NavigationStyle {
        case light
    }

    private func defaultNavigation() {

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes =
                [
                    .foregroundColor:  UIColor.white,
                    .font: UIFont.systemFont(ofSize: 16)
                ]

            appearance.largeTitleTextAttributes =
                [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 20)
                ]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().isTranslucent = true
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.clear
            UINavigationBar.appearance().isTranslucent = true
            UINavigationBar.appearance().titleTextAttributes =
                [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 16)
                ]

            UINavigationBar.appearance().largeTitleTextAttributes =
                [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 20)
                ]
        }
        UINavigationBar.appearance().tintColor = UIColor.white
        
        
    }

    private func lightNavigation() {
        defaultNavigation()
    }

    public func setup(style: NavigationStyle) {
        switch style {
        case .light:
            lightNavigation()
        }
    }
}
