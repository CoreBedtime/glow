//
//  ThemePage.swift
//  glowcreator
//
//  Created by bedtime on 2/15/23.
//

import SwiftUI
import Foundation

struct ThemeInfo: Identifiable
{
    var id: UUID?
    var name = "Theme"
    var mode = false
}

func GetThemeInfoStructs() -> [ThemeInfo]
{
    do
    {
        let happy_alt = try FileManager.default.contentsOfDirectory(atPath: "/Library/Glow/")
        
        var returnVal: [ThemeInfo] = []
        
        for string in happy_alt
        {
            var themeInfo = ThemeInfo(id: UUID())
            
            themeInfo.name = string
            themeInfo.mode = false
            
            returnVal.append(themeInfo)
        }
        
        return returnVal
        
    } catch
    {
        print(error)
        return []
    }
}

public struct ThemeButton: View {

    private var name: String = "Nothing."
    private var mode: Bool = false
    
    public var body: some View {
        HStack(spacing: 10)
        {
            Text(name)
        }
        .frame(minWidth: 175, minHeight: 40)
        .background(Color(red: Float64.random(in: 0...1), green: Float64.random(in: 0...1), blue: Float64.random(in: 0...1)))
        .foregroundColor(Color.white)
    }
    
    init(_ name: String)
    {
        self.name = name
        self.mode = false
    }
}

public func hi()
{
    print("hi");
}


struct CustomButton: View
{
    
    var buttonType: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                // Action
            }) {
                Image(systemName: buttonType ? "checkmark" : "trash")
                    .frame(maxWidth: 50, maxHeight: 50)
                    .background(Color(red: Float64.random(in: 0...1), green: Float64.random(in: 0...1), blue: Float64.random(in: 0...1)))
                    .foregroundColor(Color.white)
                    .offset(x: 10)
                Text(buttonType ? "Apply" : "Delete")
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity, minHeight: 50
                    )
                    .font(Font.subheadline.weight(.bold))
                    .background(Color(red: Float64.random(in: 0...1), green: Float64.random(in: 0...1), blue: Float64.random(in: 0...1)))
                    .foregroundColor(Color.white)

            }
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding([.leading,.trailing], 10)
            .buttonStyle(.plain)
        }
    }
}

struct ThemePage: View {
    
    @State var theme: String
    
    var body: some View {
        HStack(spacing: 10)
        {
            ScrollView{
                VStack(alignment: .leading, spacing: 20)
                {
                    ForEach(GetThemeInfoStructs()) { item in
                        ThemeButton(item.name)
                    }
                }
                .frame(width: 275)
                .background(Color.secondaryBackgroundColor)
            }
            .frame(width: 275)
            .background(Color.secondaryBackgroundColor) // Extra background layer to reset the shadow and stop it applying to every sub-view
            .shadow(color: Color.clear, radius: 0, x: 0, y: 0)
            .background(Color.secondaryBackgroundColor)
            .shadow(
                color: Color.black.opacity(0.25),
                radius: 3,
                x: 1,
                y: 0
            )
            .zIndex(99)
            
            VStack
            {
                Color(.orange)
                HStack()
                {
                    CustomButton(buttonType: (1 != 0))
                        .frame(height: 75)
                    CustomButton(buttonType: (0 != 0))
                        .frame(height: 75)
                }
                .frame(height: 75)
            }
        }
    }
}
