!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Test'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Test'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:36:02'!
test01InitialTerniLapilliShouldHaveNoTokensAndXShouldPlaceNext

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:34'!
test02AfterFirstTokenOShouldPlaceNextAndPositionShouldBeOccupied

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesOPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:34'!
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
		self assert: (terniLapilli doesOPlaceNext)]
	description: TerniLapilli OccupiedPositionErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:36:03'!
test04TokenShouldNotBePlacedAtOutOfBoundsPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	self should:  [terniLapilli placeTokenAt: 1@2.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 1@2).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXPlaceNext)]
	description: TerniLapilli OutOfBoundsErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:36:02'!
test05TokenPlacedForXAndOShouldCount

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 0@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:48'!
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
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException description = ('Error: ',TerniLapilli TokenPositioningAtMovingStageErrorDescription ))]
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 16:08:32'!
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
		self assert:(terniLapilli isFinished).
		self assert: (anException description = ('Error: ',TerniLapilli GameAlreadyOverErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 16:08:36'!
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
		self assert:(terniLapilli isFinished).
		self assert: (anException description = ('Error: ',TerniLapilli GameAlreadyOverErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 16:08:40'!
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
		self assert: (terniLapilli isFinished ).
		self assert: (anException description = ('Error: ',TerniLapilli GameAlreadyOverErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 16:08:44'!
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
		self assert: (terniLapilli isFinished ).
		self assert: (anException description = ('Error: ',TerniLapilli GameAlreadyOverErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 16:08:47'!
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
		self assert: (terniLapilli isFinished ).
		self assert: (anException description = ('Error: ',TerniLapilli GameAlreadyOverErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 16:08:51'!
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
		self assert: (terniLapilli isFinished ).
		self assert: (anException description = ('Error: ',TerniLapilli GameAlreadyOverErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:34'!
test13ShouldNotMoveTokenUntilAllHaveBeenPlaced

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: -1@0.
	self should: [terniLapilli moveTokenAt: -1@0 to: -1@-1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: -1@-1).
		self assert: (terniLapilli isXTokenAt: -1@0).
		self assert: (terniLapilli doesOPlaceNext).
		self assert: (anException description = ('Error: ',TerniLapilli AllTokensShouldBePlacedErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:48'!
test14ShouldNotMoveFromAVacantPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should: [terniLapilli moveTokenAt: -1@0 to: -1@-1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: -1@-1).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException description = ('Error: ',TerniLapilli TryingToMoveNonTokenErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:48'!
test15ShouldNotMoveATokenFromSomeoneElse

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should: [terniLapilli moveTokenAt: 0@0 to: -1@0.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: -1@0).
		self assert: (terniLapilli isOTokenAt: 0@0).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException description = ('Error: ',TerniLapilli TokenOwnershipErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:48'!
test16TokenShouldNotBeMovedToOutOfBoundsPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should: [terniLapilli moveTokenAt: 1@1 to: 1@2.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: -1@0).
		self assert: (terniLapilli isOTokenAt: 0@0).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException description = ('Error: ',TerniLapilli OutOfBoundsErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:48'!
test17TokenShouldNotBeMovedToOccupiedPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should: [terniLapilli moveTokenAt: 1@1 to: 1@0.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: -1@0).
		self assert: (terniLapilli isOTokenAt: 0@0).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException description = ('Error: ',TerniLapilli OccupiedPositionErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:48'!
test18TokenMovementShouldFollowTheGameboardLayout

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should: [terniLapilli moveTokenAt: 1@1 to: -1@-1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: -1@-1).
		self assert: (terniLapilli isXTokenAt: 1@1).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException description = ('Error: ',TerniLapilli GameboardLayoutErrorDescription ))]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 17:35:18'!
test19ValidMovementShouldLeaveVacantSpace

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	terniLapilli moveTokenAt: 0@-1 to: -1@-1.
	
	self assert: (terniLapilli isVacant: 0@-1).
	self assert: (terniLapilli isXTokenAt: -1@-1).
	self assert: (terniLapilli doesOMoveNext)
		! !
