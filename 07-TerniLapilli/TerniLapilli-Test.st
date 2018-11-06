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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:00:13'!
test05TokenShouldNotBePlacedAtOutOfBoundsPositionHorizontal

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	self should:  [terniLapilli placeTokenAt: 4@1.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 4@1).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXPlaceNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:00:31'!
test07TokenPlacedForXAndOShouldCount

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 2@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 2@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:10:04'!
test08XShouldWinAfterPlacing3TokensInVerticalLine

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self assert: (terniLapilli isXWinner ). ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:10:35'!
test09OShouldWinAfterPlacing3TokensInVerticalLine
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:11:16'!
test10XShouldWinAfterPlacing3TokensInHorizontalLine
	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:11:31'!
test11OShouldWinAfterPlacing3TokensInHorizontalLine

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:11:52'!
test12XShouldWinAfterPlacing3TokensInDiagonalLine

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@1.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:12:03'!
test13OShouldWinAfterPlacing3TokensInDiagonalLine

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:02:32'!
test14TokenShouldNotBePlacedAfterSomeoneWins

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:02:50'!
test15ShouldNotMoveTokenUntilAllHaveBeenPlaced

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:03:00'!
test16ShouldNotMoveFromAVacantPosition

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:07:27'!
test17TokenShouldNotBeMovedToOutOfBoundsPositionVertical

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:07:14'!
test18TokenShouldNotBeMovedToOutOfBoundsPositionHorizontal

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:07:02'!
test19ShouldNotMoveATokenFromSomeoneElse

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:06:50'!
test20TokenShouldNotBeMovedToOccupiedPosition

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:14:34'!
test21ShouldNotDoHorizontalFarMovement

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:15:12'!
test22ShouldNotDoVerticalFarMovement

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:54:40'!
test23ShouldNotDoBadInvertedDiagonalMovement

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:54:57'!
test24ShouldNotDoBadDiagonalMovement

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:05:33'!
test25ValidMovementShouldLeaveVacantSpace

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:05:19'!
test26TokenShouldNotBeMovedAfterSomeoneWinsByPlacing
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:05:09'!
test27TokenShouldNotBeMovedAfterOWinsVerticallyByMoving

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:04:58'!
test28TokenShouldNotBeMovedAfterXWinsVerticallyByMoving

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:04:48'!
test29TokenShouldNotBeMovedAfterOWinsHorizontallyByMoving

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:04:37'!
test30TokenShouldNotBeMovedAfterXWinsHorizontallyByMoving

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:04:06'!
test31TokenShouldNotBeMovedAfterOWinsDiagonallyByMoving

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:04:16'!
test32TokenShouldNotBeMovedAfterXWinsDiagonallyByMoving

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/6/2018 00:04:27'!
test33TokenShouldNotBeMovedAfterSomeoneWinsByMoving

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
