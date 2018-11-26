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

!CartTest methodsFor: 'tests' stamp: 'GR 11/24/2018 13:59:36'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/25/2018 19:45:12'!
test04_2CanNotAddNonIntegerNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 1.5 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'GR 11/24/2018 13:59:41'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
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

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
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

!CashierTest methodsFor: 'tests' stamp: 'GR 11/24/2018 14:00:31'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory validCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/24/2018 14:00:37'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory validCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/24/2018 14:00:43'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory validCreditCard 
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/24/2018 14:00:50'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory validCreditCard .
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/24/2018 14:00:58'!
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
		throught: self
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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:27:46'!
test01ShouldNotCreateCartWhenUserIsNotRegistered

	|tusLibros|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	self should:
	[tusLibros createCartforUser: testObjectsFactory nonRegisteredUserName usingPassword: testObjectsFactory incorrectUserPassword .]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibros nonRegisteredUserErrorMessage ].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:30:16'!
test02ShouldNotCreateCartWhenPasswordDoesNotMatchUser

	|tusLibros|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	self should:
	[tusLibros createCartforUser: testObjectsFactory registeredUserName usingPassword: testObjectsFactory incorrectUserPassword .]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibros incorrectPasswordErrorMessage ].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:30:19'!
test03CreatedCartShouldBeEmpty
	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	
	cartID:=tusLibros createCartforUser: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .

	self assert: (tusLibros isEmpty: cartID).
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:30:22'!
test04ShouldNotAddItemNotSoldByStoreToCart

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
		
	self should:[tusLibros add: 1 of: testObjectsFactory itemNotSellByTheStore toCart: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: Cart invalidItemErrorMessage .
		self assert: (tusLibros isEmpty: cartID)]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:31:44'!
test05ShouldNotAddNonPositiveAmountOfItemsToCart

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
		
	self should:[tusLibros add: 0 of: testObjectsFactory itemSellByTheStore toCart: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: Cart invalidQuantityErrorMessage.
		self assert: (tusLibros isEmpty: cartID)]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:31:57'!
test05_2ShouldNotAddNonIntegerAmountOfItemsToCart

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
		
	self should:[tusLibros add: 1.5 of: testObjectsFactory itemSellByTheStore toCart: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: Cart invalidQuantityErrorMessage.
		self assert: (tusLibros isEmpty: cartID)]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:32:51'!
test06ShouldNotAddMoreThanOneItemNotSoldByStoreToCart

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
		
	self should:[tusLibros add: 2 of: testObjectsFactory itemNotSellByTheStore toCart: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: Cart invalidItemErrorMessage .
		self assert: (tusLibros isEmpty: cartID)]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:32:54'!
test07CartShouldNotBeEmptyAfterAddingAnItem

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	
	self deny: (tusLibros isEmpty: cartID).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:32:57'!
test08ShouldListCartItemsAddedBeforehand

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	
	self assert: (tusLibros cartOfID: cartID includes: testObjectsFactory itemSellByTheStore).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:32:59'!
test09ShouldNotListCartItemsThatWereNotAddedBeforehand

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	self deny: (tusLibros cartOfID: cartID includes: testObjectsFactory itemSellByTheStore).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:03'!
test10ShouldListCorrectAmountOfCartItemsAddedBeforehand

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	
	self assert: (tusLibros cartOfID: cartID occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:05'!
test11ShouldNotAddItemWhenCartIDIsInvalid

	|tusLibros|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
		
	self should:[tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: 3]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: TusLibros invalidCartIDErrorMessage.]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:09'!
test12TwoCreatedCartsShouldHaveDifferentIDs

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	self deny: cartID = (tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword) .
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:11'!
test13ShouldNotCheckoutEmptyCart

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
		
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	self should:[
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory expiredCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC .
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: Cashier cartCanNotBeEmptyErrorMessage .
		self assert: (tusLibros isPurchasesListEmptyFor: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword).].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:32:33'!
