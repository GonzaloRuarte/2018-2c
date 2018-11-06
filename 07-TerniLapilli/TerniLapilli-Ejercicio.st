!classDefinition: #GameState category: #'TerniLapilli-Ejercicio'!
Object subclass: #GameState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameState methodsFor: 'initialization - private' stamp: 'GR 11/2/2018 02:10:26'!
initializeWith: aTerniLapilli

	terniLapilli:= aTerniLapilli.! !


!GameState methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:17'!
doesOMoveNext

	^false! !

!GameState methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:23'!
doesOPlaceNext

	^false! !

!GameState methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:29'!
doesXMoveNext

	^false! !

!GameState methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:35'!
doesXPlaceNext

	^false! !

!GameState methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:39'!
isFinished

	^false! !


!GameState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:59:34'!
activePlayerWon
	self subclassResponsibility ! !

!GameState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:37:56'!
currentPlayer

	self subclassResponsibility ! !

!GameState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 21:37:25'!
currentPlayerTokensPositions

	self subclassResponsibility ! !

!GameState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:44:16'!
movingTokenAt: aPosition to: anotherPosition

	self subclassResponsibility ! !

!GameState methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:54:03'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

!GameState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:06:02'!
winner
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameState class' category: #'TerniLapilli-Ejercicio'!
GameState class
	instanceVariableNames: ''!

!GameState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:09:46'!
for: aTerniLapilli
	^self new initializeWith: aTerniLapilli .! !

!GameState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:12:40'!
isFor: aTokenCount

	self subclassResponsibility ! !


!classDefinition: #OActivePlayer category: #'TerniLapilli-Ejercicio'!
GameState subclass: #OActivePlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:10:19'!
activePlayerWon

	terniLapilli theWinnerIs: OWon! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:42:49'!
currentPlayer

	^terniLapilli playerO! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 21:35:27'!
currentPlayerTokensPositions
	^terniLapilli  oTokensPositions ! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:44:22'!
movingTokenAt: aPosition to: anotherPosition

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:43:46'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:06:13'!
winner
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OActivePlayer class' category: #'TerniLapilli-Ejercicio'!
OActivePlayer class
	instanceVariableNames: ''!

!OActivePlayer class methodsFor: 'instance creation - private' stamp: 'GR 11/5/2018 17:47:28'!
isFor: aTokenCount

	self subclassResponsibility ! !


!classDefinition: #OMovesTokenNext category: #'TerniLapilli-Ejercicio'!
OActivePlayer subclass: #OMovesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 21:34:53'!
movingTokenAt: aPosition to: anotherPosition

	
	(terniLapilli isXTokenAt: aPosition) ifTrue: [terniLapilli tokenOwnershipError].
	
	terniLapilli safelyRemoveTokenAt: aPosition belongingTo: terniLapilli oTokensPositions.
	terniLapilli safelyPlaceTokenAt: anotherPosition belongingTo: terniLapilli oTokensPositions.
	terniLapilli changeTo: (XMovesTokenNext for: terniLapilli).! !

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/6/2018 00:23:14'!
placingTokenAt: aPosition
	
	terniLapilli shouldNotPlaceError! !

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:07:11'!
winner
	
	^terniLapilli noWinnerYet! !


!OMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:01'!
doesOMoveNext
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMovesTokenNext class' category: #'TerniLapilli-Ejercicio'!
OMovesTokenNext class
	instanceVariableNames: ''!

!OMovesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:11:59'!
isFor: aTokenCount

	^false! !


!classDefinition: #OPlacesTokenNext category: #'TerniLapilli-Ejercicio'!
OActivePlayer subclass: #OPlacesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 16:20:54'!
movingTokenAt: aPosition to: anotherPosition
	
	terniLapilli shouldNotMoveError! !

!OPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/6/2018 01:05:19'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: terniLapilli oTokensPositions.
	terniLapilli hasThePlacementEnded.! !

!OPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:07:09'!
winner
	
	^terniLapilli noWinnerYet! !


!OPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:26:38'!
doesOPlaceNext
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OPlacesTokenNext class' category: #'TerniLapilli-Ejercicio'!
OPlacesTokenNext class
	instanceVariableNames: ''!

!OPlacesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:13:12'!
isFor: aTokenCount

	^false! !


!classDefinition: #OWon category: #'TerniLapilli-Ejercicio'!
OActivePlayer subclass: #OWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OWon methodsFor: 'operations - private' stamp: 'GR 11/2/2018 17:53:27'!
movingTokenAt: aPosition to: anotherPosition

	
	terniLapilli gameAlreadyOverError! !

!OWon methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:44:45'!
placingTokenAt: aPosition
	
	terniLapilli gameAlreadyOverError! !

!OWon methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:06:32'!
winner
	
	^terniLapilli playerO! !


!OWon methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:26:56'!
isFinished
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OWon class' category: #'TerniLapilli-Ejercicio'!
OWon class
	instanceVariableNames: ''!

!OWon class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:12:24'!
isFor: aTokenCount
	^false! !


!classDefinition: #XActivePlayer category: #'TerniLapilli-Ejercicio'!
GameState subclass: #XActivePlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:07:51'!
activePlayerWon

	terniLapilli theWinnerIs: XWon! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:45:24'!
currentPlayer

	^terniLapilli playerX! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 21:35:27'!
currentPlayerTokensPositions
	^terniLapilli  xTokensPositions ! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:44:27'!
movingTokenAt: aPosition to: anotherPosition

	self subclassResponsibility ! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:43:49'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:06:10'!
winner
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XActivePlayer class' category: #'TerniLapilli-Ejercicio'!
XActivePlayer class
	instanceVariableNames: ''!

!XActivePlayer class methodsFor: 'instance creation - private' stamp: 'GR 11/5/2018 17:46:50'!
decideGameStage: aTerniLapilli using: aTokenCount

	|estado|
	
	estado := self subclasses detect: [:aSubclass| aSubclass isFor: aTokenCount].
	
	^estado new initializeWith: aTerniLapilli.! !

!XActivePlayer class methodsFor: 'instance creation - private' stamp: 'GR 11/5/2018 17:47:24'!
isFor: aTokenCount

	self subclassResponsibility ! !


!classDefinition: #XMovesTokenNext category: #'TerniLapilli-Ejercicio'!
XActivePlayer subclass: #XMovesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 21:35:06'!
movingTokenAt: aPosition to: anotherPosition
	
	(terniLapilli isOTokenAt: (aPosition)) ifTrue: [terniLapilli tokenOwnershipError].

	terniLapilli safelyRemoveTokenAt: aPosition belongingTo: terniLapilli xTokensPositions.
	terniLapilli safelyPlaceTokenAt: anotherPosition belongingTo: terniLapilli xTokensPositions.
	terniLapilli changeTo: (OMovesTokenNext for: terniLapilli).! !

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/6/2018 00:23:14'!
placingTokenAt: aPosition
	
	terniLapilli shouldNotPlaceError! !

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:07:04'!
winner
	
	^terniLapilli noWinnerYet! !


!XMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:27:27'!
doesXMoveNext
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMovesTokenNext class' category: #'TerniLapilli-Ejercicio'!
XMovesTokenNext class
	instanceVariableNames: ''!

!XMovesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:13:25'!
isFor: aTokenCount

	^aTokenCount = 3! !


!classDefinition: #XPlacesTokenNext category: #'TerniLapilli-Ejercicio'!
XActivePlayer subclass: #XPlacesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 16:20:48'!
movingTokenAt: aPosition to: anotherPosition
	
	terniLapilli shouldNotMoveError! !

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 21:35:06'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: terniLapilli xTokensPositions.
	terniLapilli changeTo: (OPlacesTokenNext for: terniLapilli).! !

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:06:58'!
winner
	
	^terniLapilli noWinnerYet! !


!XPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:27:39'!
doesXPlaceNext
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XPlacesTokenNext class' category: #'TerniLapilli-Ejercicio'!
XPlacesTokenNext class
	instanceVariableNames: ''!

!XPlacesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:13:37'!
isFor: aTokenCount

	^aTokenCount < 3! !


