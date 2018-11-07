!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Test'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Test'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:03:47'!
test01InitialTerniLapilliShouldHaveNoTokensAndXShouldPlaceNext

	
	self assert: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:03:52'!
test02AfterFirstTokenOShouldPlaceNextAndPositionShouldBeOccupied


	terniLapilli placeTokenAt: 1@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesOPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:03:57'!
test03TokenShouldNotBePlacedAtOccupiedPosition

	
	terniLapilli placeTokenAt: 1@1.
	self should:  [terniLapilli placeTokenAt: 1@1.] raise: Error withExceptionDo: 
	[:anException|
		self deny: (terniLapilli isOTokenAt: 1@1). 
		self assert: (terniLapilli isXTokenAt: 1@1).
		self deny: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesOPlaceNext).
		self assert: (anException messageText = TerniLapilli OccupiedPositionErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:03'!
test04TokenShouldNotBePlacedAtOutOfBoundsPositionVertical

	self should:  [terniLapilli placeTokenAt: 1@4.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 1@4).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXPlaceNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:08'!
test05TokenShouldNotBePlacedAtOutOfBoundsPositionHorizontal

	self should:  [terniLapilli placeTokenAt: 4@1.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 4@1).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesXPlaceNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:13'!
test06ShouldNotPlaceTokenAfterAllHaveBeenPlaced

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:18'!
test07TokenPlacedForXAndOShouldCount

	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 2@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 2@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:25'!
test08XShouldWinAfterPlacing3TokensInVerticalLine
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self assert: (terniLapilli isXWinner ). ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:30'!
test09OShouldWinAfterPlacing3TokensInVerticalLine

	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:35'!
test10XShouldWinAfterPlacing3TokensInHorizontalLine
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:41'!
test11OShouldWinAfterPlacing3TokensInHorizontalLine
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:46'!
test12XShouldWinAfterPlacing3TokensInDiagonalLine
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@1.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:51'!
test13OShouldWinAfterPlacing3TokensInDiagonalLine
	
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@1.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:04:56'!
test14TokenShouldNotBePlacedAfterSomeoneWins
	
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
		self assert:(terniLapilli isXWinner).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:05'!
test15ShouldNotMoveTokenUntilAllHaveBeenPlaced
	
	terniLapilli placeTokenAt: 1@2.
	self should: [terniLapilli moveTokenAt: 1@2 to: 1@1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@1).
		self assert: (terniLapilli isXTokenAt: 1@2).
		self assert: (terniLapilli doesOPlaceNext).
		self assert: (anException messageText = TerniLapilli AllTokensShouldBePlacedErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:10'!
test16ShouldNotMoveFromAVacantPosition
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:15'!
test17TokenShouldNotBeMovedToOutOfBoundsPositionVertical
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:19'!
test18TokenShouldNotBeMovedToOutOfBoundsPositionHorizontal
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:24'!
test19ShouldNotMoveATokenFromSomeoneElse
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:29'!
test20TokenShouldNotBeMovedToOccupiedPosition
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:34'!
test21ShouldNotDoHorizontalFarMovement
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:40'!
test22ShouldNotDoVerticalFarMovement

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:45'!
test23ShouldNotDoBadInvertedDiagonalMovement
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:50'!
test24ShouldNotDoBadDiagonalMovement
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:55'!
test25ValidMovementShouldLeaveVacantSpace
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:05:59'!
test26TokenShouldNotBeMovedAfterSomeoneWinsByPlacing
	
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
		self assert:(terniLapilli isOWinner).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:02'!
test27TokenShouldNotBeMovedAfterOWinsVerticallyByMoving
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli moveTokenAt:  2@3 to: 2@2.
	terniLapilli moveTokenAt:  2@1 to: 3@1.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:10'!
test28TokenShouldNotBeMovedAfterXWinsVerticallyByMoving

	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	terniLapilli moveTokenAt:  2@1 to: 3@1.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:16'!
test29TokenShouldNotBeMovedAfterOWinsHorizontallyByMoving

	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli moveTokenAt:  3@2 to: 2@2.
	terniLapilli moveTokenAt:  1@2 to: 1@3.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:21'!
test30TokenShouldNotBeMovedAfterXWinsHorizontallyByMoving
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli moveTokenAt:  1@2 to: 1@3.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:26'!
test31TokenShouldNotBeMovedAfterOWinsDiagonallyByMoving
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli moveTokenAt: 3@1 to: 3@2.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:31'!
test32TokenShouldNotBeMovedAfterXWinsDiagonallyByMoving
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:06:37'!
test33TokenShouldNotBeMovedAfterSomeoneWinsByMoving
	
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
		self assert:(terniLapilli isOWinner).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !


!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:03:20'!
setUp

	terniLapilli := TerniLapilli new.! !