test14ShouldNotCheckoutWhenCreditCardHasInsufficientFunds

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createTusLibrosWithMerchantProcessorBehaviour: [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
		
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	self should:[
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory validCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC .
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: Cashier creditCardHasNoCreditErrorMessage .
		self assert: (tusLibros isPurchasesListEmptyFor: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword).].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:15'!
test15ShouldNotCheckoutWhenCreditCardIsExpired

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
		
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	self should:[
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory expiredCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC .
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: Cashier canNotChargeAnExpiredCreditCardErrorMessage .
		self assert: (tusLibros isPurchasesListEmptyFor: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword).].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 21:05:12'!
test16PurchasesListShouldNotBeEmptyAfterSuccessfullyCheckingOut

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
		
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory validCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC.
	
	self deny: (tusLibros isPurchasesListEmptyFor: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword).
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:26'!
test17CheckoutShouldRegisterASale

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
	
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory validCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC.	
	
	self assert: (tusLibros isSaleRegistered: testObjectsFactory defaultSale forUser: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword ).
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:55:20'!
test18CheckoutShouldChargeCreditCardUsingMerchantProcessor

	|tusLibros cartID debitedAmount debitedCreditCard |
	
	tusLibros:= testObjectsFactory createTusLibrosWithMerchantProcessorBehaviour: [ :anAmount :aCreditCard | 
		debitedAmount := anAmount.
		debitedCreditCard := aCreditCard ] .
	
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory validCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC.	
	
	self assert: debitedAmount = testObjectsFactory itemSellByTheStorePrice .
	self assert: debitedCreditCard isTheDefaultCreditCard.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:31'!
test19ShouldNotListPurchasesOfNonRegisteredUser

	|tusLibros|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .

	self should:
	[tusLibros listPurchasesFor: testObjectsFactory nonRegisteredUserName usingPassword: testObjectsFactory registeredUserPassword.]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibros nonRegisteredUserErrorMessage ].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:33'!
test20ShouldNotListPurchasesWhenPasswordDoesNotMatchUser

	|tusLibros|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .

	
	self should:
	[tusLibros listPurchasesFor: testObjectsFactory registeredUserName usingPassword: testObjectsFactory incorrectUserPassword.]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: TusLibros incorrectPasswordErrorMessage ].
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:37'!
test21ShouldNotListPurchasesOfSomeoneElse

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
		
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory validCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC.
		
	self deny: (tusLibros isSaleRegistered: testObjectsFactory defaultSale forUser: testObjectsFactory anotherRegisteredUserName usingPassword: testObjectsFactory registeredUserPassword).
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 20:33:39'!
test22BoughtItemShouldAppearAtPurchasesList

	|tusLibros cartID|
	
	tusLibros:= testObjectsFactory createDefaultTusLibros .
		
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	tusLibros checkOutCart: cartID andCreditCardMonth: testObjectsFactory validCreditCardMonth andCreditCardYear: testObjectsFactory validCreditCardYear andCCOwner: testObjectsFactory validNameForCC andCCNumber: testObjectsFactory validNumberForCC.
		
	self assert: (tusLibros isItemIncludedInSales: testObjectsFactory itemSellByTheStore forUser: testObjectsFactory registeredUserName usingPassword: testObjectsFactory registeredUserPassword).
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'GR 11/25/2018 17:07:19'!
testXXManipularTiempo
! !


!TusLibrosTest methodsFor: 'setup' stamp: 'ap 11/22/2018 19:36:18'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
! !


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


!Cart methodsFor: 'queries' stamp: 'ap 11/22/2018 20:58:57'!
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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

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


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
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


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner ccn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

!CreditCard methodsFor: 'testing' stamp: 'GR 11/25/2018 21:01:44'!
isTheDefaultCreditCard
	^owner = 'Hernan Wilkinson' and: [ccn = 'validCardNumber'] and: [expiration = (Month month: DateAndTime now monthIndex year: DateAndTime now yearNumber + 1)]! !


!CreditCard methodsFor: 'initialization' stamp: 'ap 11/22/2018 21:15:19'!
initializeExpiringOn: aMonth forOwner: anOwner withNumber: aCCN
	
	expiration := aMonth.
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


!Sale methodsFor: 'testing' stamp: 'AP 11/25/2018 16:34:29'!
hasSameTotalAs: otherSale
	
	^ total = otherSale total.! !

