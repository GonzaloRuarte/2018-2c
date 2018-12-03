!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/24/2018 13:59:32'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:37:54'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart addToCart: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:37:54'!
test04_2CanNotAddNonIntegerNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart addToCart: 1.5 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:37:54'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart addToCart: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:37:54'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart addToCart: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:38:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory validCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:38:50'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart addToCart: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory validCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:38:50'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:38:50'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory validCreditCard 
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:38:50'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory validCreditCard .
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:38:50'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory validCreditCard .
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'testObjectsFactory systemfacade clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:03'!
test01ShouldNotCreateCartWhenUserIsNotRegistered

	
	self should:
	[systemfacade createCartFor: testObjectsFactory nonRegisteredUserName authenticatedWith: testObjectsFactory incorrectUserPassword .]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibrosSystemFacade nonRegisteredUserErrorMessage ].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:03'!
test02ShouldNotCreateCartWhenPasswordDoesNotMatchUser

	self should:
	[systemfacade createCartFor: testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory incorrectUserPassword .]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibrosSystemFacade incorrectPasswordErrorMessage ].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test03CreatedCartShouldBeEmpty

	
	
	| cartID list |
	cartID:=systemfacade createCartFor: testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .

	list := systemfacade listCartIdentifiedBy: cartID.
	self assert: (list isEmpty).
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test04ShouldNotAddItemNotSoldByStoreToCart

	|cartID list |

	
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
		
	self should:[systemfacade add: 1 of: testObjectsFactory itemNotSellByTheStore toCartIdentifiedBy: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidItemErrorMessage .
		list := systemfacade listCartIdentifiedBy: cartID.
		self assert: list isEmpty]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test05ShouldNotAddNonPositiveAmountOfItemsToCart

	|cartID list |

	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
		
	self should:[systemfacade add: 0 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidQuantityErrorMessage.
		list := systemfacade listCartIdentifiedBy: cartID.
		self assert: list isEmpty]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test05_2ShouldNotAddNonIntegerAmountOfItemsToCart

	|cartID list |
	
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
		
	self should:[systemfacade add: 1.5 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidQuantityErrorMessage.
		list := systemfacade listCartIdentifiedBy: cartID.
		self assert: list isEmpty]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test06ShouldNotAddMoreThanOneItemNotSoldByStoreToCart

	| cartID list |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
		
	self should:[systemfacade add: 2 of: testObjectsFactory itemNotSellByTheStore toCartIdentifiedBy: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidItemErrorMessage .
		list := systemfacade listCartIdentifiedBy: cartID.
		self assert: list isEmpty]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test07CartShouldNotBeEmptyAfterAddingAnItem


	
	| cartID list |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	
	list := systemfacade listCartIdentifiedBy: cartID.
	self deny: list isEmpty! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test08ShouldListCartItemsAddedBeforehand

	| cartID list |
	
	
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	list := systemfacade listCartIdentifiedBy: cartID.
		
	self assert: (list includes: testObjectsFactory itemSellByTheStore).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test09ShouldNotListCartItemsThatWereNotAddedBeforehand

	| cartID list |
	

	
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	list := systemfacade listCartIdentifiedBy: cartID.
		
	self deny: (list includes: testObjectsFactory itemSellByTheStore).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:43'!
