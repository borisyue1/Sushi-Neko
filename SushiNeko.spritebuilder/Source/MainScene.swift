import Foundation

enum Side {
    case Left, Right, None
}
class MainScene: CCNode {
    weak var character: Character!
    weak var piecesNode : CCNode!
    var pieces: [Piece] = []
    var pieceLastSide: Side = .Left
    var piecesIndex = 0
    
    func didLoadFromCCB(){
        userInteractionEnabled = true
        for var s = 0; s<10; ++s {
            var piece = CCBReader.load("Piece") as! Piece
            pieceLastSide = piece.setObstacle(pieceLastSide)
            var yPos = piece.contentSizeInPoints.height * CGFloat(s)
            piece.position = CGPointMake(0, yPos)
            pieces.append(piece)
            piecesNode.addChild(piece)
            
        }
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        let half = CCDirector.sharedDirector().viewSize().width/2
        let touch = touch.locationInWorld().x
        if touch<half {
            character.left()
        }
        else{
            character.right()
        }
        stepTower()
    }
    func stepTower(){
        var piece = pieces[piecesIndex]
        var yDiff = piece.contentSize.height * 10
        piece.position = ccpAdd(piece.position, CGPoint(x: 0, y: yDiff))
        piece.zOrder += 1
        pieceLastSide = piece.setObstacle(pieceLastSide)
        piecesNode.position = ccpSub(piecesNode.position, CGPoint(x: 0, y: piece.contentSize.height))
        piecesIndex = (piecesIndex + 1) % 10
    }
}
