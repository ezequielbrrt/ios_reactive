//: A UIKit based Playground for presenting user interface
  
import UIKit
import RxSwift
import PlaygroundSupport

/*
 FILTER OPERATOS
 */

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

// IGNORE
func ignore() {
    strikes
        .ignoreElements()
        .subscribe { _ in
            print("Subscription is called")
        }
        .disposed(by: disposeBag)

    strikes.onNext("A")
    strikes.onNext("B")
    strikes.onNext("C")

    strikes.onCompleted()

}


// ELEMENT AT
func elementAt() {
    strikes.elementAt(2)
        .subscribe(onNext: { _ in
            print("You are out")
        })
        .disposed(by: disposeBag)
    strikes.onNext("A")
    strikes.onNext("B")
    strikes.onNext("C")
}

// FILTER
func filter() {
    Observable.of(1,2,3,4,5,6,7)
        .filter { $0 % 2 == 0 }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

// SKIP
func skip() {
    Observable.of("A","B","C","D","E")
        .skip(3)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

// SKIP WHILE
func skipWhile() {
    Observable.of(2,3,4,5,6,6)
        .skipWhile { $0 % 2 == 0 }
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
}


// SKIP UNTIL
func skipUntil() {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    subject.skipUntil(trigger)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
    
    subject.onNext("A")
    subject.onNext("B")
    
    trigger.onNext("X")
    
    subject.onNext("C")
    
}


// TAKE
func take() {
    Observable.of(1,2,3,4,5,6)
        .take(3)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

// TAKE WHILE
func takeWhile() {
    Observable.of(2,4,6,7,8,9)
        .takeWhile { $0 % 2 == 0 }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

// TAKE UNTIL
func takeUntil() {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject.takeUntil(trigger)
        .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
    subject.onNext("1")
    subject.onNext("2")
    trigger.onNext("X")
    subject.onNext("3")
}
