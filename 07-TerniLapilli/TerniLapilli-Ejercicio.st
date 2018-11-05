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

!OActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:51:10'!
currentPlayerTokens
	^terniLapilli  oTokens ! !

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

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 20:54:02'!
movingTokenAt: aPosition to: anotherPosition

	
	(terniLapilli isXTokenAt: aPosition) ifTrue: [terniLapilli tokenOwnershipError].
	
	terniLapilli safelyRemoveTokenAt: aPosition belongingTo: #oTokens.
	terniLapilli safelyPlaceTokenAt: anotherPosition belongingTo: #oTokens.
	terniLapilli changeTo: (XMovesTokenNext for: terniLapilli).! !

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:54:21'!
placingTokenAt: aPosition
	
	terniLapilli timeOutError! !

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

!OPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:19:42'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: #oTokens.
	terniLapilli hasThePositioningEnded.! !

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

!XActivePlayer methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:51:19'!
currentPlayerTokens
	^terniLapilli  xTokens ! !

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

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/5/2018 20:53:46'!
movingTokenAt: aPosition to: anotherPosition
	
	(terniLapilli isOTokenAt: (aPosition)) ifTrue: [terniLapilli tokenOwnershipError].

	terniLapilli safelyRemoveTokenAt: aPosition belongingTo: #xTokens.
	terniLapilli safelyPlaceTokenAt: anotherPosition belongingTo: #xTokens.
	terniLapilli changeTo: (OMovesTokenNext for: terniLapilli).! !

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:19:45'!
placingTokenAt: aPosition
	
	terniLapilli timeOutError! !

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

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'ap 11/4/2018 17:34:04'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: #xTokens.
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
	instanceVariableNames: 'state oTokens xTokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 12:43:01'!
gameAlreadyOverError
	
	self error: self class GameAlreadyOverErrorDescription! !

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 16:21:44'!
shouldNotMoveError
	
	self error: self class AllTokensShouldBePlacedErrorDescription ! !

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 14:47:59'!
timeOutError
	
	self error: self class TokenPositioningAtMovingStageErrorDescription! !

!TerniLapilli methodsFor: 'exception - private' stamp: 'GR 11/2/2018 16:51:34'!
tokenOwnershipError
	
	self error: self class TokenOwnershipErrorDescription! !


!TerniLapilli methodsFor: 'initialization' stamp: 'GR 11/2/2018 02:17:42'!
initialize
	xTokens := Set new.
	oTokens := Set new.
	
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

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 20:53:30'!
isOTokenAt: aPosition


	^oTokens includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:15:00'!
isOWinner

	^self winner = 'O'! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:20:32'!
isOcuppied: aPosition

	^(self isVacant: aPosition)  not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:44:17'!
isVacant: aPosition 
	


	^((self isXTokenAt: aPosition )or: [ self isOTokenAt: aPosition ]) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 20:53:39'!
isXTokenAt: aPosition
	
	^xTokens includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 19:14:55'!
isXWinner

	^self winner = 'X'! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:18:15'!
noOTokensPlaced

	^oTokens size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:18:18'!
noXTokensPlaced

	^xTokens size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/5/2018 18:04:37'!
winner
	^state winner! !


!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 20:54:18'!
are: positions straightConsidering: aCoordinate
	
	
	^(1 to: 3) anySatisfy: [:aCoordinateValue| positions size = 3 and: [positions allSatisfy: [:aPosition | aCoordinateValue = (aCoordinate sendTo: aPosition)]]]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 20:58:28'!
areDiagonal: positions

	
	^ positions size = 3 and: [(positions allSatisfy: [:aPosition | aPosition x = aPosition y]) or:[positions allSatisfy: [:aPosition| (aPosition - 2) x = (aPosition - 2)  y negated]]]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 20:59:13'!
assertMovementConditionsFrom: aPosition to: anotherPosition




	(self isVacant: aPosition) ifTrue: [self error: self class TryingToMoveNonTokenErrorDescription ].

	(((aPosition x - anotherPosition x) abs > 1) or: [(aPosition y - anotherPosition y) abs > 1] or: [aPosition transposed = anotherPosition] or: [(aPosition - 2) transposed = (anotherPosition - 2) negated]) ifTrue: [
		
		self error: self class GameboardLayoutErrorDescription].
! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 20:55:34'!
assertPlacementConditionsOf: aPosition 

	|truePosition|
	
	truePosition := aPosition - 2.

	(truePosition x abs > 1 or:[truePosition y abs > 1 ]) ifTrue: [self error: self class OutOfBoundsErrorDescription ].
	
	(self isOcuppied: (aPosition)) ifTrue: [self error: self class OccupiedPositionErrorDescription ].
! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 18:09:11'!
noWinnerYet
	^'No winner'! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:17:03'!
oTokens

	^oTokens! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:32:49'!
playerO

	^'O'! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/5/2018 17:32:41'!
playerX

	^'X'! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:17:11'!
xTokens

	^xTokens! !


!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 18:03:24'!
changeTo: aGameState


		( self winningConditions ) ifTrue: [state activePlayerWon.] ifFalse: [state := aGameState].! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 17:48:01'!
hasThePositioningEnded

	"esto lo agregamos por el xTokens size"
	
	self changeTo: (XActivePlayer decideGameStage: self using: xTokens size)! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 18:08:32'!
theWinnerIs: aWinner
	
	state := aWinner for: self.! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/5/2018 17:51:51'!
winningConditions


	^(self are: (state currentPlayerTokens) straightConsidering: #x ) or: [self are: (state currentPlayerTokens) straightConsidering: #y] or: [self areDiagonal:(state currentPlayerTokens)]! !


!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/5/2018 20:53:06'!
moveTokenAt: aPosition to: anotherPosition 

	self assertPlacementConditionsOf: anotherPosition.

	self assertMovementConditionsFrom: aPosition to: anotherPosition.
	
	state movingTokenAt: aPosition to: anotherPosition.! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/5/2018 20:53:15'!
placeTokenAt: aPosition 

	self assertPlacementConditionsOf: aPosition.

	state placingTokenAt: aPosition.! !


!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/2/2018 16:12:40'!
safelyPlaceTokenAt: aPosition belongingTo: aPositionsSet

	
	 (aPositionsSet sendTo: self) add: aPosition! !

!TerniLapilli methodsFor: 'token addition and removal - private' stamp: 'GR 11/2/2018 17:44:26'!
safelyRemoveTokenAt: aPosition belongingTo: aPositionsSet

	(aPositionsSet sendTo: self) remove: aPosition.! !

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
