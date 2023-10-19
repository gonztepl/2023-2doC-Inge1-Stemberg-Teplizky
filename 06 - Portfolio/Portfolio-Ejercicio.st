!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/11/2023 23:58:27'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	|portfolio| 
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 19:59:27'!
test02PortfolioWithOneAccountAndOneTransactionIncreasesBalance

	|portfolio account| 
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio addFinancialService: account.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:01:07'!
test03PortfolioWithAPortfolioWithOneAccountAndOneTransactionInsideIncreasesBalance

	|portfolio portfolioToAdd account| 
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 200 on: account.
	
	portfolioToAdd addFinancialService: account.
	portfolio addFinancialService: portfolioToAdd.
	
	self assert: 200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:01:16'!
test04PortfolioKnowsAnAccountWithARegisteredTransaction

	|portfolio account deposit| 
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialService: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:01:19'!
test05PortfolioDoesNotKnowAnAccountWithNoRegisteredTransactions

	|portfolio account deposit| 
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit for: 100.
	
	portfolio addFinancialService: account.
	
	self deny: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:02:00'!
test06PortfolioWithAPortfolioKnowsAnAccountWithARegisteredTransaction

	|portfolio portfolioToAdd account deposit| 
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolioToAdd addFinancialService: account.
	portfolio addFinancialService: portfolioToAdd.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:02:02'!
test07PortfolioWithAPortfolioDoesNotKnowAnAccountWithNoRegisteredTransactions

	|portfolio portfolioToAdd account deposit| 
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit for: 100.
	
	portfolioToAdd addFinancialService: account.
	portfolio addFinancialService: portfolioToAdd.
	
	self deny: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:01:28'!
test08PortfolioWithOneAccountKnowsItsTransactions

	|portfolio account deposit withdraw transactionsList| 
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 300 on: account.
	withdraw := Withdraw register: 150 on: account.
	transactionsList := OrderedCollection new.
	transactionsList add: deposit.
	transactionsList add: withdraw.
	
	portfolio addFinancialService: account.
		
	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions = transactionsList).
	
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 20:01:47'!
test09PortfolioWithAPortfolioAndTwoAccountsKnowsItsTransactions

	|portfolio portfolioToAdd account account2 deposit withdraw deposit2 withdraw2 transactionsList| 
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 300 on: account.
	withdraw := Withdraw register: 150 on: account.
	
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 250 on: account2.
	withdraw2 := Withdraw register: 100 on: account2.
	
	transactionsList := OrderedCollection new.
	transactionsList add: deposit.
	transactionsList add: withdraw.
	transactionsList add: deposit2.
	transactionsList add: withdraw2.
	
	portfolioToAdd addFinancialService: account.
	portfolioToAdd addFinancialService: account2.
	portfolio addFinancialService: portfolioToAdd.
		
	self assert: 4 equals: portfolio transactions size.
	self assert: (portfolio transactions = transactionsList).! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/19/2023 09:49:04'!
test10PortfolioCannotHaveDuplicateAccounts

	|portfolio account|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolio addFinancialService: account.
	
	self 
		should: [portfolio addFinancialService: account]
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio duplicateFinancialServiceError]! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/19/2023 09:49:09'!
test11PortfolioCannotHaveAnAccountDuplicateInAnInsidePortfolio

	|portfolio insidePortfolio account|
	
	portfolio := Portfolio new.
	insidePortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addFinancialService: insidePortfolio.
	portfolio addFinancialService: account.
	
	self 
		should: [insidePortfolio addFinancialService: account]
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio duplicateFinancialServiceError]! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/19/2023 09:49:17'!
test12PortfolioCannotHaveTwoPortfoliosWithADuplicateAccount

	|portfolio insidePortfolio insidePortfolio2 account account2 |
	
	portfolio := Portfolio new.
	insidePortfolio := Portfolio new.
	insidePortfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	insidePortfolio2 addFinancialService: account.
	insidePortfolio2 addFinancialService: account2.
	
	portfolio addFinancialService: insidePortfolio.
	portfolio addFinancialService: insidePortfolio2.
	
	self 
		should: [insidePortfolio addFinancialService: account]
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio duplicateFinancialServiceError]! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/18/2023 22:42:31'!
test13PortfolioCannotBeInsideItself

	|portfolio insidePortfolio account account2 |
	
	portfolio := Portfolio new.
	insidePortfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	insidePortfolio addFinancialService: account.
	portfolio addFinancialService: account2.
	portfolio addFinancialService: insidePortfolio.
	
	self 
		should: [insidePortfolio addFinancialService: portfolio]
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio addingMeAsPortfolioError]! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/19/2023 09:49:28'!
test14PortfolioCannotAddAPortfolioHavingOnePortfolioThatItHas

	|portfolio portfolio2 portfolio3 portfolio4 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	portfolio addFinancialService: portfolio4.
	portfolio2 addFinancialService: portfolio4.
	portfolio3 addFinancialService: portfolio4.
	
	self 
		should: [portfolio3 addFinancialService: portfolio]
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio duplicateFinancialServiceError]! !

!PortfolioTest methodsFor: 'testing' stamp: 'UNS 10/19/2023 09:49:32'!
test15PortfolioCannotAddAPortfolioThatIsAlreadyInTree

	|portfolio insidePortfolio insidePortfolio2 account |
	
	portfolio := Portfolio new.
	insidePortfolio := Portfolio new.
	insidePortfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	insidePortfolio2 addFinancialService: account.
	portfolio addFinancialService: insidePortfolio .
	portfolio addFinancialService: insidePortfolio2.
	
	self 
		should: [insidePortfolio addFinancialService: insidePortfolio2]
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio duplicateFinancialServiceError]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'UNS 10/9/2023 21:27:36'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	 account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 21:46:43'!
manipulateBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
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


