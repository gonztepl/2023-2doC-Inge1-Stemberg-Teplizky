!classDefinition: #AccountReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 21:54:03'!
test01AccountWithNoTransactions

	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account.
	
	self assert: 'Balance = 0' equals: accountSummary report! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 21:54:37'!
test02AccountWithADeposit

	|account accountSummary|
	
	account := ReceptiveAccount new.
	Deposit register: 200 on: account.
	accountSummary := AccountSummary for: account.
	
	self assert: 'Depósito por 200.\n', 'Balance = 200' equals: accountSummary report! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 21:55:01'!
test03AccountWithAWithdraw

	|account accountSummary|
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	accountSummary := AccountSummary for: account.
	
	self assert: 'Extracción por 50.\n', 'Balance = -50' equals: accountSummary report! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 21:57:33'!
test04AccountWithATransfer

	|accountSource accountDestination accountSummarySrc accountSummaryDst|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	
	Transfer from: accountSource to: accountDestination of: 200. 
	accountSummarySrc := AccountSummary for: accountSource.
	accountSummaryDst := AccountSummary for: accountDestination.
	
	self assert: 'Salida por transferencia de 200.\n', 'Balance = -200' equals: accountSummarySrc report.
	self assert: 'Entrada por transferencia de 200.\n', 'Balance = 200' equals: accountSummaryDst report.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 21:58:42'!
test05AccountWithManyTransactions

	|accountSource accountDestination accountSummarySrc accountSummaryDst|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	
	Deposit register: 150 on: accountSource.
	Withdraw register: 50 on: accountSource.
	Deposit register: 300 on: accountDestination.
	Withdraw register: 200 on: accountDestination.
	
	Transfer from: accountSource to: accountDestination of: 200. 
	Transfer from: accountDestination to: accountSource of: 200.
	
	accountSummarySrc := AccountSummary for: accountSource.
	accountSummaryDst:= AccountSummary for: accountDestination.
	
	self assert: 'Depósito por 150.\n','Extracción por 50.\n','Salida por transferencia de 200.\n','Entrada por transferencia de 200.\n','Balance = 100' equals: accountSummarySrc report.
	self assert: 'Depósito por 300.\n','Extracción por 200.\n','Entrada por transferencia de 200.\n','Salida por transferencia de 200.\n','Balance = 100' equals: accountSummaryDst report.! !


!classDefinition: #PortfolioReportTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #PortfolioReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #PortfolioTreeStructureTest category: 'Portfolio-Solucion'!
PortfolioReportTest subclass: #PortfolioTreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/25/2023 18:46:50'!
test01EmptyPortfolio

	|familyPortfolio portfolioTreeStructure|
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n' equals: portfolioTreeStructure report! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/25/2023 18:48:48'!
test02PortfolioWithAnAccount

	|familyPortfolio myAccount portfolioTreeStructure|
	
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n','\tCuenta Mia\n' equals: portfolioTreeStructure report! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/25/2023 23:57:41'!
test03PortfolioWithAnEmptyPortfolioInside

	|familyPortfolio childrenPortfolio portfolioTreeStructure|
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: childrenPortfolio.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n','\tPortfolio de hijos\n' equals: portfolioTreeStructure report! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/26/2023 02:26:16'!
test04PortfolioWithAnAccountAndAnEmptyPortfolioInside

	|familyPortfolio childrenPortfolio myAccount portfolioTreeStructure|
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n','\tCuenta Mia\n','\tPortfolio de hijos\n' equals: portfolioTreeStructure report! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/26/2023 02:31:56'!
test05PortfolioWithAPortfolioWithAccounts

	|familyPortfolio childrenPortfolio johnsAccount angiesAccount portfolioTreeStructure|
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount 
	with: angiesAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: childrenPortfolio.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n','\tPortfolio de hijos\n','\t\tCuenta de Juan\n','\t\tCuenta de Angeles\n' equals: portfolioTreeStructure report! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/26/2023 02:38:46'!
test06PortfolioWithAndAccountAndAPortfolioWithAccounts

	|familyPortfolio childrenPortfolio johnsAccount angiesAccount myAccount portfolioTreeStructure|
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount 
	with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n','\tCuenta Mia\n','\tPortfolio de hijos\n','\t\tCuenta de Juan\n','\t\tCuenta de Angeles\n' equals: portfolioTreeStructure report! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'UNS 10/26/2023 09:50:08'!
