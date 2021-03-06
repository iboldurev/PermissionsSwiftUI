//
//  AlertMainView.swift.swift
//  
//
//  Created by Jevon Mao on 2/10/21.
//

import SwiftUI

//The root level view for alert-style
struct AlertMainView: View {
    private var showAlert: Binding<Bool>
    private var bodyView: AnyView
    var shouldShowPermission:Bool{
        if PermissionStore.shared.autoCheckAlertAuth{
            if showAlert.wrappedValue &&
                !PermissionStore.shared.permissionsToAsk.isEmpty {
                return true
            }
            else {
                return false
            }
        }
        if showAlert.wrappedValue{
            return true
        }
        else {
            return false
        }
    }
    
    init(for bodyView: AnyView, show showAlert: Binding<Bool>) {
        self.bodyView = bodyView
        self.showAlert = showAlert
    }
    var body: some View {
        ZStack{
            bodyView

            if shouldShowPermission{
                Group{
                    Blur(style: .systemUltraThinMaterialDark)
                        .edgesIgnoringSafeArea(.all)
                        .transition(AnyTransition.opacity.animation(Animation.default.speed(1.8)))
                    AlertView(showAlert:showAlert)
                        .transition(AnyTransition.opacity.combined(with: .scale(scale: 0.92)).animation(Animation.default.speed(1.5)))
                        .onAppear(perform: PermissionStore.shared.onAppear)
                        .onDisappear(perform: PermissionStore.shared.onDisappear)
                }

            }
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.default)


    }
}

