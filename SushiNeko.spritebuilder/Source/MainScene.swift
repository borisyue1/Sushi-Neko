import Foundation

enum Side {
    case Left, Right, None
}
enum GameState {
    case Title, Ready, Playing, GameOver
}
class MainScene: CCNode {
    weak var character: Character!
    weak var piecesNode : CCNode!
    var pieces: [Piece] = []
    var pieceLastSide: Side = .Left
    var piecesIndex = 0
    var gameState : GameState = .Title
    weak var restartButton: CCButton!
    weak var lifeBar: CCSprite!
    weak var tapButtons: CCNode!
    var timeLeft: Float = 5 {
        didSet {
            timeLeft = max(min(timeLeft, 10), 0)
            lifeBar.scaleX = timeLeft / Float(10)
        }
    }
    weak var scoreLabel : CCLabelTTF!
    var score = 0{
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    
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
    func isGameOver() -> Bool {
        var newPiece = pieces[piecesIndex]
        
        if newPiece.side == character.side { triggerGameOver() }
        
        return gameState == .GameOver
    }
    func triggerGameOver(){
        gameState = .GameOver
        restartButton.visible = true
    }
    func restart() {
        var mainScene = CCBReader.load("MainScene") as! MainScene
        mainScene.ready()
        
        var scene = CCScene()
        scene.addChild(mainScene)
        
        var transition = CCTransition(fadeWithDuration: 0.3)
        
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if gameState == .GameOver || gameState == .Title { return }
        if gameState == .Ready { start() }
        let half = CCDirector.sharedDirector().viewSize().width/2
        let touch = touch.locationInWorld().x
        if touch<half {
            character.left()
        }
        else{
            character.right()
        }
        if isGameOver() { return }

        stepTower()
    }
    func start(){
        gameState = .Playing
        tapButtons.runAction(CCActionFadeOut(duration: 0.2))

    }
    func stepTower(){
        var piece = pieces[piecesIndex]
        var yDiff = piece.contentSize.height * 10
        piece.position = ccpAdd(piece.position, CGPoint(x: 0, y: yDiff))
        piece.zOrder += 1
        pieceLastSide = piece.setObstacle(pieceLastSide)
        piecesNode.position = ccpSub(piecesNode.position, CGPoint(x: 0, y: piece.contentSize.height))
        piecesIndex = (piecesIndex + 1) % 10
        if isGameOver() { return }
        timeLeft = timeLeft + 0.25
        score++

    }
    override func update(delta: CCTime) {
        if gameState != .Playing { return }
        timeLeft -= Float(delta)
        if timeLeft == 0 {
            triggerGameOver()
        }
    }
    func ready() {
        gameState = .Ready
        
        self.animationManager.runAnimationsForSequenceNamed("Ready")
        
        tapButtons.cascadeOpacityEnabled = true
        tapButtons.opacity = 0.0
        tapButtons.runAction(CCActionFadeIn(duration: 0.2))
    }
}