!classDefinition: #XWon category: #'TerniLapilli-Ejercicio'!
XActivePlayer subclass: #XWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XWon methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:37:14'!
movingTokenAt: aPosition to: anotherPosition

	
	terniLapilli gameAlreadyOverError! !

!XWon methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:37:29'!
placingTokenAt: aPosition
	
	terniLapilli gameAlreadyOverError! !

!XWon methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:06:43'!
winner
	
	^terniLapilli playerX! !


!XWon methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:27:52'!
isFinished
	^true! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state oTokensPositions xTokensPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 12:43:01'!
gameAlreadyOverError
	
	self error: self class GameAlreadyOverErrorDescription! !

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 16:21:44'!
shouldNotMoveError
	
	self error: self class AllTokensShouldBePlacedErrorDescription ! !

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/6/2018 00:23:14'!
shouldNotPlaceError
	
	self error: self class TokenPositioningAtMovingStageErrorDescription! !

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 16:51:34'!
tokenOwnershipError
	
	self error: self class TokenOwnershipErrorDescription! !


!TerniLapilli methodsFor: 'initialization' stamp: 'GR 11/6/2018 00:42:50'!
initialize
	xTokensPositions := Set new.
	oTokensPositions := Set new.
	
	state:=XPlacesTokenNext for: self.! !


!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:19:49'!
doesOMoveNext

	^(state doesOMoveNext)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:19:59'!
doesOPlaceNext

	^(state doesOPlaceNext)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:20:06'!
doesXMoveNext
	^state doesXMoveNext ! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:20:19'!
doesXPlaceNext

	^state doesXPlaceNext ! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:20:26'!
isFinished

	^state isFinished! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:32'!
isOTokenAt: aPosition


	^oTokensPositions includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:15:00'!
isOWinner

	^self winner = 'O'! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 21:04:14'!
isOcuppied: aPosition

	^(self isXTokenAt: aPosition) or: [self isOTokenAt: aPosition]! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 21:03:39'!
isVacant: aPosition 
	


	^(self isOcuppied: aPosition) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:23'!
isXTokenAt: aPosition
	
	^xTokensPositions includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:14:55'!
isXWinner

	^self winner = 'X'! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:14'!
noOTokensPlaced

	^oTokensPositions size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:08'!
noXTokensPlaced

	^xTokensPositions size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 18:04:37'!
winner
	^state winner! !


!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:09:11'!
noWinnerYet
	^'No winner'! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/6/2018 00:21:58'!
oTokensPositions

	^oTokensPositions ! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:32:49'!
playerO

	^'O'! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:32:41'!
playerX

	^'X'! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/6/2018 00:22:01'!
xTokensPositions

	^xTokensPositions ! !


!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 00:41:36'!
areDiagonal: positions

	
	^(self areStraightDiagonal: positions) or:[self areInvertedDiagonal: positions]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 23:04:28'!
areHorizontal: positions atRow: aRowNumber
	
	
	^positions allSatisfy: [:aPosition | aRowNumber = aPosition x]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 00:41:27'!
areInLine: positions
	
	
	^(1 to: 3) anySatisfy: [:aCoordinateValue| (self areHorizontal: positions atRow: aCoordinateValue) or: [self areVertical: positions atColumn: aCoordinateValue]]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 00:27:01'!
areInvertedDiagonal: positions

	
	^positions allSatisfy: [:aPosition| (aPosition - 2) x = (aPosition - 2)  y negated]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 00:25:43'!
areStraightDiagonal: positions

	
	^positions allSatisfy: [:aPosition | aPosition x = aPosition y]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 23:04:36'!
areVertical: positions atColumn: aRowNumber
	
	
	^positions allSatisfy: [:aPosition | aRowNumber = aPosition y]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 00:44:08'!
changeTo: aGameState


	( self winningConditions ) ifTrue: [state activePlayerWon.] ifFalse: [state := aGameState].! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 01:05:19'!
hasThePlacementEnded

	"esto lo agregamos por el xTokens size"
	
	self changeTo: (XActivePlayer decideGameStage: self using: xTokensPositions size)! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 18:08:32'!
theWinnerIs: aWinner
	
	state := aWinner for: self.! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/6/2018 00:42:08'!
