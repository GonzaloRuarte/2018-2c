!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value - private' stamp: 'GR 10/12/2018 00:44:26'!
weightInBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value - private' stamp: 'GR 10/12/2018 00:44:26'!
weightInBalance

	^ self value! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'value - private' stamp: 'GR 10/12/2018 00:44:26'!
weightInBalance

	^self value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'testing - private' stamp: 'GR 10/12/2018 01:48:41'!
accounts
	
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accountsCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ap 10/12/2018 00:21:12'!
balance

	^ accountsCollection sum: [:anAccount| anAccount balance].! !


!Portfolio methodsFor: 'testing' stamp: 'GR 10/12/2018 10:40:06'!
doesManage: anAccount

	^self accounts includes: anAccount

! !

!Portfolio methodsFor: 'testing' stamp: 'GR 10/12/2018 10:39:54'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction ! !


!Portfolio methodsFor: 'testing - private' stamp: 'GR 10/12/2018 10:48:59'!
accounts
	
	|anAccountCollection|
	
	anAccountCollection := OrderedCollection with: self.
	
	^self placeIn: anAccountCollection objects: #accounts.! !

!Portfolio methodsFor: 'testing - private' stamp: 'GR 10/12/2018 10:50:31'!
placeIn: aCollection objects: anObject


	
	accountsCollection do:[:anAccount| aCollection addAll: (anObject asMessage sendTo: anAccount) ].
	
	^aCollection! !


!Portfolio methodsFor: 'transactions' stamp: 'GR 10/12/2018 10:49:12'!
transactions 

	|transactionCollection|
	transactionCollection:=OrderedCollection  new.
	
	^self placeIn: transactionCollection objects: #transactions.! !

!Portfolio methodsFor: 'transactions' stamp: 'GR 10/12/2018 12:04:58'!
transactionsOf: anAccount 
	
	|account|
	account := self accounts detect: [:anotherAccount| anotherAccount = anAccount] ifNone: [^self error: self class accountNotManagedMessageDescription ].
	^account transactions! !


!Portfolio methodsFor: 'initialization' stamp: 'ap 10/12/2018 00:16:22'!
initializeWith: aCollectionOfAccounts
	
	accountsCollection := aCollectionOfAccounts.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'GR 10/12/2018 11:58:30'!
with: leftAccount with: rightAccount
	
	leftAccount accounts detect: [:anAccount| (rightAccount doesManage: anAccount)]
				 			ifNone:[
	rightAccount accounts detect: [:anAccount| (leftAccount doesManage: anAccount)]
							ifNone:[
							^self basicNew initializeWith: (OrderedCollection with: leftAccount with: rightAccount).
							]								
							] .
	^self error: self accountAlreadyManagedErrorMessage.
! !

!Portfolio class methodsFor: 'instance creation' stamp: 'ap 10/12/2018 00:15:44'!
withAll: aCollectionOfAccounts

	^self new initializeWith:  aCollectionOfAccounts! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'GR 10/12/2018 18:43:52'!
balance

	^ self transactions inject: 0 into: [:aSum :aTransaction| aSum +aTransaction weightInBalance].! !


!ReceptiveAccount methodsFor: 'testing - private' stamp: 'GR 10/12/2018 01:48:25'!
accounts
	
	^OrderedCollection with: self.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'GR 10/12/2018 09:58:51'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'GR 10/12/2018 10:28:14'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
