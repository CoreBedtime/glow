//
//  ContentView.swift
//  glowcreator
//
//  Created by bedtime on 2/15/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        CustomTabView(
            tabBarPosition: .top,
            content: [
                (
                    tabText: "Themes",
                    tabIconName: "paintbrush.pointed",
                    view: AnyView(
                        HStack {
                            Spacer()
                            VStack {
                                ThemePage()
                                    .frame(maxHeight: .infinity)
                            }
                            Spacer()
                        }
                    )
                ),
                (
                    tabText: "Editor",
                    tabIconName: "pencil",
                    view: AnyView(
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Text("Second Tab!")
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(Color.red)
                    )
                ),
                (
                    tabText: "Settings",
                    tabIconName: "gear",
                    view: AnyView(
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Text("Third Tab!")
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(Color.yellow)
                    )
                )
            ]
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

