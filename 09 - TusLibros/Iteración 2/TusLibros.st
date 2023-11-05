!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
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

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
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

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'UNS 11/3/2023 19:39:52'!
defaultCatalog
		
	^Dictionary with: (self  itemSellByTheStore) -> 1000
			      with: (self itemSellByTheStore2) -> 200
			      with: (self itemSellByTheStore3) -> 300.
	! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!CartTest methodsFor: 'support' stamp: 'UNS 11/3/2023 19:40:03'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!CartTest methodsFor: 'support' stamp: 'UNS 11/3/2023 19:40:07'!
itemSellByTheStore3
	
	^ 'validBook3'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:38:32'!
test01CashierCannotCheckoutAnEmptyCart
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2022 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
	
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutEmptyCartError.
			self assert: clientPurchases isEmpty]
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:38:57'!
test02CashierCanCheckoutAOneItemCart
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
	
	cart add: self itemSellByTheStore.
	
	self assert: (1000 * peso) equals: (cashier checkout).
	self deny: clientPurchases isEmpty.
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:39:35'!
test03CashierCanCheckoutAMultipleEqualItemsCart
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
	
	cart add: self itemSellByTheStore withOcurrences: 7.
	
	self assert: (7000* peso) equals: (cashier checkout).
	self assert: 7 equals: clientPurchases size 
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:40:04'!
test04CashierCanCheckoutAMultipleDifferentItemsCart
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
	
	cart add: self itemSellByTheStore withOcurrences: 7.
	cart add: self itemSellByTheStore2.
	cart add: self itemSellByTheStore3 withOcurrences: 4.
	
	self assert: (8400* peso) equals: (cashier checkout).
	
	self assert: 12 equals: clientPurchases size   
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:40:23'!
test05CashierCannotCheckoutWithAExpiredCard
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.	
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2022 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
		
	cart add: self itemSellByTheStore withOcurrences: 7.
		
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutWithExpiredCardError.
			self assert: 0 equals: clientPurchases size 
		]
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:40:34'!
test06CashierCannotCheckoutAfterMerchantProcessorReportsRobbedCard
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.	
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: true.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
		
	cart add: self itemSellByTheStore withOcurrences: 7.
		
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator cannotCheckoutWithARobbedReportedCard.
			self assert: 0 equals: clientPurchases size 
		]
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:40:44'!
test07CashierCannotCheckoutAfterMerchantProcessorReportsCardWithNoCredit
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.	
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: false isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
		
	cart add: self itemSellByTheStore withOcurrences: 7.
		
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator cannotCheckoutWithANonCreditReportedCard.
			self assert: 0 equals: clientPurchases size 
		]
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:35:26'!
test08AnItemIsAddedToClientPurchasesAfterSuccessfulCheckout
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.	
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
		
	cart add: self itemSellByTheStore.
	
	self assert: (1000 * peso) equals: (cashier checkout).
	self assert: 1 equals: clientPurchases size.
	self assert: clientPurchases includes: self itemSellByTheStore.
	
	
			
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:43:01'!
test09ManyItemAreAddedToClientPurchasesAfterSuccessfulCheckout
	
	| clientPurchases cashier cart creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart := self createCart.	
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier := Cashier for: clientPurchases using: cart with: creditCard on: today talksWith: mpSimulator.
		
	cart add: self itemSellByTheStore.
	cart add: self itemSellByTheStore.
	cart add: self itemSellByTheStore2.
	
	self assert: (2200 * peso) equals: (cashier checkout).
	self assert: 3 equals: clientPurchases size.
	self assert: clientPurchases includes: self itemSellByTheStore.
	self assert: clientPurchases includes: self itemSellByTheStore2.
	
	
			
	
! !

