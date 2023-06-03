//
//  File.swift
//  
//
//  Created by Aaron Strickland on 23/02/2023.
//



import Foundation
import SwiftUI

@available(iOS 15.0, *)

public struct ToastieView: View {
    @Environment(\.colorScheme) var colorScheme

    var type: ToastieStyle
    var title: String
    var message: String
 
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: type.iconFileName)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .foregroundColor(type.themeColor)
                
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.6))

                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
             
            }
            .padding()
        }
        .background(colorScheme == .dark ? Color.gray : Color.white)
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}


public enum ToastieStyle {
    case error
    case warning
    case success
    case info
    case message
}



@available(iOS 15.0, *)
public extension ToastieStyle {
     var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        case .message: return Color.blue
        }
    }
    
     var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .message: return "ellipses.bubble.fill"
        }
    }
}






public struct Toastie: Equatable {
    
    var type: ToastieStyle
    var title: String
    var message: String
    var duration: Double = 2.5
    
    public init(type: ToastieStyle, title: String, message: String, duration: Double = 2.5) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
    }
}


@available(iOS 15.0, *)
public struct ToastieModifier: ViewModifier {
    @Binding var toast: Toastie?
    @State private var workItem: DispatchWorkItem?
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastieView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastieView() -> some View {
        if let toast = toast {
            VStack {
                Text("").padding(5)
                ToastieView(
                    type: toast.type,
                    title: toast.title,
                    message: toast.message)
                
                Spacer()
            }
            .transition(.move(edge: .top))
        }
    }
    
    public func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
               dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    public func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}


@available(iOS 15.0, *)
public extension View {
     func toastieView(toast: Binding<Toastie?>) -> some View {
        self.modifier(ToastieModifier(toast: toast))
    }
}



