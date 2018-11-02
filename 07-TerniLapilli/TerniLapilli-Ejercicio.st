!classDefinition: #GameState category: #'TerniLapilli-Ejercicio'!
Object subclass: #GameState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameState methodsFor: 'initialization - private' stamp: 'GR 11/2/2018 02:10:26'!
initializeWith: aTerniLapilli

	terniLapilli:= aTerniLapilli.! !


!GameState methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:54:03'!
placingTokenAt: aPosition

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameState class' category: #'TerniLapilli-Ejercicio'!
GameState class
	instanceVariableNames: ''!

!GameState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:11:40'!
decideGameStage: aTerniLapilli using: aTokenCount

	|estado|
	
	estado := self subclasses detect: [:aSubclass| aSubclass isFor: aTokenCount].
	
	^estado new initializeWith: aTerniLapilli.! !

!GameState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:09:46'!
for: aTerniLapilli
	^self new initializeWith: aTerniLapilli .! !

!GameState class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:12:40'!
isFor: aTokenCount

	self subclassResponsibility ! !


!classDefinition: #Finished category: #'TerniLapilli-Ejercicio'!
GameState subclass: #Finished
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Finished methodsFor: 'operations - private' stamp: 'GR 11/2/2018 17:53:27'!
movingTokenAt: aPosition to: anotherPosition

	
	terniLapilli gameAlreadyOverError! !

!Finished methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:44:45'!
placingTokenAt: aPosition
	
	terniLapilli gameAlreadyOverError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Finished class' category: #'TerniLapilli-Ejercicio'!
Finished class
	instanceVariableNames: ''!

!Finished class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:12:24'!
isFor: aTokenCount
	^false! !


!classDefinition: #OMovesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #OMovesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 17:45:27'!
movingTokenAt: aPosition to: anotherPosition

	"no se si se puede sacar este if"
	
	(terniLapilli isXTokenAt: aPosition) ifTrue: [terniLapilli tokenOwnershipError].
	
	terniLapilli safelyRemoveTokenAt: aPosition belongingTo: #oTokens.
	terniLapilli safelyPlaceTokenAt: anotherPosition belongingTo: #oTokens.
	terniLapilli changeTo: (XMovesTokenNext for: terniLapilli).! !

!OMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 12:54:21'!
placingTokenAt: aPosition
	
	terniLapilli timeOutError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMovesTokenNext class' category: #'TerniLapilli-Ejercicio'!
OMovesTokenNext class
	instanceVariableNames: ''!

!OMovesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:11:59'!
isFor: aTokenCount

	^false! !


!classDefinition: #OPlacesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #OPlacesTokenNext
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OPlacesTokenNext class' category: #'TerniLapilli-Ejercicio'!
OPlacesTokenNext class
	instanceVariableNames: ''!

!OPlacesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:13:12'!
isFor: aTokenCount

	^false! !


!classDefinition: #XMovesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #XMovesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 17:45:08'!
movingTokenAt: aPosition to: anotherPosition
	
	"no se si se puede sacar este if"
	
	(terniLapilli isOTokenAt: aPosition) ifTrue: [terniLapilli tokenOwnershipError].
	
	terniLapilli safelyRemoveTokenAt: aPosition belongingTo: #xTokens.
	terniLapilli safelyPlaceTokenAt: anotherPosition belongingTo: #xTokens.
	terniLapilli changeTo: (OMovesTokenNext for: terniLapilli).! !

!XMovesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:19:45'!
placingTokenAt: aPosition
	
	terniLapilli timeOutError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMovesTokenNext class' category: #'TerniLapilli-Ejercicio'!
XMovesTokenNext class
	instanceVariableNames: ''!

!XMovesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:13:25'!
isFor: aTokenCount

	^aTokenCount = 3! !


!classDefinition: #XPlacesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #XPlacesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 16:20:48'!
movingTokenAt: aPosition to: anotherPosition
	
	terniLapilli shouldNotMoveError! !

!XPlacesTokenNext methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:19:25'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: #xTokens.
	terniLapilli changeTo: (OPlacesTokenNext for: terniLapilli).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XPlacesTokenNext class' category: #'TerniLapilli-Ejercicio'!
XPlacesTokenNext class
	instanceVariableNames: ''!

