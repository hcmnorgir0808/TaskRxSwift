//
//  Task1ViewController.swift
//  TaskRxSwift
//
//  Created by sakiyamaK on 2020/05/24.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class Task1ViewController: UIViewController {

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    //(例1) 1をストリームに流してコンソールに表示
    debugPrint("--- 例1 ----")
    Observable.just(1).subscribe(onNext: {v in
      debugPrint(v)
      }).disposed(by: disposeBag)


    //(例2) 1をストリームに流して2倍してコンソールに表示
    debugPrint("--- 例2 ----")
    Observable.just(1).map { (v) -> Int in
      v * 2
    }.subscribe(onNext: { (v) in
      debugPrint(v)
    }).disposed(by: disposeBag)

    //(例3) 0~9をストリームに流してコンソールに表示
    debugPrint("--- 例3 ----")
    Observable.from([0,1,2,3,4,5,6,7,8,9]).subscribe(onNext: { (v) in
      debugPrint(v)
    }).disposed(by: disposeBag)

    //(問1)
    // 0~9をストリームに流して、
    // ２倍して
    // 10以下だけコンソールに表示
    debugPrint("--- 問1 ----")
    Observable.from([0,1,2,3,4,5,6,7,8,9])
      //ここに何か操作関数を入れる
      .subscribe(onNext: { (v) in
      debugPrint(v)
    }).disposed(by: disposeBag)

  }
}