!CashierTest methodsFor: 'tests' stamp: 'ght 11/4/2023 19:50:56'!
test10ManyItemAreAddedToClientPurchasesAfterTwoSuccessfulCheckouts
	
	| clientPurchases cashier1 cashier2 cart1 cart2 creditCard expiryMonthOfYear today mpSimulator |
	
	clientPurchases := self clientDefault.
	
	cart1 := self createCart.	
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	mpSimulator := MerchantProcessorSimulator hasCredit: true isRobbed: false.
	
	cashier1 := Cashier for: clientPurchases using: cart1 with: creditCard on: today talksWith: mpSimulator.
	
	cart2 := self createCart.	
	
	cashier2 := Cashier for: clientPurchases using: cart2 with: creditCard on: today talksWith: mpSimulator.
		
	cart1 add: self itemSellByTheStore.
	cart2 add: self itemSellByTheStore.
	cart2 add: self itemSellByTheStore2.
	
	self assert: (1000 * peso) equals: (cashier1 checkout).
	self assert: (1200 * peso) equals: (cashier2 checkout).
	
	self assert: 3 equals: clientPurchases size.
	self assert: clientPurchases includes: self itemSellByTheStore.
	self assert: clientPurchases includes: self itemSellByTheStore2.
	
	
			
	
! !


!CashierTest methodsFor: 'support' stamp: 'ght 11/4/2023 19:26:15'!
clientDefault
	
	^OrderedCollection new! !

!CashierTest methodsFor: 'support' stamp: 'us 11/2/2023 19:19:20'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'UNS 11/3/2023 20:50:53'!
currentMonthOfYear

	^GregorianMonthOfYear year: Date today yearNumber month: Date today monthIndex! !

!CashierTest methodsFor: 'support' stamp: 'UNS 11/3/2023 19:52:35'!
defaultCatalog
		
	^Dictionary with: (self  itemSellByTheStore) -> 1000
			      with: (self itemSellByTheStore2) -> 200
			      with: (self itemSellByTheStore3) -> 300.
	! !

!CashierTest methodsFor: 'support' stamp: 'us 11/2/2023 19:19:35'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'us 11/2/2023 20:06:07'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'us 11/2/2023 20:06:10'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!CashierTest methodsFor: 'support' stamp: 'us 11/2/2023 20:06:12'!
itemSellByTheStore3
	
	^ 'validBook3'! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'UNS 11/4/2023 14:48:34'!
test01CreditCardKnowsThatIsExpired

	|creditCard expiryMonthOfYear today|
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2022 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	self assert: (creditCard isExpiredAt: today)
	
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'UNS 11/4/2023 14:40:33'!
test02CreditCardKnowsThatIsNotExpired

	|creditCard expiryMonthOfYear today|
	
	expiryMonthOfYear := GregorianMonthOfYear year: 2026 month: 10.
	
	creditCard :=  CreditCard expiring: expiryMonthOfYear.
	
	today := self currentMonthOfYear.
	
	self deny: (creditCard isExpiredAt: today)
	
	! !


!CreditCardTest methodsFor: 'support' stamp: 'UNS 11/4/2023 14:32:38'!
currentMonthOfYear

	^GregorianMonthOfYear year: Date today yearNumber month: Date today monthIndex! !


!classDefinition: #Cart category: 'TusLibros'!
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


!Cart methodsFor: 'assertions' stamp: 'UNS 11/3/2023 19:51:44'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'UNS 11/3/2023 20:00:47'!
amountToDebit

	^items sum: [ :anItem | self priceOf: anItem]! !

!Cart methodsFor: 'queries' stamp: 'us 11/2/2023 19:26:04'!
items

	^items copy ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'UNS 11/3/2023 20:06:51'!
priceOf: anItem

	^(catalog at: anItem) * peso! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart client creditCard currentMonthOfYear merchantProccesorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'UNS 11/3/2023 20:12:26'!
amountDebitedFrom

	^cart amountToDebit! !

!Cashier methodsFor: 'checkout' stamp: 'UNS 11/3/2023 20:14:41'!
assertNonEmptyCart 
	
	cart isEmpty ifTrue: [^self error: self class cannotCheckoutEmptyCartError].	
	

! !

!Cashier methodsFor: 'checkout' stamp: 'UNS 11/3/2023 20:41:18'!
assertNonExpiredCreditCard

	(creditCard isExpiredAt: currentMonthOfYear)
		ifTrue: [self error: self class cannotCheckoutWithExpiredCardError].
! !

!Cashier methodsFor: 'checkout' stamp: 'ght 11/4/2023 19:24:08'!
assertValidCheckout

	self assertNonEmptyCart.
	self assertNonExpiredCreditCard! !

