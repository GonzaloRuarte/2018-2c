!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Test'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Test'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 13:58:36'!
test01InitialTerniLapilliShouldHaveNoTokensAndXShouldPlaceNext

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli xPlacesNext)
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 13:59:37'!
test02AfterFirstTokenOShouldPlaceNextAndPositionShouldBeOccupied

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli oPlacesNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 14:01:02'!
test03TokenShouldNotBePlacedAtOccupiedPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	self should:  [terniLapilli placeTokenAt: 1@1.] raise: Error withExceptionDo: 
	[:anException|
		self deny: (terniLapilli isOTokenAt: 1@1). 
		self assert: (terniLapilli isXTokenAt: 1@1).
		self deny: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli oPlacesNext)]
	description: TerniLapilli OccupiedPositionErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 14:01:22'!
test04TokenShouldNotBePlacedAtOutOfBoundsPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	self should:  [terniLapilli placeTokenAt: 1@2.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 1@2).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli xPlacesNext)]
	description: TerniLapilli OutOfBoundsErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 14:02:03'!
test05TokenPlacedForXAndOShouldCount

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 0@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli xPlacesNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 14:47:59'!
test06ShouldNotPlaceTokenAfterAllHaveBeenPlaced

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should:[terniLapilli placeTokenAt: -1@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: -1@-1).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli xMovesNext)]
	description: TerniLapilli TokenPositioningAtMovingStageErrorDescription 
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 15:20:44'!
test07TokenShouldNotBePlacedAfterXWinsByPlacing3TokensHorizontally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 1@-1.
	self assert: (terniLapilli winner = 'X'). 
	self should:[terniLapilli placeTokenAt: 0@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 0@-1). 
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert:(terniLapilli isFinished)]
	description: TerniLapilli GameAlreadyOverErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 15:20:51'!
test08TokenShouldNotBePlacedAfterOWinsByPlacing3TokensHorizontally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: -1@1.
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 1@-1.
	self assert: (terniLapilli winner = 'O'). 
	self should:[terniLapilli placeTokenAt: 0@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 0@-1). 
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert:(terniLapilli isFinished)]
	description: TerniLapilli GameAlreadyOverErrorDescription 
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 15:20:58'!
test09TokenShouldNotBePlacedAfterXWinsByPlacing3TokensVertically

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: -1@1.
	self assert: (terniLapilli winner = 'X'). 
		self should:[terniLapilli placeTokenAt: -1@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: -1@-1).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli isFinished )]
	description: TerniLapilli TokenPositioningAtMovingStageErrorDescription 
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 15:21:08'!
test10TokenShouldNotBePlacedAfterOWinsByPlacing3TokensVertically

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: -1@-1.
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: -1@1.
	self assert: (terniLapilli winner = 'O'). 
		self should:[terniLapilli placeTokenAt: -1@0]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: -1@0).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli isFinished )]
	description: TerniLapilli TokenPositioningAtMovingStageErrorDescription 
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 15:21:18'!
test11TokenShouldNotBePlacedAfterXWinsByPlacing3TokensDiagonally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: -1@-1.
	self assert: (terniLapilli winner = 'X'). 
	self should:[terniLapilli placeTokenAt: 0@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 0@-1).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli isFinished )]
	description: TerniLapilli TokenPositioningAtMovingStageErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 15:21:26'!
test12TokenShouldNotBePlacedAfterOWinsByPlacing3TokensDiagonally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: -1@0.
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: -1@-1.
	self assert: (terniLapilli winner = 'O'). 
	self should:[terniLapilli placeTokenAt: 0@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 0@-1).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli isFinished )]
	description: TerniLapilli TokenPositioningAtMovingStageErrorDescription ! !