test07PortfolioWithMoreThanOnePortfolioInside

	|familyPortfolio childrenPortfolio cousinsPortfolio johnsAccount angiesAccount portfolioTreeStructure|
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	cousinsPortfolio := Portfolio named: 'Portfolio de primos' with: angiesAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: childrenPortfolio with: cousinsPortfolio.
	
	portfolioTreeStructure := PortfolioTreeStructure for: familyPortfolio.
	
	self assert: 'Portfolio de la familia\n','\tPortfolio de hijos\n','\t\tCuenta de Juan\n','\tPortfolio de primos\n','\t\tCuenta de Angeles\n' equals: portfolioTreeStructure report! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 22:01:26'!
test01AccountWithNoTransactions

	|account transferNet|
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.
	
	self assert: 0 equals: transferNet report! !

!TransferNetTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 22:02:23'!
test02AccountWithATransfer

	|accountSource accountDestination transferNetSrc transferNetDst|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	transferNetSrc := TransferNet for: accountSource.
	transferNetDst := TransferNet for: accountDestination.
	Transfer from: accountSource to: accountDestination of: 200.
	
	self assert: -200 equals: transferNetSrc report.
	self assert: 200 equals:  transferNetDst report	
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 22:02:55'!
test03AccountWithNoTransferButOtherTransactions

	|account transferNet|
	
	account := ReceptiveAccount new.
	Deposit register: 400 on: account.
	Withdraw register: 100 on: account.
	transferNet := TransferNet for: account.
	
	self assert: 0 equals: transferNet report
	
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'UNS 10/24/2023 22:03:31'!
test04AccountWithManyTransfers

	|accountSource accountDestination transferNetSrc transferNetDst|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount new.
	transferNetSrc := TransferNet for: accountSource.
	transferNetDst := TransferNet for: accountDestination.
	
	Transfer from: accountSource to: accountDestination of: 200.
	Transfer from: accountSource to: accountDestination of: 600.
	Transfer from: accountDestination to: accountSource of: 150.
	Transfer from: accountDestination to: accountSource of: 50.
		
	self assert: -600 equals: transferNetSrc report.
	self assert: 600 equals: transferNetDst report
	
	! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'UNS 10/22/2023 23:02:32'!
test01TransferBetweenTwoAccountsReflectsInBalance
	
	|accountSource accountDestination|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount  new.
	
	Transfer from: accountSource to: accountDestination  of: 200.
	
	self assert: -200 equals: accountSource balance.
	self assert: 200 equals: accountDestination balance.! !