!Sale methodsFor: 'testing' stamp: 'GR 11/25/2018 18:03:44'!
isItemSold: anItem 
	^items includes: anItem! !

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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 11/24/2018 13:53:13'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) forOwner: self validNameForCC withNumber: self validNumberForCC.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AP 11/25/2018 19:04:37'!
expiredCreditCardYear
	
	^ today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 11/24/2018 13:53:13'!
validCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) forOwner: self validNameForCC withNumber: self validNumberForCC.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AP 11/25/2018 19:04:11'!
validCreditCardMonth
	
	^ today monthIndex! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AP 11/25/2018 19:04:30'!
validCreditCardYear
	
	^ today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ap 11/22/2018 21:17:51'!
validNameForCC
	^'Hernan Wilkinson'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 11/24/2018 13:53:13'!
validNumberForCC.

	^'validCardNumber'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


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


!StoreTestObjectsFactory methodsFor: 'tuslibros' stamp: 'GR 11/25/2018 20:34:14'!
createDefaultTusLibros
	
	^TusLibros with: self defaultUserDatabase andCatalog: self defaultCatalog andMerchantProcessor: self defaultMerchantProcessor andSalesLedger: self defaultSalesLedger! !

!StoreTestObjectsFactory methodsFor: 'tuslibros' stamp: 'GR 11/25/2018 20:28:54'!
createTusLibrosWithMerchantProcessorBehaviour: aBehaviour
	
	^TusLibros with: self defaultUserDatabase andCatalog: self defaultCatalog andMerchantProcessor: (self merchantProcessorWithBehaviour: aBehaviour) andSalesLedger: self defaultSalesLedger! !

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

!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'GR 11/25/2018 20:26:42'!
merchantProcessorWithBehaviour: aBehaviour

	^MerchantProcessorDummy withBehaviour: aBehaviour.! !


!StoreTestObjectsFactory methodsFor: 'sale' stamp: 'GR 11/25/2018 20:29:54'!
defaultSale

	^Sale for:(Bag with: self itemSellByTheStore ) withTotal: self itemSellByTheStorePrice .! !


!classDefinition: #TusLibros category: #TusLibros!
Object subclass: #TusLibros
	instanceVariableNames: 'userDatabase catalog carts merchantProcessor salesLedger cartIDGenerator usersByCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibros methodsFor: 'initialization' stamp: 'GR 11/25/2018 17:46:42'!
initializeWith: aUserDatabase andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesLedger: aSalesLedger

	userDatabase := aUserDatabase .
	catalog:= aCatalog .
	carts:= Dictionary new.
	cartIDGenerator:=0.
	merchantProcessor := aMerchantProcessor .
	salesLedger := aSalesLedger .
	usersByCartID := Dictionary new.! !


!TusLibros methodsFor: 'assertions' stamp: 'GR 11/25/2018 19:49:14'!
assertPassword: aPassword matchesUser: aUsername.
	
	(userDatabase at: aUsername) = aPassword ifFalse:[
	self error: self class incorrectPasswordErrorMessage ].! !

!TusLibros methodsFor: 'assertions' stamp: 'GR 11/25/2018 19:50:06'!
assertUserInDatabase: aUsername.
	
	
	userDatabase at:aUsername  ifAbsent:[
	self error: self class nonRegisteredUserErrorMessage ].! !


!TusLibros methodsFor: 'queries' stamp: 'GR 11/25/2018 19:19:15'!
listCart: aCartID 

	|cart list|
	
	cart:=carts at: aCartID .
	list:=Bag new.
	cart do: [:anItem| list add: anItem].
	
	^list.! !


!TusLibros methodsFor: 'adding' stamp: 'GR 11/24/2018 13:39:15'!
add: anAmount of: anItem toCart: aCartID

	|cart|
	cart:=carts at: aCartID ifAbsent:[
	self error: self class invalidCartIDErrorMessage].

	cart add: anAmount of: anItem.! !


!TusLibros methodsFor: 'checkout - private' stamp: 'GR 11/25/2018 17:50:33'!
salesBookFor: aCartID

	^salesLedger at: (usersByCartID at: aCartID)! !


