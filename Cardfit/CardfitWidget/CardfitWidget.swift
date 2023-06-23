//
//  CardfitWidget.swift
//  CardfitWidget
//
//  Created by 서동운 on 6/21/23.
//

import WidgetKit
import SwiftUI
import Intents

// 렌더링할 시기(업데이트 시기)를 알려주는 Timeline을 생성하는 객체

struct Provider: IntentTimelineProvider {
    
    // placeholder를 이용해서 appleWatch나 lockScreen의 민감한 정보들을 숨길수 있음.
    func placeholder(in context: Context) -> MyCardEntry {
        guard let userCardEntity = PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self, predicate: nil).first else {
            // ✅ 저장한 카드가 없을경우 임시데이터 생성후 넣어준다.
            return MyCardEntry(date: Date(), userCard: .placeholder(), configuration: ConfigurationIntent())
        }
        guard let userCard = userCardEntity.convertToCards().first else {
            return MyCardEntry(date: Date(), userCard: .placeholder(), configuration: ConfigurationIntent())
        }
        
        return MyCardEntry(date: Date(), userCard: userCard, configuration: ConfigurationIntent())
    }
    
    // 단일 timeline 을 반환
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MyCardEntry) -> ()) {
        guard let userCardEntity = PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self, predicate: nil).first else {
            let entry = MyCardEntry(date: Date(), userCard: .placeholder(), configuration: configuration)
            completion(entry)
            return
        }
        
        guard let userCard = userCardEntity.convertToCards().first else {
            let entry = MyCardEntry(date: Date(), userCard: .placeholder(), configuration: configuration)
            completion(entry)
            return
        }
        let entry = MyCardEntry(date: Date(), userCard: userCard, configuration: ConfigurationIntent())
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MyCardEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: hourOffset, to: currentDate)!
            
            guard let userCardEntity = PersistenceController.shared.fetchData(entity: .userCardEntity, entityType: UserCardEntity.self, predicate: nil).first else {
                let entry = MyCardEntry(date: entryDate, userCard: .placeholder(), configuration: configuration)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
                return
            }
            
            guard let userCard = userCardEntity.convertToCards().first else {
                let entry = MyCardEntry(date: entryDate, userCard: .placeholder(), configuration: configuration)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
                return
            }
            
            let entry = MyCardEntry(date: entryDate, userCard: userCard, configuration: configuration)
            
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MyCardEntry: TimelineEntry {
    let date: Date
    let userCard: Card
    let configuration: ConfigurationIntent
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
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CardfitWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("나의 카드")
        .description("내가 등록한 카드의 상세보기를 빠르게 접근하세요")
        .supportedFamilies([.systemLarge])
    }
}

struct CardfitWidget_Previews: PreviewProvider {
    static var previews: some View {
        CardfitWidgetEntryView(entry: MyCardEntry(date: Date(), userCard: .placeholder(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
