# TheMovieDBKobe

This project uses CocoaPods. Please use "pod install" at the project root folder.
The code architecture is MVVM with RxSwift.

# Pods for ChallengeKobe

pod 'Alamofire'
Alamofire is used to make requests in a simple way.

pod 'AlamofireObjectMapper'
AlamofireObjectMapper is used to map the  json from the api into a model in a simple way

pod 'AlamofireImage'
AlamofireImage is used to make asynchonous request for images. It also handles image caching, so it prevents make unnecessary downloads all the time and makes the app runs so much faster

pod 'RxSwift'
Used for reactive programming

pod'RxCocoa'
Used for reactive programming with native components
