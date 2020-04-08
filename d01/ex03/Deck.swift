import Foundation

class Deck : NSObject
{
    static let allSpades : [Card] = Value.allValues.map({Card(Color:Color.Spade, Value:$0)})
    static let allDiamonds : [Card] = Value.allValues.map({Card(Color:Color.Diamond, Value:$0)})
    static let allHearts : [Card] = Value.allValues.map({Card(Color:Color.Heart, Value:$0)})
    static let allClubs	: [Card] = Value.allValues.map({Card(Color:Color.Club, Value:$0)})
    static let allCards	: [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
mutating func shuffle() {
    if (count < 2) { return }
    for i in 0..<count {
        let j = Int(arc4random_uniform(UInt32(count)))
        if (i != j) {
            self.swapAt(i, j)
        }
    }
}
}
