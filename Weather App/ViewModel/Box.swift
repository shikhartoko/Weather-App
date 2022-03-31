//
//  Box.swift
//  Weather App
//
//  Created by Shikhar Sharma on 22/03/22.
//

import Foundation

final class Box<T> {
  internal typealias Listener = (T) -> Void
  
  internal var listener: Listener?
  internal var value: T {
    didSet {
      listener?(value)
    }
  }
  internal init(_ value: T) {
    self.value = value
  }
  internal func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