!Cashier methodsFor: 'checkout' stamp: 'ght 11/4/2023 19:24:09'!
checkout
	
	self assertValidCheckout.
	merchantProccesorSimulator debitFrom: creditCard totalOf: (self amountDebitedFrom).
	
	client addAll: 	cart items.
	
	^self amountDebitedFrom! !


!Cashier methodsFor: 'initialization' stamp: 'ght 11/4/2023 19:15:34'!
initializeFor: aClient using: aCart with: aCreditCard on: aMonthOfYear talksWith: anMPSimulator

	client := aClient.
	cart := aCart.
	creditCard := aCreditCard.
	currentMonthOfYear := aMonthOfYear.
	merchantProccesorSimulator := anMPSimulator ! !

!Cashier methodsFor: 'initialization' stamp: 'UNS 11/3/2023 20:30:19'!
initializeFor: aCart with: aCreditCard on: aMonthOfYear

	cart := aCart.
	creditCard := aCreditCard.
	currentMonthOfYear := aMonthOfYear! !

!Cashier methodsFor: 'initialization' stamp: 'UNS 11/4/2023 15:55:47'!
initializeFor: aCart with: aCreditCard on: aMonthOfYear talksWith: anMPSimulator

	cart := aCart.
	creditCard := aCreditCard.
	currentMonthOfYear := aMonthOfYear.
	merchantProccesorSimulator := anMPSimulator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'us 11/2/2023 19:21:22'!
cannotCheckoutEmptyCartError
	
	^'A cashier cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error' stamp: 'UNS 11/3/2023 20:40:50'!
cannotCheckoutWithExpiredCardError
	
	^'A cashier cannot checkout with an expired credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'ght 11/4/2023 19:20:36'!
for: aClient using: aCart with: aCreditCard on: aMonthOfYear talksWith: anMPSimulator

	^self new initializeFor: aClient using: aCart with: aCreditCard on: aMonthOfYear talksWith: anMPSimulator! !

!Cashier class methodsFor: 'instance creation' stamp: 'UNS 11/3/2023 20:30:31'!
for: aCart with: aCreditCard on: aMonthOfYear  

	^self new initializeFor: aCart with: aCreditCard on: aMonthOfYear! !

!Cashier class methodsFor: 'instance creation' stamp: 'UNS 11/4/2023 15:55:22'!
for: aCart with: aCreditCard on: aMonthOfYear talksWith: anMPSimulator

	^self new initializeFor: aCart with: aCreditCard on: aMonthOfYear talksWith: anMPSimulator! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'UNS 11/3/2023 20:18:18'!
initializeCardExpiring: anExpirationMonthOfYear
	
	expiration := anExpirationMonthOfYear! !


!CreditCard methodsFor: 'expiration' stamp: 'UNS 11/3/2023 20:42:04'!
isExpiredAt: aMonthOfYear

	^expiration < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'UNS 11/3/2023 20:16:14'!
expiring: anExpirationMonthOfYear

	^self new initializeCardExpiring: anExpirationMonthOfYear! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'credit robbed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'UNS 11/4/2023 15:52:21'!
initializeWithCredit: aBoolean andRobbedStatus: otherBoolean

	credit := aBoolean.
	robbed := otherBoolean ! !


!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'UNS 11/4/2023 16:14:10'!
debitFrom: aCreditCard totalOf: anAmount

	robbed ifTrue: [^self error: self class cannotCheckoutWithARobbedReportedCard].
	credit ifFalse: [^self error: self class cannotCheckoutWithANonCreditReportedCard]
	"realizar purchase"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'UNS 11/4/2023 15:51:26'!
hasCredit: aBoolean isRobbed: otherBoolean
	
	^self new initializeWithCredit: aBoolean andRobbedStatus: otherBoolean! !


!MerchantProcessorSimulator class methodsFor: 'error' stamp: 'UNS 11/4/2023 16:09:03'!
cannotCheckoutWithANonCreditReportedCard

	^'Cannot checkout with a card with no credit'! !

!MerchantProcessorSimulator class methodsFor: 'error' stamp: 'UNS 11/4/2023 15:54:21'!
cannotCheckoutWithARobbedReportedCard

	^'Cannot checkout with a robbed credit card'! !