winningConditions
	
	|tokensPositions|
	
	tokensPositions := state currentPlayerTokensPositions.
	

	^(tokensPositions size = 3) and: [(self areInLine: tokensPositions) or: [self areDiagonal: tokensPositions]]! !


!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/6/2018 00:47:29'!
moveTokenAt: aPosition to: anotherPosition 

	self assertPlacementConditionsAt: anotherPosition.

	self assertMovementConditionsFrom: aPosition to: anotherPosition.
	
	state movingTokenAt: aPosition to: anotherPosition.! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/6/2018 00:47:29'!
placeTokenAt: aPosition 

	self assertPlacementConditionsAt: aPosition.

	state placingTokenAt: aPosition.! !


!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/6/2018 00:45:05'!
safelyPlaceTokenAt: aPosition belongingTo: aPositionsSet

	aPositionsSet add: aPosition! !

!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/5/2018 21:12:39'!
safelyRemoveTokenAt: aPosition belongingTo: aPositionsSet

	aPositionsSet remove: aPosition.! !


!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 00:48:47'!
assertMovementConditionsFrom: aPosition to: anotherPosition

	(self isVacant: aPosition) ifTrue: [self error: self class TryingToMoveNonTokenErrorDescription ].

	(self isMovingIncorrectlyFrom: aPosition to: anotherPosition) ifTrue: [self error: self class GameboardLayoutErrorDescription].
! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 01:07:22'!
assertPlacementConditionsAt: aPosition 

	(self isOutOfBounds: (aPosition - 2)) ifTrue: [self error: self class OutOfBoundsErrorDescription ].
	
	(self isOcuppied: (aPosition)) ifTrue: [self error: self class OccupiedPositionErrorDescription ].
! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 00:59:58'!
badDiagonalMoveFrom: aPosition to: anotherPosition

	
	^(aPosition - 2) transposed = (anotherPosition - 2) negated! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 00:59:23'!
badInvertedDiagonalMoveFrom: aPosition to: anotherPosition

	
	^aPosition transposed = anotherPosition! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 01:04:09'!
horizontalFarJumpFrom: aPosition to: anotherPosition

	
	^self invalidCoordinate: (aPosition x - anotherPosition x)! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 01:03:41'!
invalidCoordinate: aCoordinateValue

	
	^aCoordinateValue abs > 1! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 01:00:44'!
isMovingIncorrectlyFrom: aPosition to: anotherPosition

	
	^(self horizontalFarJumpFrom: aPosition to: anotherPosition) or: [self verticalFarJumpFrom: aPosition to: anotherPosition] 
	or: [self badInvertedDiagonalMoveFrom: aPosition to: anotherPosition ] or: [self badDiagonalMoveFrom: aPosition to: anotherPosition]! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 01:04:44'!
isOutOfBounds: aPosition

	
	^(self invalidCoordinate: aPosition x) or:[self invalidCoordinate: aPosition y]! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 01:04:55'!
verticalFarJumpFrom: aPosition to: anotherPosition

	
	^self invalidCoordinate: (aPosition y - anotherPosition y)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:02:27'!
AllTokensShouldBePlacedErrorDescription

	^'It s not possible to move tokens before all of them are placed'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:02:02'!
GameAlreadyOverErrorDescription

	^'You can t move or place tokens after the game ends'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 17:09:05'!
GameboardLayoutErrorDescription

	^'You can only move a token throughout the border or the diagonals, one space at a time'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:02:08'!
OccupiedPositionErrorDescription

	^'The position designated for the token is already occupied by another token'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:02:14'!
OutOfBoundsErrorDescription

	^'The position designated for the token is out of bounds'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:51:00'!
TokenOwnershipErrorDescription

	^'The token you are trying to move belongs to the other player'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:02:21'!
TokenPositioningAtMovingStageErrorDescription

	^'It s not possible to place tokens at this stage of the game'! !

!TerniLapilli class methodsFor: 'error - private' stamp: 'GR 11/2/2018 16:47:21'!
TryingToMoveNonTokenErrorDescription

	^'There is no token at the position you are trying to move from'! !
