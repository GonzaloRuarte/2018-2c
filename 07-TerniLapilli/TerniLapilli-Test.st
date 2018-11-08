!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Test'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Test'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:28:36'!
test01InitialTerniLapilliShouldHaveNoTokensAndXShouldPlaceNext

	
	self xShouldPlaceFirst ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:27:21'!
test02AfterFirstTokenOShouldPlaceNextAndPositionShouldBeOccupied


	terniLapilli placeTokenAt: 1@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self oShouldPlaceAfterX! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:27:21'!
test03TokenShouldNotBePlacedAtOccupiedPosition

	
	terniLapilli placeTokenAt: 1@1.
	self should:  [terniLapilli placeTokenAt: 1@1.] raise: Error withExceptionDo: 
	[:anException|
		self deny: (terniLapilli isOTokenAt: 1@1). 
		self assert: (terniLapilli isXTokenAt: 1@1).
		self oShouldPlaceAfterX.
		self assert: (anException messageText = TerniLapilli OccupiedPositionErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:35:34'!
test04TokenShouldNotBePlacedAtOutOfBoundsPositionVertical

	self shouldRaiseOutOfBoundsErrorByPlacingAt: 1@4.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:35:34'!
test05TokenShouldNotBePlacedAtOutOfBoundsPositionHorizontal

	self shouldRaiseOutOfBoundsErrorByPlacingAt: 4@1.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:44:32'!
test06TokenPlacedForXAndOShouldCount

	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 2@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 2@1). 
	self bothPlayersShouldHaveTokensPlaced.
	self assert: (terniLapilli doesXPlaceNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test07ShouldNotPlaceTokenAfterAllHaveBeenPlaced

	self allTokensPlacedWithNoWinners .
	self should:[terniLapilli placeTokenAt: 3@1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 3@1).
		self bothPlayersShouldHaveTokensPlaced.
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli TokenPositioningAtMovingStageErrorDescription )]
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:47:37'!
test08XShouldWinAfterPlacing3TokensInVerticalLine
	
	self fivePlacementsWithWinnerVertical.
	self assert: (terniLapilli isXWinner ). ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:47:44'!
test09OShouldWinAfterPlacing3TokensInVerticalLine

	terniLapilli placeTokenAt: 1@3.
	self fivePlacementsWithWinnerVertical.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:48:35'!
test10XShouldWinAfterPlacing3TokensInHorizontalLine
	
	self fivePlacementsWithWinnerHorizontal.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:48:49'!
test11OShouldWinAfterPlacing3TokensInHorizontalLine
	
	terniLapilli placeTokenAt: 1@1.
	self fivePlacementsWithWinnerHorizontal.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:53:28'!
test12XShouldWinAfterPlacing3TokensInDiagonalLine
	
	self fivePlacementsWithWinnerStraightDiagonal.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:53:28'!
test13OShouldWinAfterPlacing3TokensInDiagonalLine
	
	terniLapilli placeTokenAt: 1@2.
	self fivePlacementsWithWinnerStraightDiagonal.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:55:00'!
