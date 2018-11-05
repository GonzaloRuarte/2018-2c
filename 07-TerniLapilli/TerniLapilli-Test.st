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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:29:05'!
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
		self assert: (terniLapilli doesOPlaceNext).
		self assert: (anException messageText = TerniLapilli OccupiedPositionErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:22:22'!
test04TokenShouldNotBePlacedAtOutOfBoundsPositionVertical

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	self should:  [terniLapilli placeTokenAt: 1@4.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 1@4).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXPlaceNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:21:16'!
test04_BISTokenShouldNotBePlacedAtOutOfBoundsPositionHorizontal

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	self should:  [terniLapilli placeTokenAt: 4@1.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 4@1).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXPlaceNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:40:10'!
test05TokenPlacedForXAndOShouldCount

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 2@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 2@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:40:41'!
test06ShouldNotPlaceTokenAfterAllHaveBeenPlaced

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should:[terniLapilli placeTokenAt: 1@1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 1@1).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli TokenPositioningAtMovingStageErrorDescription )]
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:45:32'!
test07TokenShouldNotBePlacedAfterXWinsByPlacing3TokensVertically

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self assert: (terniLapilli isXWinner ). ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:46:07'!
test07_BISTokenShouldNotBePlacedAfterSomeoneWins

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self should:[terniLapilli placeTokenAt: 2@1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 2@1). 
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert:(terniLapilli isFinished).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:46:40'!
test08TokenShouldNotBePlacedAfterOWinsByPlacing3TokensVertically
	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:46:55'!
test09TokenShouldNotBePlacedAfterXWinsByPlacing3TokensHorizontally
	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:47:32'!
test10TokenShouldNotBePlacedAfterOWinsByPlacing3TokensHorizontally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:47:44'!
test11TokenShouldNotBePlacedAfterXWinsByPlacing3TokensDiagonally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@1.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:48:00'!
test12TokenShouldNotBePlacedAfterOWinsByPlacing3TokensDiagonally

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@1.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:48:25'!
test13ShouldNotMoveTokenUntilAllHaveBeenPlaced

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@2.
	self should: [terniLapilli moveTokenAt: 1@2 to: 1@1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@1).
		self assert: (terniLapilli isXTokenAt: 1@2).
		self assert: (terniLapilli doesOPlaceNext).
		self assert: (anException messageText = TerniLapilli AllTokensShouldBePlacedErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 19:54:18'!
test14ShouldNotMoveFromAVacantPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should: [terniLapilli moveTokenAt: 1@2 to: 1@1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@1).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli TryingToMoveNonTokenErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:11:47'!
test15ShouldNotMoveATokenFromSomeoneElse

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should: [terniLapilli moveTokenAt: 2@2 to: 1@2.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@2).
		self assert: (terniLapilli isOTokenAt: 2@2).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli TokenOwnershipErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:24:01'!
test16TokenShouldNotBeMovedToOutOfBoundsPositionVertical

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should: [terniLapilli moveTokenAt: 3@3 to: 3@4.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 3@4).
		self assert: (terniLapilli isXTokenAt: 3@3).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:24:21'!
test16_BISTokenShouldNotBeMovedToOutOfBoundsPositionHorizontal

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should: [terniLapilli moveTokenAt: 3@3 to: 4@3.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 4@3).
		self assert: (terniLapilli isXTokenAt: 3@3).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:01:04'!
test17TokenShouldNotBeMovedToOccupiedPosition

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should: [terniLapilli moveTokenAt: 3@3 to: 3@2.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli OccupiedPositionErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:28:32'!
test18TokenMovementShouldFollowTheGameboardLayoutVerticalFarJump

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	self should: [terniLapilli moveTokenAt: 3@3 to: 1@3.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@3).
		self assert: (terniLapilli isXTokenAt: 3@3).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli GameboardLayoutErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:28:22'!
test18_2TokenMovementShouldFollowTheGameboardLayoutHorizontalFarJump

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	self should: [terniLapilli moveTokenAt: 3@3 to: 3@1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 3@1).
		self assert: (terniLapilli isXTokenAt: 3@3).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli GameboardLayoutErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:32:31'!
test18_3TokenMovementShouldFollowTheGameboardLayoutBadDiagonal

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	self should: [terniLapilli moveTokenAt: 3@2 to: 2@3.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 2@3).
		self assert: (terniLapilli isXTokenAt: 3@2).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli GameboardLayoutErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:33:30'!
test18_4TokenMovementShouldFollowTheGameboardLayoutBadDiagonalNegative

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	self should: [terniLapilli moveTokenAt: 2@1 to: 3@2.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 3@2).
		self assert: (terniLapilli isXTokenAt: 2@1).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli GameboardLayoutErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:12:27'!
test19ValidMovementShouldLeaveVacantSpace

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	self assert: (terniLapilli isVacant: 2@1).
	self assert: (terniLapilli isXTokenAt: 1@1).
	self assert: (terniLapilli doesOMoveNext)
		! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:38:17'!
test20TokenShouldNotBeMovedAfterSomeoneWinsByPlacing
	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self should:[terniLapilli moveTokenAt: 1@3 to: 1@2]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 1@2). 
		self assert: (terniLapilli isXTokenAt: 1@3).
		self assert:(terniLapilli isFinished).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:39:49'!
test20_BISTokenShouldNotBeMovedAfterSomeoneWinsByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli moveTokenAt:  2@3 to: 2@2.
	terniLapilli moveTokenAt:  2@1 to: 3@1.
	self should:[terniLapilli moveTokenAt: 3@1 to: 2@1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 2@1). 
		self assert: (terniLapilli isOTokenAt: 3@1).
		self assert:(terniLapilli isFinished).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:34:38'!
test23TokenShouldNotBeMovedAfterOWinsVerticallyByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli moveTokenAt:  2@3 to: 2@2.
	terniLapilli moveTokenAt:  2@1 to: 3@1.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:46:21'!
test23_2TokenShouldNotBeMovedAfterXWinsVerticallyByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	terniLapilli moveTokenAt:  2@1 to: 3@1.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:34:44'!
test24TokenShouldNotBeMovedAfterOWinsHorizontallyByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli moveTokenAt:  3@2 to: 2@2.
	terniLapilli moveTokenAt:  1@2 to: 1@3.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:47:48'!
test24_2TokenShouldNotBeMovedAfterXWinsHorizontallyByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli moveTokenAt:  1@2 to: 1@3.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:34:49'!
test25TokenShouldNotBeMovedAfterOWinsDiagonallyByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli moveTokenAt: 3@1 to: 3@2.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/5/2018 20:48:11'!
test25_2TokenShouldNotBeMovedAfterXWinsDiagonallyByMoving

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	
	self assert: (terniLapilli isXWinner).! !
