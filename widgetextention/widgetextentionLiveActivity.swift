//
//  widgetextentionLiveActivity.swift
//  widgetextention
//
//  Created by Thiago Parisotto on 01/03/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct widgetextentionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct widgetextentionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widgetextentionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension widgetextentionAttributes {
    fileprivate static var preview: widgetextentionAttributes {
        widgetextentionAttributes(name: "World")
    }
}

extension widgetextentionAttributes.ContentState {
    fileprivate static var smiley: widgetextentionAttributes.ContentState {
        widgetextentionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: widgetextentionAttributes.ContentState {
         widgetextentionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: widgetextentionAttributes.preview) {
   widgetextentionLiveActivity()
} contentStates: {
    widgetextentionAttributes.ContentState.smiley
    widgetextentionAttributes.ContentState.starEyes
}
