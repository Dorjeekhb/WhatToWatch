//
//  WhatToWatchComplication.swift
//  WhatToWatchComplication
//
//  Created by Dorjee on 23/7/25.
//

import WidgetKit
import SwiftUI
import Intents

// MARK: - Modelo compartido para UserDefaults
struct ComplicationItem: Codable {
    let id: Int
    let title: String
    let imageURL: URL?
}

struct SharedStorage {
    static let suiteName = "group.com.dorjee.whattowatch"
    static let key = "currentRecommendation"

    static func loadItem() -> ComplicationItem? {
        guard let data = UserDefaults(suiteName: suiteName)?.data(forKey: key),
              let item = try? JSONDecoder().decode(ComplicationItem.self, from: data) else {
            return nil
        }
        return item
    }
}

// MARK: - Timeline Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), item: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), item: SharedStorage.loadItem())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: Date(), item: SharedStorage.loadItem())
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(3600)))
        completion(timeline)
    }
}

// MARK: - Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let item: ComplicationItem?
}

// MARK: - Complication View
struct WhatToWatchComplicationEntryView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        if let item = entry.item {
            VStack(alignment: .leading, spacing: 4) {
                if let url = item.imageURL {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(4)
                }
                Text(item.title)
                    .font(.caption2)
                    .bold()
                    .lineLimit(1)
            }
            .widgetURL(URL(string: "whattowatch://show?id=\(item.id)"))
        } else {
            Text("🎬 What To Watch")
                .widgetURL(URL(string: "whattowatch://"))
        }
    }
}

// MARK: - Widget
@main
struct WhatToWatchComplication: Widget {
    let kind: String = "WhatToWatchComplication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WhatToWatchComplicationEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Recommendation")
        .description("Shows the daily movie or series suggestion.")
        .supportedFamilies([.accessoryRectangular, .accessoryCircular, .accessoryInline])
    }
}
