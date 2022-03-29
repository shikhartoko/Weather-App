//
//  Box.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

final class Box<T> {
  //1 giving an alias to a closure such that it accepts a template field and returns nothing
  typealias Listener = (T) -> Void
  
  // creating a var of type optional listener
  var listener: Listener?
  //2
  var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  init(_ value: T) {
    self.value = value
  }
  //4
  func bind(listener: Listener?) {
    // make listener equal to listener clousre given
    self.listener = listener
      // call the listener closure
    listener?(value)
  }
}