test14XShouldWinAfterPlacing3TokensInDiagonalLineInverted
	
	self fivePlacementsWithWinnerInvertedDiagonal.
	self assert: (terniLapilli isXWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 00:55:52'!
test15OShouldWinAfterPlacing3TokensInDiagonalLineInverted
	
	terniLapilli placeTokenAt: 1@2.
	self fivePlacementsWithWinnerInvertedDiagonal.
	self assert: (terniLapilli isOWinner). 
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:04:32'!
test16TokenShouldNotBePlacedAfterSomeoneWins
	
	self fivePlacementsWithWinnerVertical.
	self should:[terniLapilli placeTokenAt: 2@1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 2@1). 
		self bothPlayersShouldHaveTokensPlaced.
		self assert:(terniLapilli isXWinner).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:03:10'!
test17ShouldNotMoveTokenUntilAllHaveBeenPlaced
	
	terniLapilli placeTokenAt: 1@2.
	self should: [terniLapilli moveTokenAt: 1@2 to: 1@1.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@1).
		self assert: (terniLapilli isXTokenAt: 1@2).
		self assert: (terniLapilli doesOPlaceNext).
		self assert: (anException messageText = TerniLapilli AllTokensShouldBePlacedErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test18ShouldNotMoveFromAVacantPosition
	
	self allTokensPlacedWithNoWinners .
	self should: [terniLapilli moveTokenAt: 3@1 to: 3@2.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 3@2).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli TryingToMoveNonTokenErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test19TokenShouldNotBeMovedToOutOfBoundsPositionVertical
	
	self allTokensPlacedWithNoWinners .
	self shouldRaiseOutOfBoundsErrorByMovingFrom: 3@3 To: 3@4.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test20TokenShouldNotBeMovedToOutOfBoundsPositionHorizontal
	
	self allTokensPlacedWithNoWinners .
	self shouldRaiseOutOfBoundsErrorByMovingFrom: 3@3 To: 4@3.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test21ShouldNotMoveATokenFromSomeoneElse
	
	self allTokensPlacedWithNoWinners .
	self should: [terniLapilli moveTokenAt: 2@2 to: 1@2.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: 1@2).
		self assert: (terniLapilli isOTokenAt: 2@2).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli TokenOwnershipErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 02:16:35'!
test22TokenShouldNotBeMovedToOccupiedPosition
	
	self allTokensPlacedWithNoWinners .
	self should: [terniLapilli moveTokenAt: 3@3 to: 2@3.]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isXTokenAt: 3@3).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli OccupiedPositionErrorDescription )]! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test23ShouldNotDoHorizontalFarMovement
	
	self allTokensPlacedWithNoWinners.	
	self shouldRaiseGameboardLayoutErrorMovingFrom: 1@1 To: 3@1.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test24ShouldNotDoVerticalFarMovement

	self allTokensPlacedWithNoWinners.
	self shouldRaiseGameboardLayoutErrorMovingFrom: 3@3 To: 3@1.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test25ShouldNotDoBadInvertedDiagonalMovement
	
	self allTokensPlacedWithNoWinners.
	self shouldRaiseGameboardLayoutErrorMovingFrom: 2@1 To: 1@2.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test26ShouldNotDoBadDiagonalMovement
	
	self allTokensPlacedWithNoWinners.
	self shouldRaiseGameboardLayoutErrorMovingFrom: 2@1 To: 3@2.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:55:14'!
test27ValidMovementShouldLeaveVacantSpace
	
	self allTokensPlacedWithNoWinners .
	terniLapilli moveTokenAt: 2@1 to: 3@1.
	
	self assert: (terniLapilli isVacant: 2@1).
	self assert: (terniLapilli isXTokenAt: 3@1).
	self assert: (terniLapilli doesOMoveNext)
		! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/7/2018 01:17:37'!
test28TokenShouldNotBeMovedAfterSomeoneWinsByPlacing
	
	terniLapilli placeTokenAt: 1@3.
	self fivePlacementsWithWinnerVertical.
	self shouldRaiseGameAlreadyOverErrorMovingFrom: 1@3 to: 1@2.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 00:56:35'!
test29TokenShouldNotBeMovedAfterOWinsVerticallyByMoving
	
	terniLapilli placeTokenAt: 1@3.
	self fivePlacementsToWinDiagonallyOrVerticallyByMoving .
	terniLapilli moveTokenAt:  1@2 to: 1@1.
	terniLapilli moveTokenAt:  3@3 to: 2@3.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 00:56:42'!
test30TokenShouldNotBeMovedAfterXWinsVerticallyByMoving

	self fivePlacementsToWinDiagonallyOrVerticallyByMoving .
	terniLapilli placeTokenAt: 1@3.
	terniLapilli moveTokenAt:  3@3 to: 2@3.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 01:00:53'!
test31TokenShouldNotBeMovedAfterOWinsHorizontallyByMoving

	terniLapilli placeTokenAt: 3@1.
	self fivePlacementsToWinDiagonallyInvertedOrHorizontallyByMoving.
	terniLapilli moveTokenAt:  2@1 to: 1@1.
	terniLapilli moveTokenAt:  3@3 to: 3@2.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 01:01:08'!
test32TokenShouldNotBeMovedAfterXWinsHorizontallyByMoving
	
	self fivePlacementsToWinDiagonallyInvertedOrHorizontallyByMoving.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli moveTokenAt:  3@3 to: 3@2.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 00:56:23'!
test33TokenShouldNotBeMovedAfterOWinsDiagonallyByMoving
	
	terniLapilli placeTokenAt: 1@3.
	self fivePlacementsToWinDiagonallyOrVerticallyByMoving.
	terniLapilli moveTokenAt: 3@1 to: 3@2.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 00:56:23'!
test34TokenShouldNotBeMovedAfterXWinsDiagonallyByMoving
	
	self fivePlacementsToWinDiagonallyOrVerticallyByMoving.
	terniLapilli placeTokenAt: 1@3.
	terniLapilli moveTokenAt: 2@1 to: 1@1.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 01:00:27'!