!TusLibros methodsFor: 'checkout' stamp: 'GR 11/25/2018 21:03:13'!
checkOutCart: aCartID andCreditCardMonth: aCreditCardMonth andCreditCardYear: aCreditCardYear andCCOwner: aCCOwnerName andCCNumber: aCCNumber

	|cart creditCard|
	
	cart:=carts at: aCartID .
	creditCard:=CreditCard expiringOn: (Month month: aCreditCardMonth year: aCreditCardYear) forOwner: aCCOwnerName withNumber: aCCNumber.
	(Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: DateAndTime now registeringOn: ( self salesBookFor: aCartID)) checkOut.
	^aCartID! !


!TusLibros methodsFor: 'ID generation - private' stamp: 'GR 11/25/2018 17:33:36'!
nextID

	|nextID|
	nextID:=cartIDGenerator .
	cartIDGenerator:=cartIDGenerator+1.
	^nextID.

! !


!TusLibros methodsFor: 'purchases' stamp: 'GR 11/25/2018 17:34:46'!
listPurchasesFor: aUsername usingPassword: aPassword

	self assertUserInDatabase: aUsername.
	self assertPassword: aPassword matchesUser: aUsername.

	^(salesLedger at: aUsername)! !


!TusLibros methodsFor: 'cart creation' stamp: 'GR 11/25/2018 17:47:58'!
createCartforUser: aUsername usingPassword: aPassword

	|cartID|
	self assertUserInDatabase: aUsername.
	self assertPassword: aPassword matchesUser: aUsername.

	cartID:=self nextID.
	carts at:cartID put: (Cart acceptingItemsOf: catalog).
	usersByCartID at: cartID put: aUsername.
	
	^ cartID.! !


!TusLibros methodsFor: 'testing' stamp: 'GR 11/25/2018 16:56:10'!
cartOfID: aCartID includes: anItem
	^(carts at: aCartID) includes: anItem! !

!TusLibros methodsFor: 'testing' stamp: 'GR 11/25/2018 19:44:16'!
cartOfID: aCartID occurrencesOf: anItem
	^(carts at: aCartID) occurrencesOf: anItem! !

!TusLibros methodsFor: 'testing' stamp: 'GR 11/25/2018 16:54:58'!
isEmpty: aCartID
	^(carts at: aCartID) isEmpty! !

!TusLibros methodsFor: 'testing' stamp: 'GR 11/25/2018 18:02:16'!
isItemIncludedInSales: anItem forUser: aUsername usingPassword: aPassword
	
	^(self listPurchasesFor: aUsername usingPassword: aPassword) anySatisfy: [:aSale| aSale isItemSold: anItem]! !

!TusLibros methodsFor: 'testing' stamp: 'GR 11/25/2018 18:01:59'!
isPurchasesListEmptyFor: aUsername usingPassword: aPassword

	^(self listPurchasesFor: aUsername usingPassword: aPassword) isEmpty! !

!TusLibros methodsFor: 'testing' stamp: 'GR 11/25/2018 20:21:37'!
isSaleRegistered: aSale forUser: aUsername usingPassword: aPassword

	|list|
	list := (self listPurchasesFor: aUsername usingPassword: aPassword).
	^(list size = 1 )and: [list anySatisfy: [:anotherSale | anotherSale hasSameTotalAs: aSale]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibros class' category: #TusLibros!
TusLibros class
	instanceVariableNames: ''!

!TusLibros class methodsFor: 'error messages' stamp: 'GR 11/25/2018 19:48:52'!
incorrectPasswordErrorMessage

	^'The password does not match the username'! !

!TusLibros class methodsFor: 'error messages' stamp: 'GR 11/24/2018 13:44:56'!
invalidCartIDErrorMessage

	^'The requested cart is not active in the system'! !

!TusLibros class methodsFor: 'error messages' stamp: 'GR 11/25/2018 19:49:36'!
nonRegisteredUserErrorMessage

	^'The user is not registered in the system'! !


!TusLibros class methodsFor: 'instance creation' stamp: 'GR 11/25/2018 17:38:19'!
with: aUserDatabase andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesLedger: aSalesLedger

	^self new initializeWith: aUserDatabase andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesLedger: aSalesLedger .! !
