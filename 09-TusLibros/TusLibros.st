!classDefinition: #MarketTest category: #TusLibros!
TestCase subclass: #MarketTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketTest methodsFor: 'support' stamp: 'GR 11/15/2018 18:21:12'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!MarketTest methodsFor: 'support' stamp: 'GR 11/15/2018 21:00:31'!
defaultCatalog
	
	| catalogue |
	catalogue := Dictionary new.
	catalogue at: self itemSellByTheStore put: 23.
	^catalogue! !

!MarketTest methodsFor: 'support' stamp: 'GR 11/15/2018 18:21:31'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!MarketTest methodsFor: 'support' stamp: 'GR 11/15/2018 18:21:34'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CartTest category: #TusLibros!
MarketTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: #TusLibros!
MarketTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:55:28'!
test01ShouldNotCheckoutEmptyCart
	
	| cart cashier creditCard merchantProcessor|

	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting: [] andWhenConsulting: [false].
		
	cashier := Cashier with: merchantProcessor.
	
	cart := self createCart .
	
	
		creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear julyOf: GregorianYear current).
		
	self should: [cashier checkOut: cart using: creditCard at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).]
	raise: Error
	withExceptionDo:[:anError| 
		self assert: anError messageText equals: 'Cannot checkout an empty cart'.
		self assert: cashier isSalesBookEmpty.
		self deny: (cashier wasMerchantProcessorAccessedUsing: creditCard).
		]! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:59:40'!
test02TicketShouldHaveCartItemPriceAfterCheckoutOfCartWIthSingleItem
	
	| cart cashier creditCard merchantProcessor ticket |

	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting: [] andWhenConsulting: [true].
		
	cashier := Cashier with: merchantProcessor.
	
	cart := self createCart .
	cart add: 'validBook'.
	
			creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear julyOf: GregorianYear current).
		
	ticket := cashier checkOut: cart using: creditCard at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).
	
	self assert: ticket equals: 23.
	self deny: cashier isSalesBookEmpty.
	self assert: (cashier wasMerchantProcessorAccessedUsing: creditCard).
		! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:56:04'!
test03TicketShouldSumCartItemsPricesAfterCheckoutOfCartWithMultipleItems
	
	| cart cashier creditCard merchantProcessor ticket |

	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting: [] andWhenConsulting: [true].
		
	cashier := Cashier with: merchantProcessor.
	
	cart := self createCart .
	cart add: 2 of: 'validBook' .
	
				creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear julyOf: GregorianYear current).
		
	ticket := cashier checkOut: cart using: creditCard at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).
		
	self assert: ticket equals: 46.
	self deny: cashier isSalesBookEmpty.
	self assert: (cashier wasMerchantProcessorAccessedUsing: creditCard).
		! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:55:49'!
test04ShouldNotCheckoutWhenCardIsExpired
	
	| cart cashier creditCard merchantProcessor |

	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting: [] andWhenConsulting: [false].
		
	cashier := Cashier with: merchantProcessor.
	
	creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear februaryOf: GregorianYear current).
	
	cart := self createCart .
	cart add: 'validBook'.
	self should:[
	cashier checkOut: cart using: creditCard at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: 'Cannot checkout with expired credit card'.
		self assert: cashier isSalesBookEmpty.
		self deny: (cashier wasMerchantProcessorAccessedUsing: creditCard)] .
		! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:51:53'!
test05ShouldNotCheckOutWhenCreditCardNotValidatedByMerchantProcessor
	
	| cart cashier priceList creditCard merchantProcessor|
	
	priceList := Dictionary new.
	priceList at: 'validBook' put: 23.
	
	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting: [merchantProcessor error: merchantProcessor class invalidCreditCardError.] andWhenConsulting: [true].
		
	cashier := Cashier with: merchantProcessor.

	creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear julyOf: GregorianYear current).
	
	cart := self createCart.
	cart add: 'validBook'.
	self should:[
	cashier checkOut: cart using: creditCard  at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: 'The credit card is not registered in the system'.
		self assert: cashier isSalesBookEmpty.
		self assert: (cashier wasMerchantProcessorAccessedUsing: creditCard).] .
		! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:52:16'!
test06ShouldNotCheckOutWhenAccountHasInsufficientFunds
	
	| cart cashier priceList creditCard merchantProcessor|
	
	priceList := Dictionary new.
	priceList at: 'validBook' put: 23.
	
	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting: [merchantProcessor error: merchantProcessor class insufficientFundsError] andWhenConsulting: [true].
		
	cashier := Cashier with: merchantProcessor.

	creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear julyOf: GregorianYear current).
	
	cart := self createCart.
	cart add: 'validBook'.
	self should:[
	cashier checkOut: cart using: creditCard  at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: 'The credit card does not have enough funds'.
		self assert: cashier isSalesBookEmpty.
		self assert: (cashier wasMerchantProcessorAccessedUsing: creditCard).] .
		! !

!CashierTest methodsFor: 'tests' stamp: 'GR 11/17/2018 13:53:02'!
test07ShouldNotCheckOutWhenTimeOut
	
	| cart cashier priceList creditCard merchantProcessor|
	
	priceList := Dictionary new.
	priceList at: 'validBook' put: 23.
	
	merchantProcessor := MerchantProcessorDummy withBehaviourWhenDebitting:  [merchantProcessor error: merchantProcessor class timeOutError] andWhenConsulting: [false].
		
	cashier := Cashier with: merchantProcessor.

	creditCard:= CreditCard with:1234 andExpirationDate: (GregorianMonthOfYear julyOf: GregorianYear current).
	
	cart := self createCart.
	cart add: 'validBook'.
	self should:[
	cashier checkOut: cart using: creditCard  at: (FixedGregorianDate yearNumber: 2018 monthNumber: 7 dayNumber: 22).
	] raise: Error
	withExceptionDo:[:anError|
		self assert: anError messageText equals: 'The transaction could not be completed because the connection timed out'.
		self assert: cashier isSalesBookEmpty.
		self deny: (cashier wasMerchantProcessorAccessedUsing: creditCard).] .
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


