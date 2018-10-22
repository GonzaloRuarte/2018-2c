!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor - private' stamp: 'GR 10/19/2018 12:45:23'!
accept: aVisitor
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value rate days'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:29:07'!
affectBalance: currentBalance

	^currentBalance - self value! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:38:01'!
days

	^days! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:37:53'!
rateAsPercentage

	^ rate * 100.! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:21:46'!
value

	^ value! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:32:56'!
valueOfEarnings

	^ value*(rate /360)*days ! !


!CertificateOfDeposit methodsFor: 'initialization' stamp: 'APç 10/18/2018 21:20:04'!
initializeWith: anAmount at: aRate during: aNumberOfDays

	value:= anAmount.
	rate:=aRate .
	days:=aNumberOfDays .! !


!CertificateOfDeposit methodsFor: 'visitor - private' stamp: 'GR 10/19/2018 12:46:19'!
accept: aVisitor
	
	^aVisitor visitCertificateOfDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'APç 10/18/2018 21:21:14'!
register: anAmount during: aNumberOfDays at: anInteresRate on: anAccount

	|certificateOfDeposit|
	certificateOfDeposit:=self new initializeWith: anAmount at: anInteresRate during: aNumberOfDays.
	anAccount register: certificateOfDeposit.
	^certificateOfDeposit.

! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'visitor - private' stamp: 'GR 10/19/2018 12:46:30'!
accept: aVisitor
	
	^aVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'APç 10/18/2018 19:56:50'!
initializeWith:anAmount belongingTo: aTransfer

	value:=anAmount.
	transfer:=aTransfer. ! !


!TransferLeg methodsFor: 'value' stamp: 'APç 10/18/2018 19:51:32'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!TransferLeg methodsFor: 'value' stamp: 'APç 10/18/2018 19:34:09'!
transfer

	^transfer. ! !

!TransferLeg methodsFor: 'value' stamp: 'APç 10/18/2018 20:26:04'!
value

	^transfer value. ! !


!TransferLeg methodsFor: 'visitor - private' stamp: 'GR 10/19/2018 12:46:45'!
accept: aVisitor
	
	^aVisitor visitTransferLeg: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'APç 10/18/2018 19:55:25'!
register:anAmount on:fromAccount belongingTo: aTransfer


	| withdraw |
	
	withdraw := self new initializeWith:anAmount belongingTo: aTransfer.
	fromAccount register: withdraw.
		
	^ withdraw
! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 20:37:03'!
affectBalance: currentBalance

	^currentBalance + self value! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'APç 10/18/2018 20:37:09'!
affectBalance: currentBalance

	^currentBalance - self value! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'visitor - private' stamp: 'GR 10/19/2018 12:46:56'!
accept: aVisitor
	
	^aVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountTransactionVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransactionVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:39:15'!
visitCertificateOfDeposit: aCertificateOfDeposit
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:40:12'!
visitDeposit: aDeposit
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:40:23'!
visitTransferLeg: aTransferLeg
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:40:35'!
visitWithdraw: aWithdraw
	self subclassResponsibility ! !


!classDefinition: #AccountSummaryLinesVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #AccountSummaryLinesVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLinesVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:55:59'!
visitCertificateOfDeposit: aCertificateOfDeposit

	^'Plazo fijo por ', aCertificateOfDeposit value asString, ' durante ', aCertificateOfDeposit days asString, ' dias a una tna de ', aCertificateOfDeposit rateAsPercentage asString, '%'! !

!AccountSummaryLinesVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:56:52'!
visitDeposit: aDeposit

	^'Deposito por ', aDeposit value asString! !

!AccountSummaryLinesVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 13:03:27'!
visitTransferLeg: aTransferLeg

	^'Transferencia por ', (aTransferLeg affectBalance: 0) asString! !

!AccountSummaryLinesVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:58:57'!
visitWithdraw: aWithdraw

	^'Extraccion por ', aWithdraw value asString! !


!classDefinition: #AccountTransferNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #AccountTransferNetVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:41:34'!
visitCertificateOfDeposit: aCertificateOfDeposit
	^0! !

!AccountTransferNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:41:30'!
visitDeposit: aDeposit
	^0! !

!AccountTransferNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:38:21'!
visitTransferLeg: aTransferLeg

	^aTransferLeg affectBalance: 0! !

!AccountTransferNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:41:19'!
visitWithdraw: aWithdraw
	^0! !


!classDefinition: #InvestmentEarningsVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #InvestmentEarningsVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarningsVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:42:59'!
visitCertificateOfDeposit: aCertificateOfDeposit

	^aCertificateOfDeposit valueOfEarnings ! !

!InvestmentEarningsVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:42:19'!
visitDeposit: aDeposit
	^0! !

!InvestmentEarningsVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:42:23'!
visitTransferLeg: aTransferLeg
	^0! !

!InvestmentEarningsVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:42:27'!
visitWithdraw: aWithdraw
	^0! !


!classDefinition: #InvestmentNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #InvestmentNetVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:43:57'!
visitCertificateOfDeposit: aCertificateOfDeposit

	^aCertificateOfDeposit value! !

!InvestmentNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:43:11'!
visitDeposit: aDeposit
	^0! !

!InvestmentNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:43:22'!
visitTransferLeg: aTransferLeg
	^0! !

!InvestmentNetVisitor methodsFor: 'operations' stamp: 'GR 10/19/2018 12:43:35'!
visitWithdraw: aWithdraw
	^0! !


!classDefinition: #Consultant category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Consultant
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Consultant class' category: #'PortfolioTreePrinter-Ejercicio'!
Consultant class
	instanceVariableNames: ''!

!Consultant class methodsFor: 'operations' stamp: 'GR 10/19/2018 13:15:09'!
accountSummaryLinesOf: aReceptiveAccount

	|visitor|
	
	visitor:= AccountSummaryLinesVisitor new.

	^aReceptiveAccount transactions inject: OrderedCollection new into: [:summary :aTransaction| summary add: (aTransaction accept: visitor). summary
													
														]
	! !

!Consultant class methodsFor: 'operations' stamp: 'GR 10/19/2018 12:47:59'!
accountTransferNetOf: aReceptiveAccount 
	
	|visitor|
	
	visitor := AccountTransferNetVisitor new.
	
	^aReceptiveAccount transactions sum: [:aTransaction| aTransaction accept: visitor
														] ifEmpty: [0]
	! !

!Consultant class methodsFor: 'operations' stamp: 'GR 10/19/2018 12:49:10'!
investmentEarningsOf: aReceptiveAccount 	

	|visitor|
	
	visitor := InvestmentEarningsVisitor new.


	^aReceptiveAccount transactions sum: [:aTransaction| aTransaction accept: visitor] ifEmpty: [0]
	! !

!Consultant class methodsFor: 'operations' stamp: 'GR 10/19/2018 12:49:34'!
investmentNetOf: aReceptiveAccount 	

|visitor|
	
	visitor := InvestmentNetVisitor new.

	^aReceptiveAccount transactions sum: [:aTransaction| aTransaction accept: visitor] ifEmpty: [0]
	! !

!Consultant class methodsFor: 'operations' stamp: 'GR 10/22/2018 14:19:53'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary

	|visitor|
	
	visitor := TreePrinterVisitor new.

	^aPortfolio accept: visitor with: aDictionary spacing: ''! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'visitor - private' stamp: 'GR 10/22/2018 14:20:06'!
accept: aVisitor with: aDictionary spacing: aString

	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'visitor - private' stamp: 'GR 10/22/2018 14:20:48'!
accept: aVisitor with: aDictionary spacing: aString

	^aVisitor visitPortfolio: self with: aDictionary spacing: aString! !

!Portfolio methodsFor: 'visitor - private' stamp: 'GR 10/22/2018 13:56:31'!
accounts

	^accounts! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'visitor - private' stamp: 'GR 10/22/2018 14:20:28'!
accept: aVisitor with: aDictionary spacing: aString

	^aVisitor visitReceptiveAccount: self with: aDictionary spacing: aString! !


!classDefinition: #SummarizingAccountVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccountVisitor methodsFor: 'operations' stamp: 'GR 10/22/2018 14:18:12'!
visitPortfolio: aPortfolio with: aDictionary spacing: aString

	self subclassResponsibility ! !

!SummarizingAccountVisitor methodsFor: 'operations' stamp: 'GR 10/22/2018 14:18:08'!
visitReceptiveAccount: aReceptiveAccount with: aDictionary spacing: aString

	self subclassResponsibility ! !


!classDefinition: #TreePrinterVisitor category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountVisitor subclass: #TreePrinterVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TreePrinterVisitor methodsFor: 'operations' stamp: 'GR 10/22/2018 14:22:05'!
visitPortfolio: aPortfolio with: aDictionary spacing: aString

	^aPortfolio accounts inject: (OrderedCollection with: (aString, (aDictionary at: aPortfolio))) into: [:lines :anAccount | lines addAll: (anAccount accept: self with: aDictionary spacing: ' ', aString).lines]! !

!TreePrinterVisitor methodsFor: 'operations' stamp: 'GR 10/22/2018 14:21:49'!
visitReceptiveAccount: aReceptiveAccount with: aDictionary spacing: aString

	^OrderedCollection with: (aString, (aDictionary at: aReceptiveAccount))! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'APç 10/18/2018 19:39:57'!
depositLeg

	^depositLeg.! !

!Transfer methodsFor: 'value' stamp: 'APç 10/18/2018 18:54:51'!
value
	^value.! !

!Transfer methodsFor: 'value' stamp: 'APç 10/18/2018 19:40:01'!
withdrawLeg

	^withdrawLeg.! !


!Transfer methodsFor: 'initialization' stamp: 'APç 10/18/2018 20:43:32'!
initializeWith: anAmount from: fromAccount to: toAccount


	
	withdrawLeg:=TransferWithdraw register:anAmount on:fromAccount belongingTo: self.
	depositLeg:=TransferDeposit register: anAmount on: toAccount belongingTo: self.
	value:=anAmount.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'APç 10/18/2018 19:06:22'!
registerTransferOf: anAmount from: fromAccount to: toAccount

	^self new initializeWith: anAmount from:fromAccount to: toAccount.
	
	! !
