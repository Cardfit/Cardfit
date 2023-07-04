# Cardfit

## 멤버
    🍊Huko: https://github.com/ykm989
    🍅Domb: https://github.com/DONG-WOON
## 기간
23/05 ~ 23/06 (2개월)
## 구현화면
preview

## 사용기술

iOS
|  아키텍처      | 프레임워크 | 라이브러리           |
|    --          |     --     |     --               |
|   MVVM         |  SwiftUI   | Firebase Firestore   |
|                |  CoreData  | Firebase Storage     | 
|                |  Combine   |                      |
|                |  WidgetKit |                      |

BE
| 프레임워크 |    라이브러리      |
|     --     |       --           |
|   Selenium |  Beautiful Soup    |
|            | Firebase Firestore   |
|            | Firebase Storage     | 

## 핵심경험

#### *Widget Intent Configuration*
위젯에 사용자 설정 
#### *CoreData*

#### *Bind<Value>*

```swift
private func bindingForCard(_ card: Card) -> Binding<Bool> {
        Binding<Bool> (
            get: {
                viewModel.selectedCards.contains(card)
            },
            set: { newValue in
                if newValue {
                    viewModel.selectedCards.append(card)
                } else {
                    viewModel.selectedCards.removeAll(where: { $0 == card })
                }
            }
        )
    }
```

#### *Grid, LazyVGrid*

#### *@Namespace / matchedGeometryEffect() 애니메이션 동기화*
계층이 다른 뷰의 동일한 애니메이션 효과 부여함.

### *Github Actions (CI/CD)*

### *replacingOccurrences()*
문자열 대체(변경) 함수

## 트러블 슈팅

Issue 1. 메인화면의 부자연스러운 애니메이션 
-> 



## 고민한 점(문제 또는 고민 → 해결)
.onAppear()에서 이미지 로딩