test35TokenShouldNotBeMovedAfterOWinsDiagonallyByMovingInverted
	
	terniLapilli placeTokenAt: 3@1.
	self fivePlacementsToWinDiagonallyInvertedOrHorizontallyByMoving .
	terniLapilli moveTokenAt: 1@3 to: 2@3.
	terniLapilli moveTokenAt: 1@2 to: 1@1.
	
	
	self assert: (terniLapilli isOWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 00:59:45'!
test36TokenShouldNotBeMovedAfterXWinsDiagonallyByMovingInverted
	
	self fivePlacementsToWinDiagonallyInvertedOrHorizontallyByMoving .
	terniLapilli placeTokenAt: 3@1.
	terniLapilli moveTokenAt: 1@2 to: 1@1.
	
	
	self assert: (terniLapilli isXWinner).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/8/2018 00:56:52'!
test37TokenShouldNotBeMovedAfterSomeoneWinsByMoving
	
	terniLapilli placeTokenAt: 1@3.
	self fivePlacementsToWinDiagonallyOrVerticallyByMoving.
	terniLapilli moveTokenAt:  1@2 to: 1@1.
	terniLapilli moveTokenAt:  3@3 to: 2@3.
	self shouldRaiseGameAlreadyOverErrorMovingFrom: 1@1 to: 1@2.! !


!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 01:55:14'!
allTokensPlacedWithNoWinners

	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 1@3.
	! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:44:10'!
bothPlayersShouldHaveTokensPlaced

	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/8/2018 00:58:49'!
fivePlacementsToWinDiagonallyInvertedOrHorizontallyByMoving

	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@1.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 1@2.
	
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/8/2018 00:56:23'!
fivePlacementsToWinDiagonallyOrVerticallyByMoving

	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 1@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
	terniLapilli placeTokenAt: 2@1.
	
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:48:19'!
fivePlacementsWithWinnerHorizontal
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 1@3.
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:54:11'!
fivePlacementsWithWinnerInvertedDiagonal
	
	terniLapilli placeTokenAt: 1@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 3@1.
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:53:28'!
fivePlacementsWithWinnerStraightDiagonal
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 1@1.
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:47:19'!
fivePlacementsWithWinnerVertical
	
	terniLapilli placeTokenAt: 3@3.
	terniLapilli placeTokenAt: 2@3.
	terniLapilli placeTokenAt: 3@2.
	terniLapilli placeTokenAt: 2@2.
	terniLapilli placeTokenAt: 3@1.
! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:27:21'!
oShouldPlaceAfterX

		self deny: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli doesOPlaceNext).! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:03:20'!
setUp

	terniLapilli := TerniLapilli new.! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 01:22:06'!
shouldRaiseGameAlreadyOverErrorMovingFrom: aPosition to: anotherPosition

	self should:[terniLapilli moveTokenAt: aPosition to: anotherPosition]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: anotherPosition). 
		self assert: (terniLapilli isXTokenAt: aPosition).
		self assert:(terniLapilli isOWinner).
		self assert: (anException messageText = TerniLapilli GameAlreadyOverErrorDescription )]! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 01:21:54'!
shouldRaiseGameboardLayoutErrorMovingFrom: aPosition To: anotherPosition

	self should: [terniLapilli moveTokenAt: aPosition to: anotherPosition.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: anotherPosition).
		self assert: (terniLapilli isXTokenAt: aPosition).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli GameboardLayoutErrorDescription )]! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 01:06:52'!
shouldRaiseOutOfBoundsErrorByMovingFrom: aPosition To: anotherPosition

	self should: [terniLapilli moveTokenAt: aPosition to: anotherPosition.]
	raise: Error
	withExceptionDo:[:anException| 
		self assert: (terniLapilli isVacant: anotherPosition).
		self assert: (terniLapilli isXTokenAt: aPosition).
		self assert: (terniLapilli doesXMoveNext).
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:35:34'!
shouldRaiseOutOfBoundsErrorByPlacingAt: aPosition

	self should:  [terniLapilli placeTokenAt: aPosition.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: aPosition).
		self xShouldPlaceFirst.
		self assert: (anException messageText = TerniLapilli OutOfBoundsErrorDescription )]! !

!TerniLapilliTest methodsFor: 'setup' stamp: 'GR 11/7/2018 00:28:13'!
xShouldPlaceFirst

	
	self assert: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli doesXPlaceNext)
	! !
