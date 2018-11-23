!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 19:36:18'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test01usuarioInvalido

	|interfaz|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	self should:
	[interfaz createCartforUser: testObjectsFactory nonRegisteredUserName withPassword: testObjectsFactory nonRegisteredUserPassword .]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: 'Usuario invalido'].
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test02PasswordInvalida

	|interfaz|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	self should:
	[interfaz createCartforUser: testObjectsFactory registeredUserName withPassword: testObjectsFactory nonRegisteredUserPassword .]
	raise: Error
	withExceptionDo:
	[:exception| self assert: exception messageText equals: 'Password invalida'].
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test03ListOFCreatedCartIsEmpty
	|interfaz cartID|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	
	cartID:=interfaz createCartforUser: testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword .

	self assert: (interfaz listCart: cartID) isEmpty.
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test04TwoCreatedCartsHaveDifferentCartIDs

	|interfaz cartID|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	
	cartID:=interfaz createCartforUser:  testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword .
	
	self deny: cartID = (interfaz createCartforUser:  testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword) .
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test05ShouldNotAddItemWhenCartIDIsInvalid

	|interfaz|
	
	interfaz:= testObjectsFactory createTusLibros .
	
		
	self should:[interfaz add: 2 of: testObjectsFactory itemSellByTheStore toCart: 3]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: 'Invalid cart id']! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test06ShouldNotAddItemWhenCartCantAddItem

	|interfaz cartID|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	cartID:=interfaz createCartforUser:  testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword .
		
	self should:[interfaz add: 2 of: testObjectsFactory itemNotSellByTheStore toCart: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: 'Item is not in catalog']! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test06ShouldNotAddItemWhenCartDoesNotSellItem

	|interfaz cartID|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	cartID:=interfaz createCartforUser:  testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword .
		
	self should:[interfaz add: 2 of: testObjectsFactory itemNotSellByTheStore toCart: cartID]
	raise: Error
	withExceptionDo:[:anException|
		self assert: anException messageText equals: 'Item is not in catalog']! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:25:20'!
test07ListOfCartShouldContainItemsAddedBeforehand

	|interfaz cartID|
	
	interfaz:= testObjectsFactory createTusLibros .
	
	cartID:=interfaz createCartforUser:  testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword .
	
	interfaz add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	
	self assert: ((interfaz listCart: cartID) includes: testObjectsFactory itemSellByTheStore).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:42:26'!
test08ChechoutFailsWithInvalidCreditCard

	|tusLibros cartID creditCard|
	
	tusLibros:= testObjectsFactory createTusLibros .
	
	creditCard:= testObjectsFactory expiredCreditCard.
	
	cartID:=tusLibros createCartforUser:  testObjectsFactory registeredUserName withPassword: testObjectsFactory registeredUserPassword .
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	self should:[
	tusLibros checkOutCart: cartID withCreditCard: creditCard .
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: 'Can not charge an expired credit card'].
	
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
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

!MerchantProcessorDummy methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:38:42'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!MerchantProcessorDummy methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:39:21'!
initializeWithBehaviour: aBehaviour

	debitBehavior:= aBehaviour.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorDummy class' category: #TusLibros!
MerchantProcessorDummy class
	instanceVariableNames: ''!

!MerchantProcessorDummy class methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:39:53'!
withBehaviour: aDebitBehaviour

	^self new initializeWithBehaviour: aDebitBehaviour.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ap 11/22/2018 19:59:49'!
nonRegisteredUserName
	
	^'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ap 11/22/2018 19:59:36'!
nonRegisteredUserPassword
	
	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ap 11/22/2018 19:56:50'!
registeredUserName
	
	^'validUser'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ap 11/22/2018 19:57:01'!
registeredUserPassword
	
	^'validPassword'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ap 11/22/2018 21:37:11'!
createTusLibros
	
	^TusLibros with: self userDatabase andCatalog: self defaultCatalog andMerchantProcessor: self merchantProcessor andSalesBook: self salesBook! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ap 11/22/2018 21:40:43'!
merchantProcessor

	^MerchantProcessorDummy withBehaviour: [ :anAmount :aCreditCard | ].! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ap 11/22/2018 21:37:56'!
salesBook

	^OrderedCollection  new.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ap 11/22/2018 19:56:31'!
userDatabase
	
	^ Dictionary new
		at: self registeredUserName put: self registeredUserPassword;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ap 11/22/2018 21:17:24'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) forOwner: self validNameForCC withNumber: self validaNumberForCC.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ap 11/22/2018 21:17:34'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) forOwner: self validNameForCC withNumber: self validaNumberForCC.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ap 11/22/2018 21:17:51'!
validNameForCC
	^'Hernan Wilkinson'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ap 11/22/2018 21:18:20'!
validaNumberForCC.

	^'validCardNumber'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibros category: #TusLibros!
Object subclass: #TusLibros
	instanceVariableNames: 'userDatabase counter catalog carts merchantProcessor date salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibros methodsFor: 'initialization' stamp: 'ap 11/22/2018 21:31:58'!
checkOutCart: cartID withCreditCard: creditCard

	|cart |
	
	cart:=carts at: cartID .
	
	Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: DateAndTime now registeringOn: salesBook.! !

!TusLibros methodsFor: 'initialization' stamp: 'ap 11/22/2018 20:45:29'!
createCartforUser: user withPassword: password

|cartID|
	self assertUserInDatabase: user.
	self assertPassword: password forUser: user.

	cartID:=self nextID.
	carts at:cartID put: (Cart acceptingItemsOf: catalog).
	
	^ cartID.! !

!TusLibros methodsFor: 'initialization' stamp: 'ap 11/22/2018 21:30:43'!
initializeWith: aUserDatabase andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesBook: aSalesBook

	userDatabase := aUserDatabase .
	catalog:= aCatalog .
	carts:= Dictionary new.
	counter:=0.
	merchantProcessor := aMerchantProcessor .
	salesBook := aSalesBook .! !

!TusLibros methodsFor: 'initialization' stamp: 'ap 11/22/2018 20:26:27'!
nextID

	|nextID|
	nextID:=counter.
	counter:=counter+1.
	^nextID.

! !


!TusLibros methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 19:54:35'!
assertPassword: password forUser: user.
	
	(userDatabase at: user) = password ifFalse:[
	self error: self class InvalidPasswordErrorDescription].! !

!TusLibros methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 19:53:08'!
assertUserInDatabase: user.
	
	
	userDatabase at:user  ifAbsent:[
	self error: self class InvalidUserErrorDescription].! !


!TusLibros methodsFor: 'query' stamp: 'ap 11/22/2018 20:47:30'!
add: anAmount of: anItem toCart: aCartID

	|cart|
	cart:=carts at: aCartID ifAbsent:[
	self error: self class InvalidCartID].

	cart add: anAmount of: anItem.! !

!TusLibros methodsFor: 'query' stamp: 'ap 11/22/2018 21:02:18'!
listCart: aCartID 

	|cart list|
	
	cart:=carts at: aCartID .
	list:=Bag new.
	cart do: [:anItem| list add: anItem].
	
	^list.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibros class' category: #TusLibros!
TusLibros class
	instanceVariableNames: ''!

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 20:36:54'!
InvalidCartID

	^'Invalid cart id'! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 19:47:21'!
InvalidPasswordErrorDescription

	^'Password invalida'! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 19:43:21'!
InvalidUserErrorDescription

	^'Usuario invalido'! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'ap 11/22/2018 21:36:23'!
with: aUserDatabase andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesBook: aSalesBook

	^self new initializeWith: aUserDatabase andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesBook: aSalesBook .! !
