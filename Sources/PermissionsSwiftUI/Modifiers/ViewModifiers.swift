//
//  ViewModifier.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import SwiftUI

//Custom view modifier for the button component
struct ButtonStatusColor: ViewModifier {
    var allowButtonStatus: AllowButtonStatus
    func body(content: Content) -> some View {
        let colorStore = PermissionStore.shared.allButtonColors
        switch self.allowButtonStatus {
        case .idle:
            return content.allowButton(foregroundColor: colorStore.buttonIdle.foregroundColor,
                                       backgroundColor: colorStore.buttonIdle.backgroundColor)

        case .allowed:
            return content.allowButton(foregroundColor: colorStore.buttonAllowed.foregroundColor,
                                       backgroundColor: colorStore.buttonAllowed.backgroundColor)


        case .denied:
            return content.allowButton(foregroundColor: colorStore.buttonDenied.foregroundColor,
                                       backgroundColor: colorStore.buttonDenied.backgroundColor)
        }
    }
}
//Custom modifier that nests within ButtonStatusColor to further extract code
struct AllowButton: ViewModifier {
    var foregroundColor: Color
    var backgroundColor: Color
    var buttonSizeConstant :CGFloat {
        return screenSize.width < 400 ?  70-(1000-screenSize.width)/30 : 70
    }
    func body(content: Content) -> some View {
        content
        .frame(width: buttonSizeConstant)
        .font(.system(size: 15))
        .minimumScaleFactor(0.2)
        .lineLimit(1)
        .foregroundColor(foregroundColor)
        .padding(.vertical,6)
        .padding(.horizontal, 6)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
    }
}

struct JMAlertViewFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground).opacity(0.8))
            .frame(width: screenSize.width > 375 ? 375 : screenSize.width-60)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func buttonStatusColor(for allowButtonStatus: AllowButtonStatus) -> some View {
        self.modifier(ButtonStatusColor(allowButtonStatus: allowButtonStatus))
    }
    func allowButton(foregroundColor: Color, backgroundColor: Color) -> some View {
        self.modifier(AllowButton(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
    func alertViewFrame() -> some View {
        self.modifier(JMAlertViewFrame())
    }
}
