//
//  CardfitWidget.swift
//  CardfitWidget
//
//  Created by 서동운 on 6/21/23.
//

import WidgetKit
import SwiftUI

// TimelineProvider: 렌더링할 시기(업데이트 시기)를 알려주는 Timeline을 생성하는 객체

struct Provider: IntentTimelineProvider {
    typealias Entry = MyCardEntry
    typealias Intent = CardIntent
    
    
    // placeholder를 이용해서 appleWatch나 lockScreen의 민감한 정보들을 숨길수 있음.
    func placeholder(in context: Context) -> Entry {
        let userCards = Repository.shared.fetchUserCards()
        
        if userCards.isEmpty {
            return MyCardEntry(date: Date.now, userCard: .placeholder(), configuration: CardIntent())
        } else {
            return MyCardEntry(date: Date.now, userCard: userCards.first!, configuration: CardIntent())
        }
    }

    // 단일 timeline 을 반환
    func getSnapshot(for configuration: Intent, in context: Context, completion: @escaping (Entry) -> ()) {
        
        let userCards = Repository.shared.fetchUserCards()
        if userCards.isEmpty {
            let entry = MyCardEntry(date: Date.now, userCard: .placeholder(), configuration: configuration)
            completion(entry)
        } else {
            let entry = MyCardEntry(date: Date.now, userCard: userCards.first!, configuration: configuration)
            completion(entry)
        }
    }
    
    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let cardID = configuration.parameter?.identifier
        var entries: [MyCardEntry] = []
        let userCard = Repository.shared.fetchFilteredCards { $0._id.stringValue == cardID }
        
        for dayOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date.now)!
          
            if userCard.isEmpty {
                let entry = MyCardEntry(date: entryDate, userCard: .placeholder(), configuration: configuration)
                entries.append(entry)
            } else {
                let entry = MyCardEntry(date: entryDate, userCard: userCard.first!, configuration: configuration)
                entries.append(entry)
            }
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MyCardEntry: TimelineEntry {
    let date: Date
    let userCard: Card
    let configuration: CardIntent
}

struct CardfitWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemLarge:
            WidgetContentView(card: entry.userCard)
        default:
            VStack {
                Text("지원하지 않는 사이즈")
            }
        }
    }
}

struct CardfitWidget: Widget {
    let kind: String = "CardfitWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CardIntent.self, provider: Provider()) { entry in
            CardfitWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("내 카드 혜택보기")
        .description("내가 등록한 카드의 상세보기를 빠르게 접근하세요")
        .supportedFamilies([.systemLarge])
    }
}

struct CardfitWidget_Previews: PreviewProvider {
    static var previews: some View {
        CardfitWidgetEntryView(entry: MyCardEntry(date: Date.now, userCard: .placeholder(), configuration: CardIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
