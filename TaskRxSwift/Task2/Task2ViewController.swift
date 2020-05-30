//
//  Task2ViewController.swift
//  TaskRxSwift
//
//  Created by sakiyamaK on 2020/05/24.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//
/*
イベントを受け取る・流す
 */

import UIKit
import RxSwift
import RxCocoa

final class Task2ViewController: UIViewController, UITextFieldDelegate {

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    example1()
    example2()
    test2()
  }

  private func example1() {

    //Task1のObservableクラスはイベントを流すことはできるが他からイベントを受け取ることができない
    // 以下の４つはイベントを受け取り、流すことができる
    // 全部自分で流したイベントを自分で受け取っている
    do {
      debugPrint("--- \(#function) 例1 ----")
      //初期値がない
      //onNext, onCompletion, onErrorがある
      let ps = PublishSubject<Int>()

      //イベントを受け取る処理 (今回completionとerrorは記述してない
      ps.subscribe(onNext: { (v) in
        debugPrint("PublishSubject: \(v)")
      }).disposed(by: disposeBag)

      //イベントを流す
      ps.onNext(1)
      ps.onNext(2)
      //好きなタイミングで何回でもイベントを流せる
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        ps.onNext(3)
      }
    }

    do {
      debugPrint("--- \(#function) 例2 ----")
      //初期値がある
      //onNext, onCompletion, onErrorがある
      let bs = BehaviorSubject<Int>(value: 0)

      //イベントを受け取る処理 (今回completionとerrorは記述してない
      bs.subscribe(onNext: { (v) in
        debugPrint("BehaviorSubject: \(v)")
      }).disposed(by: disposeBag)

      //イベントを流す
      bs.onNext(1)
      bs.onNext(2)
      //好きなタイミングで何回でもイベントを流せる
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        bs.onNext(3)
      }
    }

    do {
      debugPrint("--- \(#function) 例3 ----")
      //初期値がない
      //onNextがある
      //onCompletion, onErrorがない
      let pr = PublishRelay<Int>()

      //イベントを受け取る処理 (今回completionとerrorは記述してない
      pr.subscribe(onNext: { (v) in
        debugPrint("PublishRelay: \(v)")
      }).disposed(by: disposeBag)

      //イベントを流す (なぜかSubjectたちとメソッド名が違う
      pr.accept(1)
      pr.accept(2)
      //好きなタイミングで何回でもイベントを流せる
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        pr.accept(3)
      }
    }

    do {
      debugPrint("--- \(#function) 例4 ----")
      //初期値がある
      //onNextがある
      //onCompletion, onErrorがない
      let pr = BehaviorRelay<Int>(value: 0)

      //イベントを受け取る処理 (今回completionとerrorは記述してない
      pr.subscribe(onNext: { (v) in
        debugPrint("BehaviorRelay: \(v)")
      }).disposed(by: disposeBag)

      //イベントを流す (なぜかSubjectたちとメソッド名が違う
      pr.accept(1)
      pr.accept(2)
      //好きなタイミングで何回でもイベントを流せる
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        pr.accept(3)
      }
    }
  }

  @IBOutlet private weak var textField: UITextField! {
    didSet {
      textField.delegate = self
    }
  }
  @IBOutlet private weak var label: UILabel!

  private let textFieldRelay = BehaviorRelay<String>(value: "")

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //test2でこのイベントを受け取っている
    textFieldRelay.accept(textField.text ?? "")
    return true
  }

  private func example2() {
    do {
      debugPrint("--- \(#function) 例1 ----")
      //テキストフィールドのストリームから値を受け取りストリームに流す
      textFieldRelay
        .asObservable() //relayをobservableに変換する(なくても動くけど明示しといた方が安全
        .subscribeOn(MainScheduler.instance) //問1で使うから書いておくけどsubscribeをメインスレッドで処理する
        .subscribe(onNext: { (str) in
        debugPrint(str)
      }).disposed(by: disposeBag)
    }
  }

  private func test2() {
    debugPrint("--- \(#function) 問1 ----")
    //テキストフィールドのストリームから受け取った値をlabelのテキストにする
  }
}