!TransferTest methodsFor: 'tests' stamp: 'ght 10/22/2023 20:21:53'!
test02TransferBetweenTwoAccountsRegisterItsTransactions
	
	|accountSource accountDestination transfer|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount  new.
	
	transfer := Transfer from: accountSource to: accountDestination  of: 200.
	
	self assert: (accountSource hasRegistered: transfer withdrawLeg).
	self assert: (accountDestination hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'ght 10/22/2023 20:21:41'!
test03AccountsKnowsItsTransfers
	
	"sabemos que esto es radioactivo, solo lo agregamos para chequear que no se haya roto la funcionalidad anterior que presentaba portfolio1"
	
	|accountSource accountDestination transfer|
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount  new.
	
	transfer := Transfer from: accountSource to: accountDestination  of: 200.
	
	self assert: 1 equals: accountSource transactions size .
	self assert: (accountSource transactions includes: transfer withdrawLeg).
	
	self assert: 1 equals: accountDestination transactions size .
	self assert: (accountDestination transactions includes: transfer depositLeg)! !

!TransferTest methodsFor: 'tests' stamp: 'ght 10/22/2023 20:39:17'!
test04EachLegCanNavigateToEachOther
		
	|accountSource accountDestination transfer depositLeg withdrawLeg| 
	
	accountSource := ReceptiveAccount new.
	accountDestination := ReceptiveAccount  new.
	
	transfer := Transfer from: accountSource to: accountDestination  of: 200.
	depositLeg := transfer depositLeg.
	withdrawLeg := transfer withdrawLeg.
	
	self assert: (depositLeg navigateToTheOtherLeg) equals: withdrawLeg.
	self assert: (withdrawLeg navigateToTheOtherLeg) equals: depositLeg.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'UNS 10/25/2023 17:57:12'!
initialize
	
	name := ''! !

!Account methodsFor: 'initialization' stamp: 'UNS 10/25/2023 17:54:50'!
initializeNamed: aName
	
	self initialize.
	name := aName! !


!Account methodsFor: 'name' stamp: 'UNS 10/25/2023 18:46:03'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'UNS 10/25/2023 17:50:00'!
named: aName 
	^self new initializeNamed: aName ! !

!Account class methodsFor: 'instance creation' stamp: 'UNS 10/25/2023 18:16:50'!
named: aName with: anAccount

	^(self new initializeNamed: aName)
	   add: anAccount! !

!Account class methodsFor: 'instance creation' stamp: 'UNS 10/26/2023 02:03:58'!
named: aName with: anAccount with: anotherAccount

	^(self new initializeNamed: aName)
	   add: anAccount;
	   add: anotherAccount;
	   yourself! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'UNS 10/25/2023 17:59:55'!
initialize
	
	super initialize.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'UNS 10/26/2023 09:44:14'!
report: aReport
	
	accounts do: [:anAccount | anAccount sendAccountToReport: aReport]
! !

!Portfolio methodsFor: 'report' stamp: 'UNS 10/26/2023 09:44:33'!
sendAccountToReport: aReport
	
	aReport reportPortfolio: self
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'UNS 10/24/2023 23:03:51'!
report: aReport
	
	transactions do: [ :aTransaction | 
				     aTransaction report: aReport]
	! !

!ReceptiveAccount methodsFor: 'report' stamp: 'UNS 10/26/2023 02:10:17'!
sendAccountToReport: aReport
	
	aReport reportAccount: self! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'UNS 10/24/2023 23:13:29'!
initializeWith: anAccount

	self subclassResponsibility! !


!AccountReport methodsFor: 'report' stamp: 'UNS 10/24/2023 23:13:32'!
report

	self subclassResponsibility! !

!AccountReport methodsFor: 'report' stamp: 'UNS 10/24/2023 23:13:36'!
reportForDeposit: aDeposit

	self subclassResponsibility! !

!AccountReport methodsFor: 'report' stamp: 'UNS 10/24/2023 23:13:40'!
reportForDepositLeg: aDepositLeg

	self subclassResponsibility! !

!AccountReport methodsFor: 'report' stamp: 'UNS 10/24/2023 23:13:42'!
reportForWithdraw: aWithdraw

	self subclassResponsibility! !

!AccountReport methodsFor: 'report' stamp: 'UNS 10/24/2023 23:13:46'!
reportForWithdrawLeg: aWithdrawLeg

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'UNS 10/24/2023 20:45:48'!
initializeWith: anAccount

	account := anAccount.
	summary := ''! !


!AccountSummary methodsFor: 'report' stamp: 'UNS 10/24/2023 23:04:07'!
report
	
	account report: self.
	^summary := summary,'Balance = ', account balance asString.! !

!AccountSummary methodsFor: 'report' stamp: 'UNS 10/24/2023 22:58:08'!
reportForDeposit: aDeposit
	
	summary := summary,'Depósito por ', aDeposit value asString,'.\n'.! !

!AccountSummary methodsFor: 'report' stamp: 'UNS 10/24/2023 23:06:31'!
reportForDepositLeg: aDepositLeg
	
	summary := summary,'Entrada por transferencia de ', aDepositLeg transfer value asString,'.\n'.! !

!AccountSummary methodsFor: 'report' stamp: 'UNS 10/24/2023 22:58:11'!
reportForWithdraw: aWithdraw
	
	summary := summary,'Extracción por ', aWithdraw value asString,'.\n'! !

!AccountSummary methodsFor: 'report' stamp: 'UNS 10/24/2023 22:59:33'!
reportForWithdrawLeg: aWithdrawLeg
	
	summary := summary,'Salida por transferencia de ', aWithdrawLeg transfer value asString,'.\n'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'initialization' stamp: 'UNS 10/24/2023 20:33:11'!
for: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #PortfolioReport category: 'Portfolio-Solucion'!
AccountReport subclass: #PortfolioReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReport methodsFor: 'report' stamp: 'UNS 10/26/2023 00:15:26'!
reportAccount: anAccount
	
	self subclassResponsibility ! !

!PortfolioReport methodsFor: 'report' stamp: 'UNS 10/26/2023 00:15:44'!
reportPortfolio: aPortfolio

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio-Solucion'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'instance creation' stamp: 'UNS 10/25/2023 18:08:50'!
for: aPortfolio

	self subclassResponsibility! !


!classDefinition: #PortfolioTreeStructure category: 'Portfolio-Solucion'!
PortfolioReport subclass: #PortfolioTreeStructure
	instanceVariableNames: 'portfolio treeString indent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeStructure methodsFor: 'initialization' stamp: 'UNS 10/26/2023 01:31:51'!
initializeFor: aPortfolio with: anIndent 

	portfolio := aPortfolio.
	treeString := ''.
	indent := anIndent! !


!PortfolioTreeStructure methodsFor: 'report' stamp: 'UNS 10/26/2023 02:21:10'!
addAccountName: anAccount

	treeString := treeString,(self indentAString: anAccount),'\n'! !

!PortfolioTreeStructure methodsFor: 'report' stamp: 'UNS 10/26/2023 09:45:50'!
report
	self addAccountName: portfolio.
	indent := indent + 1.
	portfolio report: self.
	^treeString ! !

!PortfolioTreeStructure methodsFor: 'report' stamp: 'UNS 10/26/2023 02:17:09'!
reportAccount: anAccount
	
	self addAccountName: anAccount! !

!PortfolioTreeStructure methodsFor: 'report' stamp: 'UNS 10/26/2023 09:46:15'!
reportPortfolio: aPortfolio

	treeString := treeString,(PortfolioTreeStructure for: aPortfolio with: indent) report! !


!PortfolioTreeStructure methodsFor: 'indentation' stamp: 'UNS 10/26/2023 01:55:40'!
indentAString: anAccount
	
	|tabs|
	tabs := ''.
	
	indent timesRepeat: [tabs := tabs,'\t'].
	^tabs,anAccount name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeStructure class' category: 'Portfolio-Solucion'!
PortfolioTreeStructure class
	instanceVariableNames: ''!

!PortfolioTreeStructure class methodsFor: 'instance creation' stamp: 'UNS 10/26/2023 01:30:45'!
for: aPortfolio 
	 
	^self new initializeFor: aPortfolio with: 0! !

!PortfolioTreeStructure class methodsFor: 'instance creation' stamp: 'UNS 10/26/2023 02:20:21'!
for: aPortfolio with: anIndent
	 
	^self new initializeFor: aPortfolio with: anIndent! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'UNS 10/24/2023 22:49:26'!
initializeWith: anAccount

	account := anAccount.
	netValue := 0! !


!TransferNet methodsFor: 'report' stamp: 'UNS 10/24/2023 23:04:13'!
report

	account report: self.
	^netValue! !

!TransferNet methodsFor: 'report' stamp: 'UNS 10/24/2023 23:07:36'!
reportForDeposit: aDeposit

	! !

!TransferNet methodsFor: 'report' stamp: 'UNS 10/24/2023 23:07:57'!
reportForDepositLeg: aDepositLeg

	netValue := netValue + aDepositLeg transfer value! !

!TransferNet methodsFor: 'report' stamp: 'UNS 10/24/2023 23:08:07'!
reportForWithdraw: aWithdraw! !

!TransferNet methodsFor: 'report' stamp: 'UNS 10/24/2023 23:08:14'!
reportForWithdrawLeg: aWithdrawLeg
	
	netValue := netValue - aWithdrawLeg transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'initialization' stamp: 'UNS 10/24/2023 21:52:33'!
for: anAccount
		
	^self new initializeWith: anAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'UNS 10/23/2023 21:55:30'!
affectTransferNetValue: currentTransferValue

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'report' stamp: 'UNS 10/23/2023 21:45:06'!
lineForSummary

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'UNS 10/23/2023 21:33:56'!
of: aTransfer

	^self new initializeWith: aTransfer! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'UNS 10/24/2023 21:35:45'!
report: aReport

	aReport reportForDeposit: self.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'UNS 10/24/2023 21:25:36'!
report: aReport

	aReport reportForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'depositLeg withdrawLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'ght 10/22/2023 20:31:47'!
createTransferMembers

	depositLeg := DepositLeg of: self.
	withdrawLeg := WithdrawLeg of: self! !

!Transfer methodsFor: 'initialization' stamp: 'ght 10/22/2023 20:33:16'!
initializeFrom: accountSource to: accountDestination of: transferValue
	
	value := transferValue.
	self createTransferMembers.	
	self registerTransferMembersFor: accountSource and: accountDestination.! !

!Transfer methodsFor: 'initialization' stamp: 'ght 10/22/2023 20:33:07'!
registerTransferMembersFor: accountSource and: accountDestination

	accountSource register: withdrawLeg.
	accountDestination register: depositLeg! !


!Transfer methodsFor: 'members' stamp: 'ght 10/22/2023 20:06:20'!
depositLeg
	
	^depositLeg
	! !

!Transfer methodsFor: 'members' stamp: 'UNS 10/22/2023 23:26:04'!
value

	^value! !

!Transfer methodsFor: 'members' stamp: 'ght 10/22/2023 20:06:36'!
withdrawLeg
	
	^withdrawLeg
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'ght 10/22/2023 16:09:13'!
from: accountSource to: accountDestination of: transferValue 
	
	^self new initializeFrom: accountSource to: accountDestination of: transferValue.
	! !


!classDefinition: #TransferMember category: 'Portfolio-Solucion'!
Object subclass: #TransferMember
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferMember methodsFor: 'navigation' stamp: 'ght 10/22/2023 20:21:18'!
navigateToTheOtherLeg

	self subclassResponsibility! !


!TransferMember methodsFor: 'initialize' stamp: 'ght 10/22/2023 20:35:21'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferMember methodsFor: 'balance' stamp: 'UNS 10/22/2023 23:22:15'!
affectBalance

	self subclassResponsibility! !


!TransferMember methodsFor: 'report' stamp: 'UNS 10/24/2023 21:23:41'!
report: aReport

	self subclassResponsibility ! !


!TransferMember methodsFor: 'transfer' stamp: 'UNS 10/24/2023 22:39:16'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferMember class' category: 'Portfolio-Solucion'!
TransferMember class
	instanceVariableNames: ''!

!TransferMember class methodsFor: 'initialization' stamp: 'ght 10/22/2023 20:34:51'!
of: aTransfer

	^self new initializeWith: aTransfer! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferMember subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'navigation' stamp: 'ght 10/22/2023 20:19:17'!
navigateToTheOtherLeg

	^transfer withdrawLeg! !


!DepositLeg methodsFor: 'balance' stamp: 'UNS 10/22/2023 23:24:35'!
affectBalance: aBalanceToManipulate

	^aBalanceToManipulate + transfer value.! !


!DepositLeg methodsFor: 'initialization' stamp: 'UNS 10/23/2023 21:36:38'!
initializeWith: aTransfer

	transfer := aTransfer! !


!DepositLeg methodsFor: 'report' stamp: 'UNS 10/24/2023 21:24:45'!
report: aReport

	aReport reportForDepositLeg: self.! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferMember subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'navigation' stamp: 'ght 10/22/2023 20:19:01'!
navigateToTheOtherLeg

	^transfer depositLeg! !


!WithdrawLeg methodsFor: 'balance' stamp: 'UNS 10/22/2023 23:25:38'!
affectBalance: aBalanceToManipulate

	^aBalanceToManipulate - transfer value! !


!WithdrawLeg methodsFor: 'initialization' stamp: 'UNS 10/23/2023 21:36:59'!
initializeWith: aTransfer

	transfer := aTransfer! !


!WithdrawLeg methodsFor: 'report' stamp: 'UNS 10/24/2023 21:25:02'!
report: aReport

	aReport reportForWithdrawLeg: self.! !
