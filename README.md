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

### Issue 1. 메인화면의 부자연스러운 애니메이션 
Core Data를 사용하기 때문에 Data -> Image 변환을 위해서 Data -> UIImage -> Image 이 과정을 거쳤습니다.
문제는 CardView를 만들 때 UIImage -> Image 변환 과정을 거쳐야해서 미세한 딜레이가 생기고 이 과정에서 부자연스러운 애니메이션이 생기는 것으로 추정했습니다.
그래서 임의로 Image 배열 자체를 ViewModel이 가지게 만들어서 Image가 바로 삽입하게 수정했습니다.

하지만 ViewModel이 Image를 가지고 있는것은 MVVM 답지 않다는 생각을 하여 이 부분을 추후 수정하고자 합니다.


## 고민한 점(문제 또는 고민 → 해결)
.onAppear()에서 이미지 로딩