test10ShouldListCorrectAmountOfCartItemsAddedBeforehand

	|cartID list |
	
	
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	
	list := systemfacade listCartIdentifiedBy: cartID.
		
	self assert: (list occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:23:07'!
test11ShouldNotAddItemWhenCartIDIsInvalid

	
		
	self should:[systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: self invalidCartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidCartIDErrorMessage.]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:55:03'!
test12TwoCreatedCartsShouldHaveDifferentIDs


	
	| cartID |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	self deny: cartID = (systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword) .
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/27/2018 00:23:13'!
test13ShouldListCartWhenCartIDIsInvalid

	
		
	self should:[systemfacade listCartIdentifiedBy: self invalidCartID ]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidCartIDErrorMessage.]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test14ShouldNotCheckoutEmptyCart

	| cartID purchases |
	
		
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	self should:[
	systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: TusLibrosSystemFacade cartCanNotBeEmptyErrorMessage .
		purchases := systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
		self assert: purchases isEmpty.].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test15ShouldCheckoutWhenCartIDIsInvalid

		

	self should:[systemfacade checkOutCartIdentifiedBy: self invalidCartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibrosSystemFacade invalidCartIDErrorMessage.]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test16ShouldNotCheckoutWhenCreditCardIsExpired

		
	| cartID purchases |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	self should:[
	systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory expiredCreditCardYear.
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: TusLibrosSystemFacade canNotChargeAnExpiredCreditCardErrorMessage .
		purchases := systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
		self assert: purchases isEmpty.].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test17PurchasesListShouldNotBeEmptyAfterSuccessfullyCheckingOut


		
	| cartID purchases |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.
	
	purchases := systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
	self deny: purchases isEmpty.
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test18CheckoutShouldRegisterASale	
	
	| cartID purchases |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.	
	
	purchases := systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
	self assert: (purchases includes: testObjectsFactory itemSellByTheStore).
	self assert: (purchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 2.
	self assert: (purchases isTotal: 2* testObjectsFactory itemSellByTheStorePrice).
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:56:37'!
test19ShouldNotListPurchasesOfNonRegisteredUser


	self should:
	[systemfacade listPurchasesOf: testObjectsFactory nonRegisteredUserName authenticatingWith: testObjectsFactory registeredUserPassword.]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibrosSystemFacade nonRegisteredUserErrorMessage ].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/26/2018 23:56:36'!
test20ShouldNotListPurchasesWhenPasswordDoesNotMatchUser


	
	self should:
	[systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory incorrectUserPassword.]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibrosSystemFacade incorrectPasswordErrorMessage ].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test21ShouldNotListPurchasesOfSomeoneElse

		
	| cartID purchases |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.
		
	purchases := systemfacade listPurchasesOf: testObjectsFactory anotherRegisteredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
	self assert: purchases isEmpty.
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/1/2018 23:12:07'!
test22ShouldNotAddToCartAfter30MinutesOfInactivity



	| cartID list |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	self advanceTime: 1800*second.
	
	self should:
	[systemfacade add: 2 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.]
	raise: Error
	withExceptionDo:[
		:anError | self assert: anError messageText equals: TusLibrosSystemFacade cartInactiveForTooLongErrorMessage.
		self turnBackTime: 1800*second.
		list := systemfacade listCartIdentifiedBy: cartID.
		self assert: list isEmpty]
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/1/2018 23:12:04'!
test23ShouldNotListCartAfter30MinutesOfInactivity



	| cartID |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	self advanceTime: 1800*second.
	
	self should:
	[systemfacade listCartIdentifiedBy: cartID  ]
	raise: Error
	withExceptionDo:[
		:anError | self assert: anError messageText equals: TusLibrosSystemFacade cartInactiveForTooLongErrorMessage.]
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test24ShouldNotCheckoutAfter30MinutesOfInactivity

	| cartID purchases |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	systemfacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.
	
	self advanceTime: 1800*second.
	
	self should:
	[systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.]
	raise: Error
	withExceptionDo:[
		:anError | self assert: anError messageText equals: TusLibrosSystemFacade cartInactiveForTooLongErrorMessage.
		self turnBackTime: 1800*second.
		purchases := systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
		self assert: purchases isEmpty]
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/1/2018 23:12:00'!
test25AddingAnItemShouldExtendCartAvailabilityTimeframe


	| cartID list |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	self advanceTime: 900*second.
systemfacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.

	self advanceTime: 1799*second.
	list := systemfacade listCartIdentifiedBy: cartID.
	self assert: (list includes: testObjectsFactory itemSellByTheStore).
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/1/2018 23:11:53'!
test26ListingACartShouldExtendAvailabilityTimeframe

	| cartID list |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	
	self advanceTime: 900*second.
	systemfacade listCartIdentifiedBy: cartID.

	self advanceTime: 1799*second.
	list := systemfacade listCartIdentifiedBy: cartID.
	self assert: list isEmpty.
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 12/3/2018 12:37:45'!
test27CheckoutShouldExtendCartAvailabilityTimeframe


	| cartID purchases |
	cartID:=systemfacade createCartFor:  testObjectsFactory registeredUserName authenticatedWith: testObjectsFactory registeredUserPassword .
	systemfacade add: 3 of: testObjectsFactory itemSellByTheStore toCartIdentifiedBy: cartID.	
	self advanceTime: 900*second.

	
	systemfacade checkOutCartIdentifiedBy: cartID withCCnumberedBy: testObjectsFactory validNumberForCC ownedBy: testObjectsFactory validNameForCC expiringOnMonth: testObjectsFactory validCreditCardMonth andYear: testObjectsFactory validCreditCardYear.

	self advanceTime: 1799*second.

	systemfacade listCartIdentifiedBy: cartID.
	
	purchases := systemfacade listPurchasesOf: testObjectsFactory registeredUserName authenticatingWith: testObjectsFactory registeredUserPassword.
	self assert: (purchases includes: testObjectsFactory itemSellByTheStore).
	self assert: (purchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 3.
	self assert: (purchases isTotal: 3*testObjectsFactory itemSellByTheStorePrice).
! !


!TusLibrosTest methodsFor: 'setup' stamp: 'GR 11/26/2018 23:14:12'!
createDefaultTusLibros
	
	^TusLibrosSystemFacade authenticatingWith: testObjectsFactory defaultUserDatabase acceptingItemsOf: testObjectsFactory defaultCatalog debittingThrough: testObjectsFactory defaultMerchantProcessor registeringOn: testObjectsFactory defaultSalesLedger measuringTimeWith: clock! !

!TusLibrosTest methodsFor: 'setup' stamp: 'GR 11/27/2018 00:04:22'!
defaultClock
	^ManualClock new! !

!TusLibrosTest methodsFor: 'setup' stamp: 'GR 11/27/2018 00:27:19'!
invalidCartID
	^0! !

!TusLibrosTest methodsFor: 'setup' stamp: 'GR 11/26/2018 23:15:49'!
setUp 

	
	testObjectsFactory := StoreTestObjectsFactory new.
	clock := self defaultClock.
	systemfacade := self createDefaultTusLibros.
	
! !


!TusLibrosTest methodsFor: 'time manipulation' stamp: 'GR 11/26/2018 23:13:33'!
advanceTime: seconds
	clock advanceTime: seconds! !

!TusLibrosTest methodsFor: 'time manipulation' stamp: 'GR 11/26/2018 23:48:44'!
turnBackTime: seconds
	clock turnBackTime: seconds! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'GR 11/24/2018 14:00:05'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'GR 11/24/2018 14:00:09'!
assertIsValidQuantity: aQuantity

	(aQuantity strictlyPositive and: [aQuantity isInteger]) ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'GR 11/27/2018 00:10:15'!
do: aBlock

	items do: aBlock.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'GR 11/27/2018 00:37:54'!
add: anItem

	^ self addToCart: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'GR 11/27/2018 00:37:54'!
addToCart: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'GR 11/24/2018 13:59:18'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'GR 11/24/2018 13:59:01'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart systemFacade lastTimeUsed salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'assertions' stamp: 'GR 11/28/2018 11:37:02'!
assertCartIsNotInactiveThenDo: aBlock

	self assertWasCartActiveRecently.
	aBlock value: self.
	lastTimeUsed := self now.! !

!CartSession methodsFor: 'assertions' stamp: 'GR 12/1/2018 23:21:24'!
assertWasCartActiveRecently

	| timeElapsed|
	
	timeElapsed := lastTimeUsed distanceTo: self now .
	
	timeElapsed <(1800*second) ifFalse: [self error: self cartInactiveForTooLongErrorMessage]! !


!CartSession methodsFor: 'facade protocol' stamp: 'GR 11/28/2018 11:26:39'!
addToCart: anAmount of: anItem 


	cart addToCart: anAmount  of: anItem.! !

!CartSession methodsFor: 'facade protocol' stamp: 'GR 12/3/2018 12:24:06'!
checkoutCharging: creditCard through: merchantProcessor on: aDate


	(Cashier toCheckout: cart charging: creditCard through: merchantProcessor on: aDate registeringOn: salesBook) checkOut.! !

!CartSession methodsFor: 'facade protocol' stamp: 'GR 11/28/2018 11:27:43'!
listCartItems
	
	|list|
	
	list:=Bag new.
	
	cart do:[:anItem| list add: anItem].
	^list.! !


!CartSession methodsFor: 'initialization' stamp: 'GR 12/3/2018 12:26:43'!
initializeForCart: aCart ownedBy: anOwner registeringOn: aSalesBook forFacade: aSystemFacade

	cart:=aCart.
	owner :=anOwner.
	systemFacade:=aSystemFacade .
	lastTimeUsed := self now.
	salesBook := aSalesBook.! !


!CartSession methodsFor: 'date' stamp: 'ap 11/26/2018 20:51:30'!
now

	^systemFacade now.! !


!CartSession methodsFor: 'error messages' stamp: 'ap 11/26/2018 21:18:39'!
cartInactiveForTooLongErrorMessage

	^ systemFacade class cartInactiveForTooLongErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'GR 12/3/2018 12:26:06'!
acceptingItemsOf: aCatalog ownedBy: anOwner registeringOn: aSalesBook forFacade: aFacade

	|cart|
	cart := Cart acceptingItemsOf: aCatalog.

	^self new initializeForCart: cart ownedBy: anOwner registeringOn: aSalesBook forFacade: aFacade.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'GR 11/25/2018 19:19:23'!
createSale
	|list|
	
	list:=Bag new.
	cart do: [:anItem| list add: anItem].

	^ Sale for: list withTotal: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'GR 11/27/2018 00:38:37'!
initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'GR 11/27/2018 00:38:50'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'clock protocol' stamp: 'ap 11/26/2018 17:52:16'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'clock protocol' stamp: 'GR 11/26/2018 23:49:11'!
today

	self subclassResponsibility ! !


!classDefinition: #ManualClock category: #TusLibros!
Clock subclass: #ManualClock
	instanceVariableNames: 'offset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'protocol' stamp: 'GR 12/1/2018 22:55:31'!
now

	^GregorianDateTime now next: offset.! !

!ManualClock methodsFor: 'protocol' stamp: 'GR 12/1/2018 23:19:32'!
today

	^self now date.! !


!ManualClock methodsFor: 'initialization' stamp: 'GR 12/1/2018 22:56:41'!
initialize

	offset := 0*second.! !


!ManualClock methodsFor: 'time manipulation' stamp: 'GR 12/1/2018 22:57:17'!
advanceTime: seconds

	offset := offset + seconds.! !

!ManualClock methodsFor: 'time manipulation' stamp: 'GR 12/1/2018 22:57:22'!
turnBackTime: seconds

	offset := offset - seconds.! !


!classDefinition: #RealClock category: #TusLibros!
Clock subclass: #RealClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RealClock methodsFor: 'protocol' stamp: 'GR 12/1/2018 23:00:27'!
now

	^GregorianDateTime now.! !

!RealClock methodsFor: 'protocol' stamp: 'GR 12/1/2018 23:00:20'!
today

	^FixedGregorianDate today.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner ccn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'GR 12/1/2018 23:10:30'!
isExpiredOn: aDate 
	
	^expiration< (GregorianMonthOfYear year: aDate year month: aDate month)! !


!CreditCard methodsFor: 'initialization' stamp: 'GR 12/1/2018 23:07:28'!
initializeExpiringOn: aMonthOfYear forOwner: anOwner withNumber: aCCN
	
	expiration := aMonthOfYear.
	owner:= anOwner .
	ccn:=aCCN .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ap 11/22/2018 21:15:02'!
expiringOn: aMonth forOwner: aOwner withNumber: aCCN
	
	^self new initializeExpiringOn: aMonth forOwner: aOwner withNumber: aCCN! !


!classDefinition: #MerchantProcessorDummy category: #TusLibros!
Object subclass: #MerchantProcessorDummy
	instanceVariableNames: 'catalog items debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDummy methodsFor: 'initialization' stamp: 'ap 11/22/2018 21:39:21'!
initializeWithBehaviour: aBehaviour

	debitBehavior:= aBehaviour.! !


!MerchantProcessorDummy methodsFor: 'merchant processor protocol' stamp: 'ap 11/22/2018 21:38:42'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorDummy class' category: #TusLibros!
MerchantProcessorDummy class
	instanceVariableNames: ''!

!MerchantProcessorDummy class methodsFor: 'instance creation' stamp: 'ap 11/22/2018 21:39:53'!
withBehaviour: aDebitBehaviour

	^self new initializeWithBehaviour: aDebitBehaviour.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'GR 11/25/2018 18:09:51'!
initializeFor: aCollectionOfItems withTotal: aTotal

	total := aTotal.
	items := aCollectionOfItems.! !


!Sale methodsFor: 'queries' stamp: 'GR 11/27/2018 00:58:08'!
addItemsTo: aBag 
	aBag addAll: items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'GR 11/25/2018 18:09:55'!
for: aCollectionOfItems withTotal: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeFor: aCollectionOfItems withTotal: aTotal! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/1/2018 23:08:55'!
expiredCreditCard
	
	^CreditCard expiringOn: (GregorianMonthOfYear year: self expiredCreditCardYear month: self validCreditCardMonth) forOwner: self validNameForCC withNumber: self validNumberForCC.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/1/2018 23:06:33'!
expiredCreditCardYear
	
	^ today year previous: 1*year! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/1/2018 23:22:14'!
validCreditCard
	
	^CreditCard expiringOn: (GregorianMonthOfYear year: self validCreditCardYear month: self validCreditCardMonth) forOwner: self validNameForCC withNumber: self validNumberForCC.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/1/2018 23:04:12'!
validCreditCardMonth
	
	^ today monthOfYear month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/1/2018 23:06:03'!
validCreditCardYear
	
	^ today year next: 1*year! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ap 11/22/2018 21:17:51'!
validNameForCC
	^'Hernan Wilkinson'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 11/24/2018 13:53:13'!
validNumberForCC.

	^'validCardNumber'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'GR 12/1/2018 23:23:54'!
initialize

	today := GregorianDateTime now date! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'user password' stamp: 'GR 11/24/2018 13:51:25'!
incorrectUserPassword
	
	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'user password' stamp: 'ap 11/22/2018 19:57:01'!
registeredUserPassword
	
	^'validPassword'! !


!StoreTestObjectsFactory methodsFor: 'username' stamp: 'GR 11/25/2018 17:10:03'!
anotherRegisteredUserName
	
	^'anotherValidUser'! !

!StoreTestObjectsFactory methodsFor: 'username' stamp: 'ap 11/22/2018 19:59:49'!
nonRegisteredUserName
	
	^'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'username' stamp: 'ap 11/22/2018 19:56:50'!
registeredUserName
	
	^'validUser'! !


!StoreTestObjectsFactory methodsFor: 'tuslibros' stamp: 'GR 11/25/2018 20:28:42'!
defaultSalesLedger

	^Dictionary new
		at: self registeredUserName put: OrderedCollection new;
		at: self anotherRegisteredUserName put: OrderedCollection new;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'tuslibros' stamp: 'GR 11/25/2018 20:28:54'!
defaultUserDatabase
	
	^ Dictionary new
		at: self registeredUserName put: self registeredUserPassword;
		at: self anotherRegisteredUserName put: self registeredUserPassword;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'GR 11/25/2018 20:30:53'!
defaultMerchantProcessor

	^MerchantProcessorDummy withBehaviour: [ :anAmount :aCreditCard | ].! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'initialization' stamp: 'GR 11/27/2018 01:06:26'!
initializeFor: aSalesBook
	
	|bag|
	total := aSalesBook inject: 0 into: [:subTotal :aSale | subTotal + aSale total].
	bag := Bag new.
	aSalesBook do: [:aSale | aSale addItemsTo: bag].
	items := bag.! !


!Ticket methodsFor: 'testing' stamp: 'GR 11/27/2018 01:02:01'!
includes: anItem
	^items includes: anItem.! !

!Ticket methodsFor: 'testing' stamp: 'GR 11/27/2018 00:58:54'!
isEmpty
	
	^items isEmpty! !

!Ticket methodsFor: 'testing' stamp: 'GR 11/27/2018 01:04:56'!
isTotal: anAmount
	^total = anAmount! !

!Ticket methodsFor: 'testing' stamp: 'GR 11/27/2018 01:02:24'!
occurrencesOf: anItem
	^items occurrencesOf: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'GR 11/27/2018 00:43:18'!
for: aSalesBook

	^self new initializeFor: aSalesBook! !


!classDefinition: #TusLibrosSystemFacade category: #TusLibros!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'userDatabase catalog cartsSessions merchantProcessor salesLedger cartIDGenerator clock transactionIDGenerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'GR 11/26/2018 23:03:40'!
initializeAuthenticatingWith: aUserDatabase acceptingItemsOf: aCatalog debittingThrough: aMerchantProcessor registeringOn: aSalesLedger measuringTimeWith: aClock

	userDatabase := aUserDatabase .
	catalog:= aCatalog .
	cartsSessions := Dictionary new.
	cartIDGenerator:=0.
	transactionIDGenerator:=0.
	merchantProcessor := aMerchantProcessor .
	salesLedger := aSalesLedger .
	clock:= aClock.
! !


!TusLibrosSystemFacade methodsFor: 'assertions' stamp: 'ap 11/26/2018 20:53:44'!
assertCartIDIsValid: aCartID.

	cartsSessions at: aCartID ifAbsent:[
	self error: self class invalidCartIDErrorMessage].! !

!TusLibrosSystemFacade methodsFor: 'assertions' stamp: 'GR 11/27/2018 01:13:07'!
assertIsRegistered: aUsername authenticatedBy: aPassword

	(userDatabase at:aUsername  ifAbsent:[
	self error: self class nonRegisteredUserErrorMessage ] )= aPassword ifFalse:[
	self error: self class incorrectPasswordErrorMessage ].! !

!TusLibrosSystemFacade methodsFor: 'assertions' stamp: 'GR 11/28/2018 11:31:11'!
assertValidityOfCartIdentifiedBy:aCartID thenDo:aBlock

	self assertCartIDIsValid: aCartID.
	(cartsSessions at: aCartID) assertCartIsNotInactiveThenDo: aBlock
	! !


!TusLibrosSystemFacade methodsFor: 'ID generation - private' stamp: 'ap 11/26/2018 18:49:45'!
nextCartID

	|nextID|
	nextID:=cartIDGenerator .
	cartIDGenerator:=cartIDGenerator+1.
	^nextID.

! !

!TusLibrosSystemFacade methodsFor: 'ID generation - private' stamp: 'ap 11/26/2018 18:50:04'!
nextTransactionID

	|nextID|
	nextID:=transactionIDGenerator .
	transactionIDGenerator:=transactionIDGenerator+1.
	^nextID.

! !


!TusLibrosSystemFacade methodsFor: 'date' stamp: 'ap 11/26/2018 21:07:10'!
now
	^clock now.! !

!TusLibrosSystemFacade methodsFor: 'date' stamp: 'GR 11/26/2018 23:19:24'!
today
	^clock today.! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GR 11/28/2018 11:35:04'!
add: anAmount of: anItem toCartIdentifiedBy: aCartID

	self assertValidityOfCartIdentifiedBy:aCartID thenDo:
	[:cartSession| cartSession addToCart: anAmount of: anItem.].
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GR 12/3/2018 12:37:45'!
checkOutCartIdentifiedBy: aCartID withCCnumberedBy: aCCNumber ownedBy: aCCOwnerName expiringOnMonth: aCreditCardMonth andYear: aCreditCardYear 
	|creditCard|

	self assertValidityOfCartIdentifiedBy:aCartID thenDo:
	[:cartSession|
	
	
	creditCard:=CreditCard expiringOn: (GregorianMonthOfYear year: aCreditCardYear month: aCreditCardMonth) forOwner: aCCOwnerName withNumber: aCCNumber.
	cartSession checkoutCharging: creditCard through: merchantProcessor on: self today
	].
	^self nextTransactionID! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GR 12/3/2018 12:25:32'!
createCartFor: aUsername authenticatedWith: aPassword

	|cartID|
	self assertIsRegistered: aUsername authenticatedBy: aPassword.
	cartID:=self nextCartID.
	
	
	cartsSessions at:cartID put: (CartSession  acceptingItemsOf: catalog ownedBy: aUsername registeringOn: (salesLedger at: aUsername) forFacade: self).
		
	^ cartID.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GR 11/28/2018 11:35:19'!
listCartIdentifiedBy: aCartID 

	|list|
	self assertValidityOfCartIdentifiedBy:aCartID thenDo:
	[:cartSession|
	list:=cartSession  listCartItems.
	].
	
	^list.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GR 11/27/2018 01:11:27'!
listPurchasesOf: aUsername authenticatingWith: aPassword

	self assertIsRegistered: aUsername authenticatedBy: aPassword.

	^Ticket for: (salesLedger at: aUsername)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #TusLibros!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/26/2018 23:52:50'!
canNotChargeAnExpiredCreditCardErrorMessage
	^Cashier canNotChargeAnExpiredCreditCardErrorMessage! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/26/2018 23:52:30'!
cartCanNotBeEmptyErrorMessage
	^Cashier cartCanNotBeEmptyErrorMessage! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'ap 11/26/2018 17:56:29'!
cartInactiveForTooLongErrorMessage

	^'The cart was inactive for more than 30 minutes'! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/25/2018 19:48:52'!
incorrectPasswordErrorMessage

	^'The password does not match the username'! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/24/2018 13:44:56'!
invalidCartIDErrorMessage

	^'The requested cart is not active in the system'! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/26/2018 23:51:40'!
invalidItemErrorMessage
	^Cart invalidItemErrorMessage! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/26/2018 23:52:02'!
invalidQuantityErrorMessage
	^Cart invalidQuantityErrorMessage! !

!TusLibrosSystemFacade class methodsFor: 'error messages' stamp: 'GR 11/25/2018 19:49:36'!
nonRegisteredUserErrorMessage

	^'The user is not registered in the system'! !


!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'GR 11/26/2018 23:03:12'!
authenticatingWith: aUserDatabase acceptingItemsOf: aCatalog debittingThrough: aMerchantProcessor registeringOn: aSalesLedger measuringTimeWith: aClock

	^self new initializeAuthenticatingWith: aUserDatabase acceptingItemsOf: aCatalog debittingThrough: aMerchantProcessor registeringOn: aSalesLedger measuringTimeWith: aClock! !
