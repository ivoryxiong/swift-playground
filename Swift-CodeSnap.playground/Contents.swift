//: Playground - noun: a place where people can play

import Foundation

class RandomUtils {
    static func unirand(_ n : Int) -> Int {
        #if os(Linux)
            srandom(UInt32(Date().timeIntervalSince1970))
            return Int(rand()%Int32(n))
        #else
            return Int(arc4random_uniform(UInt32(n)))
        #endif
    }
}

//MARK: utils method about sequence
class SequenceUtils {
    //O(n) 生产0到n-1的序列，满足条件: 位于i位置的值不为i
    static func randSeq(_ n : Int) -> [Int] {
        var seq = Array.init((0..<n))
        for i in (0..<n).reversed() {
            let next = RandomUtils.unirand(i)
            let tmp = seq[next]
            seq[next] = seq[i]
            seq[i] = tmp
        }
        return seq
    }
}

class BigInteger {
    var digits : [Int] = []

    init(_ s : String) {
        digits = s.characters.reversed().map({
                c in
                    if let digit = Int(String(c)) {
                        return digit
                    }
                    return 0
        })
    }
    
    static func mul(a : BigInteger, b : BigInteger) -> String {
        let possibleLen = a.digits.count + b.digits.count + 1
        var ans = Array.init(repeating: 0, count: possibleLen)
        for i in 0..<a.digits.count {
            for j in 0..<b.digits.count {
                ans[i+j] += a.digits[i] * b.digits[j]
            }
        }
        for i in 0..<possibleLen {
            if i < possibleLen - 1 {
                ans[i+1] += ans[i] / 10
            }
            ans[i] = ans[i] % 10
        }
        var len = possibleLen
        while(len>0 && ans[len-1] == 0) {
            len = len-1
        }

        let ret = ans.prefix(len).reversed().reduce("", {$0 + String($1)})
        return ret
    }
    
    static func sum(a : BigInteger, b : BigInteger) -> String {
        let possibleLen = max(a.digits.count , b.digits.count) + 1
        var ans = Array.init(repeating: 0, count: possibleLen)
        for i in 0..<possibleLen {
            if i < a.digits.count {
                ans[i] += a.digits[i]
            }
            if i < b.digits.count {
                ans[i] += b.digits[i]
            }
        }
        for i in 0..<possibleLen {
            if i < possibleLen - 1 {
                ans[i+1] += ans[i] / 10
            }
            ans[i] = ans[i] % 10
        }
        var len = possibleLen
        while(len>0 && ans[len-1] == 0) {
            len = len-1
        }
        
        let ret = ans.prefix(len).reversed().reduce("", {$0 + String($1)})
        return ret
        
    }
}

RandomUtils.unirand(100)
