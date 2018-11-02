!classDefinition: #GameState category: #'TerniLapilli-Ejercicio'!
Object subclass: #GameState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameState methodsFor: 'initialization' stamp: 'GR 11/2/2018 02:10:26'!
initializeWith: aTerniLapilli

	terniLapilli:= aTerniLapilli.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameState class' category: #'TerniLapilli-Ejercicio'!
GameState class
	instanceVariableNames: ''!

!GameState class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:11:40'!
decideGameStage: aTerniLapilli using: aTokenCount

	|estado|
	
	estado := self subclasses detect: [:aSubclass| aSubclass isFor: aTokenCount].
	
	^estado new initializeWith: aTerniLapilli.! !

!GameState class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:09:46'!
for: aTerniLapilli
	^self new initializeWith: aTerniLapilli .! !

!GameState class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:12:40'!
isFor: aTokenCount

	self subclassResponsibility ! !


!classDefinition: #Finished category: #'TerniLapilli-Ejercicio'!
GameState subclass: #Finished
	instanceVariableNames: 'winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Finished class' category: #'TerniLapilli-Ejercicio'!
Finished class
	instanceVariableNames: ''!


!Finished class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:12:24'!
isFor: aTokenCount
	^false! !


!classDefinition: #OMovesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #OMovesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMovesTokenNext class' category: #'TerniLapilli-Ejercicio'!
OMovesTokenNext class
	instanceVariableNames: ''!

!OMovesTokenNext class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:11:59'!
isFor: aTokenCount

	^false! !


!classDefinition: #OPlacesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #OPlacesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!OPlacesTokenNext methodsFor: 'operations' stamp: 'GR 11/2/2018 02:19:42'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: #oTokens.
	terniLapilli hasThePositioningEnded.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OPlacesTokenNext class' category: #'TerniLapilli-Ejercicio'!
OPlacesTokenNext class
	instanceVariableNames: ''!

!OPlacesTokenNext class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:13:12'!
isFor: aTokenCount

	^false! !


!classDefinition: #XMovesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #XMovesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XMovesTokenNext methodsFor: 'operations' stamp: 'GR 11/2/2018 02:19:45'!
placingTokenAt: aPosition
	
	terniLapilli timeOutError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMovesTokenNext class' category: #'TerniLapilli-Ejercicio'!
XMovesTokenNext class
	instanceVariableNames: ''!

!XMovesTokenNext class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:13:25'!
isFor: aTokenCount

	^aTokenCount = 3! !


!classDefinition: #XPlacesTokenNext category: #'TerniLapilli-Ejercicio'!
GameState subclass: #XPlacesTokenNext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!XPlacesTokenNext methodsFor: 'operations' stamp: 'GR 11/2/2018 02:19:25'!
placingTokenAt: aPosition
	
	terniLapilli safelyPlaceTokenAt: aPosition belongingTo: #xTokens.
	terniLapilli changeTo: (OPlacesTokenNext for: terniLapilli).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XPlacesTokenNext class' category: #'TerniLapilli-Ejercicio'!
XPlacesTokenNext class
	instanceVariableNames: ''!

!XPlacesTokenNext class methodsFor: 'instance creation' stamp: 'GR 11/2/2018 02:13:37'!
isFor: aTokenCount

	^aTokenCount < 3! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state oTokens xTokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'initialization' stamp: 'GR 11/2/2018 02:17:42'!
initialize
	xTokens := Set new.
	oTokens := Set new.
	
	state:=XPlacesTokenNext for: self.! !


!TerniLapilli methodsFor: 'token positioning' stamp: 'GR 11/2/2018 01:32:56'!
placeTokenAt: aPoint 

	state placingTokenAt: aPoint .! !

!TerniLapilli methodsFor: 'token positioning' stamp: 'GR 11/2/2018 02:15:57'!
safelyPlaceTokenAt: aPoint belongingTo: aPositionsSet

	 (aPoint x abs > 1 or:[aPoint y abs > 1 ]) ifTrue: [self error: self class OutOfBoundsErrorDescription ].
		
	(self isOcuppied: aPoint) ifTrue: [self error: self class OccupiedPositionErrorDescription ].
	
	 (aPositionsSet sendTo: self) add: aPoint! !


!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:17:03'!
oTokens

	^oTokens! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'GR 11/2/2018 02:17:11'!
xTokens

	^xTokens! !


!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:36:46'!
isFinished

	^(state isKindOf: Finished)! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:20:28'!
isOTokenAt: aPosition

	^oTokens includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:20:32'!
isOcuppied: aPosition

	^(self isVacant: aPosition)  not.! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:20:39'!
isVacant: aPosition 
	((xTokens includes: aPosition) or: [ oTokens  includes: aPosition ]) ifTrue:[^false].
	^true! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:20:43'!
isXTokenAt: aPosition

	^xTokens includes: aPosition.	

	! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:18:15'!
noOTokensPlaced

	^oTokens size = 0! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:18:18'!
noXTokensPlaced

	^xTokens size = 0! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:36:11'!
oMovesNext

	^(state isKindOf: OMovesTokenNext)! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:31:37'!
oPlacesNext

	^(state isKindOf: OPlacesTokenNext)! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:35:28'!
xMovesNext
	^state isKindOf: XMovesTokenNext ! !

!TerniLapilli methodsFor: 'operations' stamp: 'GR 11/2/2018 02:31:29'!
xPlacesNext

	^(state isKindOf: XPlacesTokenNext)! !


!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/2/2018 02:20:01'!
changeTo: aGameState
	state := aGameState! !

!TerniLapilli methodsFor: 'state transition - private' stamp: 'GR 11/2/2018 02:17:31'!
hasThePositioningEnded

	
	
	self changeTo: (GameState decideGameStage: self using: xTokens size)! !


!TerniLapilli methodsFor: 'exception' stamp: 'GR 11/2/2018 02:38:45'!
timeOutError
	
	self error: self class TokenPositioningTimeOutErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error' stamp: 'GR 11/2/2018 01:41:19'!
OccupiedPositionErrorDescription

	^'The position designated for the token is already occupied by another token'! !

!TerniLapilli class methodsFor: 'error' stamp: 'GR 11/2/2018 01:40:58'!
OutOfBoundsErrorDescription

	^'The position designated for the token is out of bounds'! !

!TerniLapilli class methodsFor: 'error' stamp: 'GR 11/2/2018 01:44:55'!
TokenPositioningTimeOutErrorDescription

	^'It s not possible to place tokens at this stage of the game'! !
