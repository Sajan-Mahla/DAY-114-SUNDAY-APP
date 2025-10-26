//
//  ContentView.swift
//  Colorify
//
//  Created by SAJAN  on 26/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var bgColor = Color.random()
    @State private var hexValue = Color.random().toHex()
    @State private var rgbValue = Color.random().toRGB()

    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        let newColor = Color.random()
                        bgColor = newColor
                        hexValue = newColor.toHex()
                        rgbValue = newColor.toRGB()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                }

            VStack(spacing: 10) {
                Text(hexValue)
                    .font(.system(size: 40, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .shadow(radius: 2)

                Text(rgbValue)
                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.9))

                Button(action: {
                    UIPasteboard.general.string = hexValue
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }) {
                    Text("Copy HEX")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 10)
            }
        }
    }
}

extension Color {
    static func random() -> Color {
        Color(red: .random(in: 0...1),
              green: .random(in: 0...1),
              blue: .random(in: 0...1))
    }

    func toHex() -> String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return String(format: "#%02lX%02lX%02lX",
                      lroundf(Float(red * 255)),
                      lroundf(Float(green * 255)),
                      lroundf(Float(blue * 255)))
    }

    func toRGB() -> String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return "RGB(\(Int(red * 255)), \(Int(green * 255)), \(Int(blue * 255)))"
    }
}

#Preview {
    ContentView()
}
