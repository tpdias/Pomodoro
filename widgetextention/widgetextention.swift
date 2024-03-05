//
//  widgetextention.swift
//  widgetextention
//
//  Created by Thiago Parisotto on 01/03/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    let data = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), timer: data.progress())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, timer: data.progress())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, timer: data.progress())
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let timer: TimeInterval
}

struct widgetextentionEntryView : View {
    let dataService = DataService()

    var start = Calendar.current.date(byAdding: .second, value: Int(-16), to: Date.now)!
    @State var end: Date
    var entry: Provider.Entry
    var body: some View {
        VStack {
            Spacer()
           // Text(timerInterval: start...end, countsDown: true)
            Text("Widget for Pomodoro with Kitties")
            Spacer()
        } .onAppear {
//            let sharedUserDefaults = UserDefaults(suiteName: appGroup)
//            if let timer = sharedUserDefaults?.value(forKey: "timer") as? Double {
//                print(timer)
//                end = Calendar.current.date(byAdding: .second, value: Int(timer), to: Date.now)!
//            }
        }
    }
}

struct widgetextention: Widget {
    let kind: String = "widgetextention"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            widgetextentionEntryView(end: .now, entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

