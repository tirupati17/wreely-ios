//
//  WSFunctional.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 03/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

//infix operator >>> { associativity left precedence 150 } // bind ------ old way operator declaration (follow new way below)

precedencegroup AssignmentPrecedence {
    associativity: left
}

/*
 Monads have a bind operator which, when used with optionals, allows us to bind an optional with a function that takes a non-optional and returns an optional. If the first optional is .none then it returns .none, otherwise it unwraps the first optional and applies the function to it.
 */
infix operator >>> : AssignmentPrecedence // Monads

/*
<$> takes a function taking an a and returning a b, and a functor that contains an a, and it returns a functor that contains a b. So <$> is the same as fmap :: (a -> b) -> f a -> f b
*/
infix operator <^> : AssignmentPrecedence  // Functor's fmap (usually <$>)

/*
<*> takes a functor that contains a function taking an a and returning a b, and a functor that contains an a, and it returns a functor that contains a b. So <*> kind of extract the function from a functor and applies it to an arguments also inside a functor, and finally returns the result into a functor
*/
infix operator <*> : AssignmentPrecedence  // Applicative's apply

func >>><A, B>(a: A?, f: (A) -> B?) -> B? {
    if let x = a {
        return f(x)
    } else {
        return .none
    }
}

func <^><A, B>(f : (A) -> B, a : A?) -> B? {
    if let x = a {
        return f(x)
    } else {
        return .none
    }
}

func <*><A, B>(f : ((A) -> B)?, a : A?) -> B? {
    if let x = a {
        if let fx = f {
            return fx(x)
        }
    }
    return .none
}
