//
//  File.swift
//  TaskRxSwift
//
//  Created by sakiyamaK on 2020/05/30.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//
/*
 イベントを合成する
 */
import UIKit
import RxSwift
import RxCocoa

final class Task3ViewController: UIViewController, UITextFieldDelegate {

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    example1()
    test1()
  }

  private func example1() {

    //(例1) 複数のストリームを合成
    // イメージ的にはor
    // 何かがきたら流れる
    do {
      debugPrint("--- \(#function) 例1 ----")
      let stream1 = Observable.just(1)
      let stream2 = Observable.just(2)
      Observable.merge(stream1, stream2).subscribe(onNext: { v in
        debugPrint(v)
      }).disposed(by: disposeBag)
    }

    //(例2) 複数のストリームの最後に流れたイベントを合体
    // aとbのstreamが(a,b)とひとつのtuppleになる
    do {
      debugPrint("--- \(#function) 例2 ----")
      let stream1 = Observable.just(1)
      let stream2 = Observable.just(2)
      Observable.combineLatest(stream1, stream2).subscribe(onNext: { v in
        debugPrint(v)
      }).disposed(by: disposeBag)
    }
  }

  @IBOutlet private weak var textField1: UITextField! {
    didSet {
      textField1.delegate = self
    }
  }
  @IBOutlet private weak var textField2: UITextField! {
    didSet {
      textField2.delegate = self
    }
  }
  @IBOutlet private weak var label: UILabel!

  private let textField1Relay = BehaviorRelay<String>(value: "")
  private let textField2Relay = BehaviorRelay<String>(value: "")

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == textField1 {
      textField1Relay.accept(textField.text ?? "")
    } else {
      textField2Relay.accept(textField.text ?? "")
    }
    return true
  }


  private func test1() {
    //ふたつのテキストフィールドの文字を合成してlabelに出す
    //textField1.textが "あいうえお"
    //textField2.textが "かきくけこ"
    //なら labelに"あいうえおかきくけこ"
  }
}
