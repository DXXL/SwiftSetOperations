// SetOperators.swift
// Code from https://gist.github.com/akosma/07249e6718ace1ba6066 updated to actual swift syntax
// Davis Riedel

import Foundation

// The empty set
fileprivate let Ø = Set<AnyHashable>()

// The "Universal" set
fileprivate var U = Set<AnyHashable>()

// Creation operators
// Every time a new set is created, we add its contents to the
// universal set created above
prefix operator ⟨
postfix operator ⟩

prefix func ⟨ (array: [AnyHashable]) -> Set<AnyHashable> {
    U = Set<AnyHashable>(array)
    return U
}

postfix func ⟩ (array: [AnyHashable]) -> [AnyHashable] {
    return array
}

// Intersection
precedencegroup IntersectionPrecendence {
    associativity: left
    higherThan: DefaultPrecedence
}

infix operator ∩ : IntersectionPrecendence

func ∩ (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Set<AnyHashable> {
    return s1.intersection(s2)
}

// Union
infix operator ∪ : DefaultPrecedence

func ∪ (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Set<AnyHashable> {
    return s1.union(s2)
}

// Belongs
infix operator ∈

func ∈ (obj: AnyHashable, set: Set<AnyHashable>) -> Bool {
    return set.contains(obj)
}

// Does not belong
infix operator ∉

func ∉ (obj: AnyHashable, set: Set<AnyHashable>) -> Bool {
    return !(obj ∈ set)
}

// Subset
infix operator ⊆

func ⊆ (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Bool {
    return s1.isSubset(of: s2)
}

// Cardinality
prefix operator |

prefix func | (set: Set<AnyHashable>) -> Int {
    return set.count
}

postfix operator |

postfix func | (set: Set<AnyHashable>) -> Set<AnyHashable> {
    return set
}

// Relative complement
infix operator ∖ : DefaultPrecedence

func ∖ (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Set<AnyHashable> {
    var mutable = s1
    for obj in s2 {
        mutable.remove(obj)
    }
    return mutable
}

// Absolute complement
postfix operator ∼

postfix func ∼ (set: Set<AnyHashable>) -> Set<AnyHashable> {
    return U ∖ set
}

// Symmetric difference
infix operator ∆

func ∆ (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Set<AnyHashable> {
    return (s1 ∖ s2) ∪ (s2 ∖ s1)
}

// Equality
func == (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Bool {
    return s1.elementsEqual(s2)
}

// Inequality
func != (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Bool {
    return !s1.elementsEqual(s2)
}

// Cartesian product
precedencegroup CartesianPrecendence {
    associativity: left
    higherThan: DefaultPrecedence
}

infix operator × : CartesianPrecendence

func × (s1: Set<AnyHashable>, s2: Set<AnyHashable>) -> Set<AnyHashable> {
    var result = Set<AnyHashable>()
    for obj1 in s1 {
        for obj2 in s2 {
            result.insert(obj1)
            result.insert(obj2)
        }
    }
    return result
}
