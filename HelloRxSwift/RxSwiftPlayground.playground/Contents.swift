import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["Item 1"])

relay.accept(relay.value + ["Item 2"])

relay.asObservable()
    .subscribe{
        print($0)
}

