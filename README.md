# 📚 Book Finder App

> 프로젝트 기간 2022-09-06 ~ 2022-09-09

## 프로젝트 소개
📚[구글 북스 API](https://developers.google.com/books/docs/overview)를 이용한 도서 검색 어플

## 실행 화면
![Simulator Screen Recording - iPhone SE (3rd generation) - 2022-09-09 at 03 03 49](https://user-images.githubusercontent.com/82325822/189207911-6a63f1fb-bc15-46b8-b4c6-b6c1b4cdb0a1.gif)

## 기능 구현
- 사용자가 검색어를 검색하면 특정 데이터(Title, Author, Published Date, Picture 등)가 포함된 책 목록을 반환하는 API를 호출
- URLSession을 이용한 비동기 네트워크 통신
- JSONDecoder, Codable(Decodable만 이용)을 이용한 데이터 파싱
- NSCache를 통한 이미지 캐싱
- RxSwift를 이용한 MVVM 패턴 구현

## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.3.1-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.0-skyblue)]()

## 🚀 Trouble Shooting

### 📌 1. 네트워크 상태와 무관한 유닛테스트
- 서버 통신 어플이 네트워크 상태와 무관?!
- 무슨 뚱딴지 같은 소리지.. 할 수 있겠지만 이는 실제 서버를 이용하면서 서버에 과부화를 주는 혹은 네트워크 상태에 따라 정확하지 않은 결과 값을 얻을 수 있기 때문에 실제로 서버와 통신하는 딱 그 부분만 가짜 객체로 교체해 테스트를 진행한다고 한다
(사실 이전에 한 번 해본 적이 있어서 했다가 맞겠지만 잘 기억이 나지 않아 이번 프로젝트를 진행하면서 다시 한번 제대로 되짚어 보고 공부했다)
- 이 내용을 이 곳에 쓰기에는 너무 길어 해당 내용에 대해 TIL을 작성한 블로그 링크로 대신한다
> [Blog Post Link](https://velog.io/@doogie97/220909-TIL-%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC-%EC%97%86%EC%9D%B4-URLSession-%EC%9C%A0%EB%8B%9B-%ED%85%8C%EC%8A%A4%ED%8A%B8-%ED%95%98%EA%B8%B0)
> [Issue Link](https://github.com/doogie97/Book-Finder-App/issues/17)

### 📌 2. RxSwift를 이용해 비동기 데이터를 리턴 값으로 활용하기
- 지금까지는 동기, 비동기 처리 위치만 파악하면 굳이 리턴 값으로 받지 않아도 불편하지 않아 비동기를 리턴 값으로 받는 방식의 필요성을 느끼지 못했다
- 근데 리턴 값으로 받는 방법을 알고 사용하지 않는 것과 몰라서 사용하지 못하는 것은 아주 큰 차이가 있다고 생각해 이번 프로젝트에 적용해 봤으나...
- 처음 적용하는 거다 보니 부족한 부분이 많아서 그런지는 모르겠지만 느껴진 장점은 딱 하나였다 -> 어디서 비동기 처리가 되건 신경 쓰지 않고 사용하는 곳에서만 메인쓰레드로 변경해 주면 된다는 것
- 그 외에는 기존 비동기 방식으로 사용할 때와 비교해서 불필요한 import나 프로퍼티 생성, 뷰에서 해야 할 에러 처리가 늘어나 불편하기도 하고 바꾼 방식에 대해 확신이 들지 않아 다시 기존 방식 대로 진행하기로 했다

>[branch](https://github.com/doogie97/Book-Finder-App/tree/NetworkHandler-return-Observable)
>[Issue Link](https://github.com/doogie97/Book-Finder-App/issues/8)

### 📌 3. API가 제공하는 모든 정보 받아오기 vs 화면에 표시할 정보만 받아오기
- 지금까지 codable을 이용해 파싱을 하려면 서버에서 주는 데이터와 내가 만든 모델의 데이터 형태가 일치해야만 사용할 수 있는 줄 알았다(예를 들면 내가 사용할 데이터는 3개지만 서버가 100개를 보내준다면 어쩔 수 없이 100개의 데이터를 갖고 있는 모델을 만들고 그중에서 3개만 꺼내 쓰는...)
- 그런데 테스트 코드를 작성 중 우연치 않게 내가 작성하지 않은(빼먹은..), 서버에서는 뿌려주는 데이터에 대해 판단하는 코드를 작성하게 됐는데 그럼에도 다른 데이터들을 가져오는 상황이 있었다(왜 지금까지 모르고 힘들게 살아왔는데..😭)
- 그래서 고민한 점은 혹시라도 언제 사용할지 모르는 데이터들을 미리 가져오는 것이냐 아니면 지금 당장 필요한 데이터만 가져오는 것이냐를 고민했는데
-> 굳이 불필요한 정보들을 주고받을 필요가 없다고 느꼈으며 새로운 정보가 필요하다면 프로퍼티 하나 정도만 추가하면 되니 화면에 표시할 정보들만 받아오기로 결정

>[Issue Link](https://github.com/doogie97/Book-Finder-App/issues/2)

### 📌 4. 약한 참조를 위해 [weak self]를 사용하고 그 로직 안에서 self를 옵셔널 바인딩을 하면 무용지물?
```swift
mainView.bookListCollectionView.rx.prefetchItems.bind(onNext: { [weak self] in
    print(CFGetRetainCount(self)) // rc 확인
    guard let self = self else {
        return
    }
    print(CFGetRetainCount(self)) // rc 확인
    if $0.last?.row == self.viewModel.items.value.count - 1 {
        
    }
})
.disposed(by: disposeBag)
```
- 위와 같이 RxSwift 사용 시 발생하는 RC 증가를 막기 위해 [weak self] 키워드를 사용해놓고 내부에서 사용이 편하기 위해 해당 self를 옵셔널 바인딩을 했었다
- 그런데 문득 약한 참조를 해놓고 이걸 다시 옵셔널 바인딩을 하면 RC 결국 늘어나는 게 아닐까? 하는 의문이 들어 실험해 봤는데

![](https://i.imgur.com/93B2yNX.png)

... 늘어난다

```swift
mainView.bookListCollectionView.rx.prefetchItems.bind(onNext: { [weak self] in
    print(CFGetRetainCount(self)) // rc 확인
    guard let itemsCount = self?.viewModel.items.value.count else {
        return
    }
    
    print(CFGetRetainCount(self)) // rc 확인
    if $0.last?.row == itemsCount - 1 {
        
    }
})
.disposed(by: disposeBag)
```
반면 위와 같이 self에 대해서 옵셔널 바인딩을 하는 것이 아닌 self는 옵셔널 값 그대로 두고 count에 대해서만 옵셔널 바인딩을 한 경우에는

![](https://i.imgur.com/QaJtxbU.png)

RC가 늘어나지 않는 것을 확인했다

>[Issue Link](https://github.com/doogie97/Book-Finder-App/issues/3)

### 📌 5. API 요청 시 쿼리에 따라 totalItems의 수가 바뀌는 현상
![](https://i.imgur.com/gaYuFi3.png)

![](https://i.imgur.com/1WCVMOi.png)

![](https://i.imgur.com/4q53TID.png)

위와 같이 동일 검색 조건에 startIndex만 다르게 했을 뿐인데 totalItems의 차이가 엄청난 걸 볼 수 있다
(다른 쿼리도 마찬가지)

심지어

![](https://i.imgur.com/Qv5dujD.png)

![](https://i.imgur.com/udlVb4Z.png)

아예 동일한 URL을 넣어도 그 수치가 바뀐다...

이 부분은 API의 문제가 아닐까..? 하는 조심스러운 추측과 함께 일단 넘겨둔 상태이다
(누군가 이 글을 보고 저의 잘못을 찾게 된다면 알려주세요 ㅠㅠ)

>[Issue Link](https://github.com/doogie97/Book-Finder-App/issues/13)


## 🤔 이번 프로젝트를 통한 가장 큰 깨달음
- 이번 프로젝트를 하면서 누군가가 내 코드를 보고 질문한다고 가정했을 때 질문을 할 것 같은 부분에 대해 모조리 다 메모장에 정리를 해보며 프로젝트를 진행했다
- 그 결과 나름 `나는 항상 이유있는 코드를 작성하는 사람이야!` 하고 살아왔는데... 그것은 정말 자만한 생각이었다는 것을 깨달았다
- 위 과정을 통해 이미 알고 있는 내용도 한 번 더 짚고 넘어가고 몰랐던 부분도 계속 공부하게 되니 앞으로도 스스로에게 계속 질문을 던지며 내용들을 정리하면서 진행하려고 한다


## 커밋 룰
💎feat : 새로운 기능 구현

✏️chore : 사소한 코드 수정, 내부 파일 수정, 파일 이동 등

🔨fix : 버그, 오류 해결

📝docs : README나 WIKI 등의 문서 개정

♻️refactor : 수정이 있을 때 사용 (이름변경, 코드 스타일 변경 등)

⚰️del : 쓸모없는 코드 삭제

🔬test : 테스트 코드 수정