!Withdraw methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 21:47:03'!
manipulateBalance: aBalance
	
	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialService category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialService methodsFor: 'balance' stamp: 'UNS 10/18/2023 19:30:06'!
balance
		
	self subclassResponsibility! !


!FinancialService methodsFor: 'transactions' stamp: 'UNS 10/18/2023 20:13:19'!
addTransactionsTo: aTransactionList

	self subclassResponsibility! !

!FinancialService methodsFor: 'transactions' stamp: 'UNS 10/18/2023 19:30:17'!
hasRegistered: aTransaction
		
	self subclassResponsibility! !

!FinancialService methodsFor: 'transactions' stamp: 'UNS 10/18/2023 19:30:22'!
transactions
		
	self subclassResponsibility! !


!FinancialService methodsFor: 'hierarchy' stamp: 'UNS 10/18/2023 21:47:11'!
father: aFatherPortfolio

	self subclassResponsibility 
	
	! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialService subclass: #Portfolio
	instanceVariableNames: 'elements fatherElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'UNS 10/18/2023 19:53:53'!
balance
	
	^elements sum: [:aFinancialService | aFinancialService balance]
			  ifEmpty: [0].
	
	! !



!Portfolio methodsFor: 'initialize' stamp: 'UNS 10/18/2023 21:50:03'!
initialize

	elements := OrderedCollection new.
	fatherElement := self.! !


!Portfolio methodsFor: 'transactions' stamp: 'UNS 10/18/2023 20:13:46'!
addTransactionsTo: aTransactionList
	
	elements do: 	 
			[ :aFinancialService | aFinancialService addTransactionsTo: 			 							 			aTransactionList ].
					
	! !

!Portfolio methodsFor: 'transactions' stamp: 'UNS 10/18/2023 19:55:33'!
hasRegistered: aTransaction 
	
	 ^elements anySatisfy: [ :aFinancialService | 
		aFinancialService hasRegistered: aTransaction].
	! !

!Portfolio methodsFor: 'transactions' stamp: 'UNS 10/18/2023 20:13:56'!
transactions
	
	|transactionsList|
		
	transactionsList := OrderedCollection new.
	
	self addTransactionsTo: transactionsList.
					
	^transactionsList
					
! !


!Portfolio methodsFor: 'portfolio' stamp: 'UNS 10/18/2023 21:31:07'!
addFinancialService: aFinancialService
	
	self checkDuplicateFinancialService: aFinancialService.
	elements add: aFinancialService.
	aFinancialService father: self.! !

!Portfolio methodsFor: 'portfolio' stamp: 'UNS 10/19/2023 09:54:13'!
checkDuplicateFinancialService: aFinancialService
	
	(self iAmTheRootPortfolio) ifTrue: [^self checkDuplicateInTree: 	aFinancialService].
	fatherElement checkDuplicateFinancialService: aFinancialService.
! !

!Portfolio methodsFor: 'portfolio' stamp: 'UNS 10/19/2023 10:00:16'!
checkDuplicateInTree: aFinancialService
	
	self checkIfIAmTheSameFinancialService: aFinancialService.
	
	self checkIfMyFinancialServicesIncludes: aFinancialService.
	
	 ^elements detect: 
			[ :aFinanService | aFinanService checkDuplicateInTree: 
				aFinancialService] ifNone: [^false].! !

!Portfolio methodsFor: 'portfolio' stamp: 'UNS 10/19/2023 09:59:31'!
checkIfIAmTheSameFinancialService: aFinancialService

	^ (self = aFinancialService) ifTrue: [self error: Portfolio addingMeAsPortfolioError]! !

!Portfolio methodsFor: 'portfolio' stamp: 'UNS 10/19/2023 10:00:15'!
checkIfMyFinancialServicesIncludes: aFinancialService

	^ (elements includes: aFinancialService) ifTrue: [self error: Portfolio duplicateFinancialServiceError]! !


!Portfolio methodsFor: 'hierarchy' stamp: 'UNS 10/18/2023 21:50:48'!
father: aFatherPortfolio

	fatherElement := aFatherPortfolio! !

!Portfolio methodsFor: 'hierarchy' stamp: 'UNS 10/19/2023 09:54:13'!
iAmTheRootPortfolio

	^ fatherElement = self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'UNS 10/18/2023 22:41:52'!
addingMeAsPortfolioError

	^'Cannot add the same portfolio inside a portfolio'! !

!Portfolio class methodsFor: 'error' stamp: 'UNS 10/19/2023 09:50:39'!
duplicateFinancialServiceError

	^'Cannot have duplicate accounts or portfolios'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialService subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions fatherElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'UNS 10/18/2023 21:50:07'!
initialize

	transactions := OrderedCollection new.
	fatherElement := self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'UNS 10/18/2023 20:11:00'!
addTransactionsTo: aTransactionList

	aTransactionList addAll: transactions! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'UNS 10/14/2023 17:23:07'!
transactions 

	^ transactions! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'UNS 10/9/2023 21:46:21'!
balance

	^transactions inject: 0
				into: [:currentBalance :aTransaction |
					 aTransaction manipulateBalance: currentBalance.]
				! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'hierarchy' stamp: 'UNS 10/18/2023 22:06:19'!
checkDuplicateInTree: aFinancialService
	
	^false! !

!ReceptiveAccount methodsFor: 'hierarchy' stamp: 'UNS 10/18/2023 21:50:43'!
father: aFatherPortfolio

	fatherElement := aFatherPortfolio! !
