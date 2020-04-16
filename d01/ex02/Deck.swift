import Foundation

class Deck : NSObject
{
    static let allSpades	: [Card] = Value.allValues.map({Card(Color:Color.Spade, Value:$0)})
    static let allDiamonds	: [Card] = Value.allValues.map({Card(Color:Color.Diamond, Value:$0)})
    static let allHearts	: [Card] = Value.allValues.map({Card(Color:Color.Heart, Value:$0)})
    static let allClubs		: [Card] = Value.allValues.map({Card(Color:Color.Club, Value:$0)})
    
    static let allCards		: [Card] = allSpades + allDiamonds + allHearts + allClubs
}