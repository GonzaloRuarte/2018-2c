!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state oTokensPositions xTokensPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

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

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/7/2018 02:10:33'!
badInvertedDiagonalMoveFrom: aPosition to: anotherPosition
	
	
	^aPosition transposed = anotherPosition! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 13:32:12'!
horizontalFarJumpFrom: aPosition to: anotherPosition

	
	^(aPosition x - anotherPosition x) abs > 1! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/7/2018 02:15:45'!
isMovingIncorrectlyFrom: aPosition to: anotherPosition

	
	^(self horizontalFarJumpFrom: aPosition to: anotherPosition) or: [self verticalFarJumpFrom: aPosition to: anotherPosition] 
	or: [self badInvertedDiagonalMoveFrom: aPosition to: anotherPosition ] or: [self badDiagonalMoveFrom: aPosition to: anotherPosition]! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 13:31:17'!
isOutOfBounds: aPosition

	
	^(aPosition x abs > 1) or: [aPosition y abs > 1]! !

!TerniLapilli methodsFor: 'assertions - private' stamp: 'GR 11/6/2018 13:32:28'!
verticalFarJumpFrom: aPosition to: anotherPosition

	
	^(aPosition y - anotherPosition y) abs > 1! !


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


!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/6/2018 00:47:29'!
moveTokenAt: aPosition to: anotherPosition 

	self assertPlacementConditionsAt: anotherPosition.

	self assertMovementConditionsFrom: aPosition to: anotherPosition.
	
	state movingTokenAt: aPosition to: anotherPosition.! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/6/2018 00:47:29'!
placeTokenAt: aPosition 

	self assertPlacementConditionsAt: aPosition.

	state placingTokenAt: aPosition.! !


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

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/8/2018 00:40:57'!
changeTo: aGameState


	( state winningConditions ) ifTrue: [state := state gameOverFor: self.] ifFalse: [state := aGameState].! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/8/2018 00:42:42'!
tokenAmountForX

	"esto lo agregamos para no violar el encapsulamiento"
	
	^xTokensPositions size! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/8/2018 00:42:11'!
winningConditionsForO

	^(oTokensPositions size = 3) and: [(self areInLine: oTokensPositions) or: [self areDiagonal: oTokensPositions]]! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/8/2018 00:43:21'!
winningConditionsForX

	^(xTokensPositions size = 3) and: [(self areInLine: xTokensPositions) or: [self areDiagonal: xTokensPositions]]! !


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

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:32'!
isOTokenAt: aPosition


	^oTokensPositions includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 13:37:35'!
isOWinner

	^state isOWinner! !

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

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 13:37:28'!
isXWinner

	^state isXWinner! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:14'!
noOTokensPlaced

	^oTokensPositions size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/6/2018 00:21:08'!
noXTokensPlaced

	^xTokensPositions size = 0! !


!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/8/2018 00:43:50'!
safelyPlaceTokenForOAt: aPosition andChangeTo: aTerniLapilliState

	oTokensPositions add: aPosition.
	self changeTo: aTerniLapilliState.! !

!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/8/2018 00:44:07'!
safelyPlaceTokenForXAt: aPosition andChangeTo: aTerniLapilliState
	
	xTokensPositions add: aPosition.
	self changeTo: aTerniLapilliState.! !

!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/8/2018 00:44:25'!
safelyRemoveTokenForOAt: aPosition

	oTokensPositions remove: aPosition.! !

!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/8/2018 00:44:37'!
safelyRemoveTokenForXAt: aPosition

	xTokensPositions remove: aPosition.! !

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


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliState methodsFor: 'initialization - private' stamp: 'GR 11/2/2018 02:10:26'!
initializeWith: aTerniLapilli

	terniLapilli:= aTerniLapilli.! !


!TerniLapilliState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:37:56'!
currentPlayer

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'operations - private' stamp: 'GR 11/7/2018 23:28:42'!
gameOverFor: aTerniLapilli

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:44:16'!
movingTokenAt: aPosition to: anotherPosition

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:54:03'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:41:10'!
winningConditions

	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:11:31'!
doesOMoveNext

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:11:28'!
doesOPlaceNext

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:11:25'!
doesXMoveNext

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:11:23'!
doesXPlaceNext

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:11:20'!
isOWinner

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:11:18'!
isXWinner

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'TerniLapilli-Ejercicio'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:09:46'!
for: aTerniLapilli
	^self new initializeWith: aTerniLapilli .! !

!TerniLapilliState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:12:40'!
isFor: aTokenCount

	self subclassResponsibility ! !


!classDefinition: #OActivePlayer category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #OActivePlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/6/2018 13:34:05'!
currentPlayer

	^'O'! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/7/2018 23:30:53'!
gameOverFor: aTerniLapilli

	^OWon for: aTerniLapilli ! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:44:22'!
movingTokenAt: aPosition to: anotherPosition

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:43:46'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:42:11'!
winningConditions

	^terniLapilli winningConditionsForO ! !


!OActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:12:39'!
doesOMoveNext

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:13:18'!
doesOPlaceNext

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:13:31'!
doesXMoveNext

	^false! !

!OActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:13:34'!
doesXPlaceNext

	^false! !

!OActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:14:15'!
isOWinner

	self subclassResponsibility ! !

!OActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:14:23'!
isXWinner

	^false! !

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

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:44:25'!
movingTokenAt: aPosition to: anotherPosition

	
	(terniLapilli isXTokenAt: aPosition) ifTrue: [terniLapilli tokenOwnershipError].
	
	terniLapilli safelyRemoveTokenForOAt: aPosition.	
	terniLapilli safelyPlaceTokenForOAt: anotherPosition andChangeTo: (XMovesTokenNext for: terniLapilli).! !

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/6/2018 00:23:14'!
placingTokenAt: aPosition
	
	terniLapilli shouldNotPlaceError! !


!OMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:25:01'!
doesOMoveNext
	^true! !

!OMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:18:56'!
doesOPlaceNext
	^false! !

!OMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:19:01'!
isOWinner
	^false! !

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

!OPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:43:50'!
placingTokenAt: aPosition
	

	terniLapilli safelyPlaceTokenForOAt: aPosition andChangeTo: (XActivePlayer decideGameStageFor: terniLapilli using: terniLapilli tokenAmountForX).! !


!OPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:19:26'!
doesOMoveNext
	^false! !

!OPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:26:38'!
doesOPlaceNext
	^true! !

!OPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:19:15'!
isOWinner
	^false! !

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

!OWon methodsFor: 'operations - private' stamp: 'GR 11/7/2018 23:31:29'!
movingTokenAt: aPosition to: anotherPosition

	terniLapilli gameAlreadyOverError! !

!OWon methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:44:45'!
placingTokenAt: aPosition
	
	terniLapilli gameAlreadyOverError! !


!OWon methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:19:36'!
doesOMoveNext
	^false! !

!OWon methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:19:40'!
doesOPlaceNext
	^false! !

!OWon methodsFor: 'testing - private' stamp: 'GR 11/6/2018 13:38:14'!
isOWinner
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OWon class' category: #'TerniLapilli-Ejercicio'!
OWon class
	instanceVariableNames: ''!

!OWon class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:12:24'!
isFor: aTokenCount
	^false! !


!classDefinition: #XActivePlayer category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #XActivePlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/6/2018 13:34:12'!
currentPlayer

	^'X'! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/7/2018 23:30:59'!
gameOverFor: aTerniLapilli

	^XWon for: aTerniLapilli ! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:44:27'!
movingTokenAt: aPosition to: anotherPosition

	self subclassResponsibility ! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:43:49'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:43:21'!
winningConditions

	^terniLapilli winningConditionsForX ! !


!XActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:15:20'!
doesOMoveNext

	^false! !

!XActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:15:18'!
doesOPlaceNext

	^false! !

!XActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:14:43'!
doesXMoveNext

	self subclassResponsibility ! !

!XActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:14:40'!
doesXPlaceNext

	self subclassResponsibility ! !

!XActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:15:13'!
isOWinner

	^false! !

!XActivePlayer methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:14:49'!
isXWinner

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XActivePlayer class' category: #'TerniLapilli-Ejercicio'!
XActivePlayer class
	instanceVariableNames: ''!

!XActivePlayer class methodsFor: 'instance creation - private' stamp: 'GR 11/7/2018 23:47:10'!
decideGameStageFor: aTerniLapilli using: aTokenCount

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

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:44:37'!
movingTokenAt: aPosition to: anotherPosition
	
	(terniLapilli isOTokenAt: (aPosition)) ifTrue: [terniLapilli tokenOwnershipError].

	terniLapilli safelyRemoveTokenForXAt: aPosition.
	terniLapilli safelyPlaceTokenForXAt: anotherPosition andChangeTo: (OMovesTokenNext for: terniLapilli).! !

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/6/2018 00:23:14'!
placingTokenAt: aPosition
	
	terniLapilli shouldNotPlaceError! !


!XMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:27:27'!
doesXMoveNext
	^true! !

!XMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:15:45'!
doesXPlaceNext
	^false! !

!XMovesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:16:21'!
isXWinner
	^false! !

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

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/8/2018 00:44:07'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenForXAt: aPosition andChangeTo: (OPlacesTokenNext for: terniLapilli).! !


!XPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:15:57'!
doesXMoveNext
	^false! !

!XPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/5/2018 19:27:39'!
doesXPlaceNext
	^true! !

!XPlacesTokenNext methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:16:24'!
isXWinner
	^false! !

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


!XWon methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:16:42'!
doesXMoveNext
	^false! !

!XWon methodsFor: 'testing - private' stamp: 'GR 11/6/2018 14:16:39'!
doesXPlaceNext
	^false! !

!XWon methodsFor: 'testing - private' stamp: 'GR 11/6/2018 13:38:20'!
isXWinner
	^true! !
