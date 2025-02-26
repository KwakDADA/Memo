# 제목 없음

# Memo

Memo는 사용자가 메모를 추가하고 삭제할 수 있는 간단한 앱입니다.

UserDefaults를 통해 메모 데이터를 영구 저장하며, 커스텀 뷰와 컨트롤러를 통해 메모 목록을 관리합니다.

## 주요 기능

- **메모 추가:**
    
    네비게이션 바 우측의 "+" 버튼을 눌러 Alert를 띄우고, 텍스트 필드를 통해 새 메모를 입력합니다.
    
- **메모 삭제:**
    
    테이블 뷰에서 스와이프하여 메모를 삭제할 수 있습니다.
    
- **데이터 영속성:**
    
    저장소(MemoStorage)를 통해 메모 데이터가 UserDefaults에 저장되어, 앱 종료 후에도 데이터를 유지합니다.
    

## 프로젝트 구조

### Model

- **Memo:**
    - `content`: 메모의 내용을 저장합니다.
- **MemoList:**
    - `list`: 여러 Memo를 담는 배열입니다.
    - `add(_:)`: 새로운 Memo를 목록에 추가합니다.
    - `delete(_:)`: 지정한 인덱스의 Memo를 삭제합니다.

### View

- **MemoListView:**
    - 화면 전체를 차지하는 테이블 뷰를 포함하는 커스텀 뷰입니다.
    - Auto Layout을 사용하여 안전 영역에 맞춰 배치됩니다.

### Controller

- **MemoViewController:**
    - MemoList(모델)와 MemoListView(뷰) 사이의 중재자 역할을 수행합니다.
    - 네비게이션 바의 "+" 버튼을 눌러 `didTapAddButton()`를 호출하면, Alert를 통해 새 메모를 추가합니다.
    - 모델 업데이트와 UI 업데이트를 적절히 분리하여 코드 중복과 업데이트 누락 위험을 최소화합니다.

### Persistence

- **MemoStorage:**
    - UserDefaults를 이용하여 MemoList 데이터를 저장하고 불러오는 기능을 제공합니다.

### Extensions & Constants

- **UIViewController+Alert:**
    - 텍스트 필드가 포함된 Alert를 생성하는 헬퍼 메서드를 제공합니다.
- **ReuseIdentifiers:**
    - 테이블 뷰 셀의 재사용 식별자(예: `MemoCell`)를 중앙 집중화하여 관리합니다.
- **AlertConstants:**
    - Alert에 사용되는 제목, 플레이스홀더, 버튼 타이틀 등 UI 문자열을 상수로 관리합니다.