!XPlacesTokenNext class methodsFor: 'instance creation - private' stamp: 'GR 11/2/2018 02:13:37'!
isFor: aTokenCount

	^aTokenCount < 3! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state oTokens xTokens winner'
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


!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 17:35:18'!
doesOMoveNext

	^(state isKindOf: OMovesTokenNext)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 17:35:34'!
doesOPlaceNext

	^(state isKindOf: OPlacesTokenNext)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 17:35:47'!
doesXMoveNext
	^state isKindOf: XMovesTokenNext ! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 17:36:02'!
doesXPlaceNext

	^(state isKindOf: XPlacesTokenNext)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:36:46'!
isFinished

	^(state isKindOf: Finished)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:20:28'!
isOTokenAt: aPosition

	^oTokens includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:20:32'!
isOcuppied: aPosition

	^(self isVacant: aPosition)  not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:20:39'!
isVacant: aPosition 
	((xTokens includes: aPosition) or: [ oTokens  includes: aPosition ]) ifTrue:[^false].
	^true! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:20:43'!
isXTokenAt: aPosition

	^xTokens includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:18:15'!
noOTokensPlaced

	^oTokens size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 02:18:18'!
noXTokensPlaced

	^xTokens size = 0! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 11/2/2018 12:59:19'!
winner
	^winner! !


!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 13:17:54'!
are: positions straightConsidering: aCoordinate
	
	
	^(-1 to: 1) anySatisfy: [:aCoordinateValue| positions size = 3 and: [positions allSatisfy: [:aPosition | aCoordinateValue = (aCoordinate sendTo: aPosition)]]]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 15:07:26'!
areDiagonal: positions
	"creo que hay refactoring posible aca"
	
	^ positions size = 3 and: [(positions allSatisfy: [:aPosition | aPosition x = aPosition y]) or:[positions allSatisfy: [:aPosition| aPosition x = aPosition y negated]]]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 17:24:49'!
isInvalidMoveFrom: aPosition to: anotherPosition
	
	^((aPosition x - anotherPosition x) abs > 1) or: [(aPosition y - anotherPosition y) abs > 1] or: [aPosition transposed = anotherPosition] or: [aPosition transposed = anotherPosition negated]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:17:03'!
oTokens

	^oTokens! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:17:11'!
xTokens

	^xTokens! !


!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/2/2018 15:12:01'!
changeTo: aGameState
"aca hay refactoring posible de aca a la china"


( (self are: xTokens straightConsidering: #x ) or: [self are: xTokens straightConsidering: #y] or: [self areDiagonal:xTokens]) ifTrue: [state := Finished for: self. winner:= 'X'] ifFalse: [
	
	( (self are: oTokens straightConsidering: #x ) or: [self are: oTokens straightConsidering: #y] or: [self areDiagonal:oTokens]) ifTrue: [state := Finished for: self. winner:= 'O'] ifFalse: [
													state := aGameState]].! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/2/2018 17:49:04'!
hasThePositioningEnded

	"no se si es necesario tener esta abstraccion"
	
	self changeTo: (GameState decideGameStage: self using: xTokens size)! !


!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 17:15:46'!
moveTokenAt: aPosition to: anotherPosition 

	"estos ifs no se si pueden sacarse, algunos estan repetidos en el place tambien"

	(self isVacant: aPosition) ifTrue: [self error: self class TryingToMoveNonTokenErrorDescription ].

	(anotherPosition x abs > 1 or:[anotherPosition y abs > 1 ]) ifTrue: [self error: self class OutOfBoundsErrorDescription ].
	
	(self isOcuppied: anotherPosition) ifTrue: [self error: self class OccupiedPositionErrorDescription ].
	
	(self isInvalidMoveFrom: aPosition to: anotherPosition) ifTrue: [self error: self class GameboardLayoutErrorDescription].

	state movingTokenAt: aPosition to: anotherPosition.! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 17:10:40'!
placeTokenAt: aPosition 

	"estos ifs no se si pueden sacarse y estan repetidos en el move"

	(aPosition x abs > 1 or:[aPosition y abs > 1 ]) ifTrue: [self error: self class OutOfBoundsErrorDescription ].
		
	(self isOcuppied: aPosition) ifTrue: [self error: self class OccupiedPositionErrorDescription ].

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
