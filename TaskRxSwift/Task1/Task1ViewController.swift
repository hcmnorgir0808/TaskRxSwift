//
//  Task1ViewController.swift
//  TaskRxSwift
//
//  Created by sakiyamaK on 2020/05/24.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//
/*
 RxSwiftのHello world的なやつ
 イベントを流してオペレータで操作して実行(購買)までやる
 */

import UIKit
import RxSwift
import RxCocoa

final class Task1ViewController: UIViewController {

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    example1()
    test1()
    example2()
    test2()
  }

  private func example1() {
    do {

      //(例1) イベント(この場合1)をストリームに流してコンソールに表示
      debugPrint("--- \(#function) 例1 ----")
      Observable.of("Hello World")
        .subscribe(onNext: { value in
          debugPrint(value)
        })
        .disposed(by: disposeBag)
    }

    do {
      //(例2) イベント(この場合1)をストリームに流して2倍してコンソールに表示
      debugPrint("--- \(#function) 例2 ----")
      Observable.of(1)
        .map { v -> Int in
          v * 2
      }.subscribe(onNext: { v in
        debugPrint(v)
      }).disposed(by: disposeBag)
    }

    do {
      //(例3) イベント(0~4)をストリームに流してコンソールに表示
      debugPrint("--- \(#function) 例3 ----")
      Observable.of(0,1,2,3,4)
        .subscribe(onNext: { v in
          debugPrint(v)
        }).disposed(by: disposeBag)
    }
  }

  private func test1() {
    //(問1)
    // 0~4をストリームに流して、
    // ２倍して
    // 5以下だけコンソールに表示
    // https://rxmarbles.com/ から目的のオペレータを探してみよう
    debugPrint("--- \(#function) 問1 ----")
    Observable.from([0,1,2,3,4])
      //ここに何か操作関数を入れる
      .subscribe(onNext: { v in
        debugPrint(v)
      }).disposed(by: disposeBag)
  }

  private func example2() {
    do {
      //(例1)
      //完了イベントをストリームに流す
      debugPrint("--- \(#function) 例1 ----")

      let observable = Observable.from([0,1,2,3,4])

      observable.subscribe(onNext: { v in
        debugPrint("success: \(v)")
      }, onCompleted: {
        debugPrint("completion")
      }).disposed(by: disposeBag)

      //全てのストリームが流れ終わるとcompletion
    }

    do {
      //(例2)
      debugPrint("--- \(#function) 例2 ----")

      //例外イベントをストリームに流す
      let observable = Observable.from([0,1,2,3,4,5,6])

      observable.do(onNext: { v in //doメソッドはストリームが流れたら処理を挟む
        if v == 4 { throw NSError.init(domain: "error", code: 0, userInfo: nil) }
      }).subscribe(onNext: { v in
        debugPrint("success: \(v)")
      }, onError: { e in
        debugPrint("error: \(e)")
      }, onCompleted: {
        debugPrint("completion")
      }).disposed(by: disposeBag)

      //completionは流れず、errorで終わる
    }
  }

  private func test2() {
    //(問1)
    // ランダムな数値をストリームに流して、表示してcompletionかerrorにする
    debugPrint("--- \(#function) 問1 ----")
    //1度だけストリームを流して終了させる処理を10回テスト
    for _ in 0...10 {
      //0~10をランダムに出すストリーム
      let observable = Observable.of(Int.random(in: 0...10))

      observable
        //ここに何か操作関数を入れて意図的にエラーを出す
        .subscribe(onNext: { v in
          debugPrint(v)
        }
          //ここに何かクロージャーを入れてエラーの時と完了の時に処理をする
      ).disposed(by: disposeBag)
    }
  }
}


