# FirebasePractice

* Firebase 예제 및 연습 Repository

## Firebase

* Google에서 만든 앱 및 웹을 위한 Back-End로 활용할 수 있음.
* Real-time Database를 이용해서 실시간으로 데이터를 CRUD할수 있음.
* 그 외에 여러 기능이 있다.
* [Firebase link](https://firebase.google.com/)


## Firebase 초기 세팅

1. [Google Account](https://support.google.com/mail/answer/56256?hl=ko) 만들고 [firebase site](https://firebase.google.com/)에 접속
2. 상단 우측에 __Go to console__로 감
3. 프로젝트 추가
4. 프로젝트 이름 작성 및 내용을 읽고 __프로젝트 만들기__ 버튼을 누름 -> 프로젝트 생성됨
5. __계속__ 버튼 누름 -> 새로운 프로젝트 화면이 만들어짐
6. iOS App을 개발할 경우 Xcode에서 프로젝트 작성하고 BundleID 복사
7. 콘솔에서 iOS 버튼을 누름 -> 화면이 전환됨
8. iOS 번들 ID 등록하고 앱 등록을 누름
9. 구성 파일 (GoogleService-Info.plist)을 다운로드하여 Xcode Project에서 info.plist file아래에 복사해서 붙어넣음.
10. 다음 버튼을 누름
11. Firebase SDK 추가
    * CocoaPods을 이용해서 SDK 설치
    * Terminal 창에서 다음과 같이 작성
       1. `$ pod init`
       2. Pod file 이 만들어지면 열어서 `pod 'Firebase/Core` 추가
       3. 파일을 저장한후 터미널에서 `$ pod install`함.
       4. `projectName.xcworkspace` file이 생성됨
12. 다음 버튼을 누름
13. 초기화 코드 추가
   * 아래 코드와 같이 AppDelegate file에서 `import Firebase` 함.
   * `application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool`에 `FirebaseApp.configure()` 추가함.

```Swift
import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    FirebaseApp.configure()
    
    return true
  }
```

14. 다음 버튼을 누르고 앱을 실행하여 설치 확인에서 계속 진행중이면 "이 단계 건너뛰기"  버튼을 누름.
 

## 실시간 데이터베이스에서 데이터 읽어 오기

### iOS에서 설치 및 설정

1. Firebase SDK 설치
2. Firebase Console에서 Firebase 프로젝트에 App을 추가함.
3. App에 Firebase 실시간 데이터베이스 추가
   
   __PodFile__
   
   ```
   pod 'Firebase/Database'
   pod 'Firebase/Analytics'
   ```
   
4. [참고](https://firebase.google.com/docs/database/ios/start?hl=ko) 

* Reference : DB의 Ref 지정
	
	```Swift
	var ref: DatabaseReference!
	ref = Database.database().reference()
	```

* 데이터 1번 불러오기 : DB에서 데이터를 1번 불러올 때 사용하는 예
	
	

	```Swift
	let userID = Auth.auth().currentUser?.uid
	ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
	  // Get user value
	  let value = snapshot.value as? NSDictionary
	  let username = value?["username"] as? String ?? ""
	  let user = User(username: username)
	
	  // ...
	  }) { (error) in
	    print(error.localizedDescription)
	}
	```

* 실시간으로 변화되는 데이터 불러오기 : DB에서 데이터가 바뀔 때 마다 앱에 반영함.

	```Swift
	refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
	  let postDict = snapshot.value as? [String : AnyObject] ?? [:]
	  // ...
	})
	```

* update method

  - `updateChildValue`를 이용해서 update 할 수 있음.


	```Swift
	func updateChild() {
   		let ref = Database.database().reference()
	    ref.updateChildValues(["test": "Update Hello world!"])
   }
	```