!Cart methodsFor: 'assertions' stamp: 'GR 11/15/2018 20:51:19'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'GR 11/16/2018 13:51:12'!
lookUpPriceOf: aString 

	^catalog at: aString ifAbsent:[self error: self invalidItemErrorMessage]! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'GR 11/16/2018 13:42:07'!
sumItemPrices


	|total|
	total := 0.
	items do: [:aBook| total :=  total + (self lookUpPriceOf: aBook) .total].
	^total! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


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
	instanceVariableNames: 'merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'GR 11/16/2018 15:07:29'!
initializeWIth:  aMerchantProcessor
	
	merchantProcessor:= aMerchantProcessor.
	salesBook := OrderedCollection new.
! !


!Cashier methodsFor: 'testing' stamp: 'GR 11/17/2018 13:26:01'!
isSalesBookEmpty

	^salesBook isEmpty.! !

!Cashier methodsFor: 'testing' stamp: 'GR 11/17/2018 13:46:45'!
wasMerchantProcessorAccessedUsing: aCreditCard
	^merchantProcessor wasAccessedBy: self using: aCreditCard.! !


!Cashier methodsFor: 'checking out' stamp: 'GR 11/16/2018 15:10:48'!
checkOut: aCart using: aCreditCard at: aDate
	
	
	| amount |
	self assert: aCreditCard HasNotExpiredBy: aDate.
	self assertCartIsNotEmpty: aCart.
		
	amount := aCart sumItemPrices.
	merchantProcessor debit:  amount fromAccountIdentifiedBy:aCreditCard .
	
	salesBook add: aCreditCard.
	
	^amount! !


!Cashier methodsFor: 'assertions' stamp: 'GR 11/16/2018 13:53:47'!
assert: aCreditCard HasNotExpiredBy: aDate

	(aCreditCard hasNotExpiredOn: aDate) ifFalse:[self error: self class expiredCreditCardError].! !

!Cashier methodsFor: 'assertions' stamp: 'GR 11/16/2018 13:56:01'!
assertCartIsNotEmpty: aCart
		
	(aCart isEmpty) ifTrue: [self error: self class emptyCartError].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'GR 11/16/2018 13:48:33'!
emptyCartError
	
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'GR 11/15/2018 19:29:32'!
expiredCreditCardError
	
	^'Cannot checkout with expired credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'GR 11/17/2018 13:56:36'!
with: aMerchantProcessor

	^self new initializeWIth: aMerchantProcessor! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'GR 11/16/2018 14:21:59'!
initializeWith: aNumber andExpirationDate: aMonthOfYear 
	
	
	number:= aNumber.
	expirationDate:= aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'GR 11/16/2018 13:39:56'!
hasNotExpiredOn: aFixedGregorianDate

	^(GregorianMonthOfYear year: (aFixedGregorianDate year) month: (aFixedGregorianDate month)) <= expirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'GR 11/16/2018 14:21:16'!
with: aNumber andExpirationDate: aMonthOfYear 

	^self new initializeWith: aNumber andExpirationDate:aMonthOfYear.! !


!classDefinition: #MerchantProcessorDummy category: #TusLibros!
Object subclass: #MerchantProcessorDummy
	instanceVariableNames: 'behaviourWhenDebitting behaviourWhenConsulting'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDummy methodsFor: 'debitting' stamp: 'GR 11/17/2018 13:38:52'!
debit: amount fromAccountIdentifiedBy: aCreditCard

	^behaviourWhenDebitting value! !


!MerchantProcessorDummy methodsFor: 'initialization' stamp: 'GR 11/17/2018 13:50:17'!
initializeWithBehaviourWhenDebitting: collaborationsToEval andWhenConsulting: otherCollaborationsToEval
	behaviourWhenDebitting := collaborationsToEval.
	behaviourWhenConsulting := otherCollaborationsToEval.! !


!MerchantProcessorDummy methodsFor: 'operations' stamp: 'GR 11/17/2018 13:44:12'!
wasAccessedBy: aCashier using: aCreditCard
	^behaviourWhenConsulting value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorDummy class' category: #TusLibros!
MerchantProcessorDummy class
	instanceVariableNames: ''!

!MerchantProcessorDummy class methodsFor: 'error messages' stamp: 'GR 11/17/2018 13:33:13'!
insufficientFundsError

	^'The credit card does not have enough funds'! !

!MerchantProcessorDummy class methodsFor: 'error messages' stamp: 'GR 11/17/2018 13:33:41'!
invalidCreditCardError

	^'The credit card is not registered in the system'! !

!MerchantProcessorDummy class methodsFor: 'error messages' stamp: 'GR 11/17/2018 13:34:37'!
timeOutError

	^'The transaction could not be completed because the connection timed out'! !


!MerchantProcessorDummy class methodsFor: 'instance creation' stamp: 'GR 11/17/2018 13:50:50'!
withBehaviourWhenDebitting: collaborationsToEval andWhenConsulting: otherCollaborationsToEval
	^self new initializeWithBehaviourWhenDebitting: collaborationsToEval andWhenConsulting: otherCollaborationsToEval! !
