!classDefinition: #CartTest category: 'TusLibros'!
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


!classDefinition: #CashierTest category: 'TusLibros'!
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


!classDefinition: #InputInterfaceTest category: 'TusLibros'!
TestCase subclass: #InputInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 15:04:28'!
aValidPassword

	^ 'Password1'! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 15:05:25'!
aValidUserID

	^ 1! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 15:19:52'!
anInvalidCartID

	^ -1! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 15:04:49'!
anInvalidPassword

	^ 'Password10'! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 15:03:37'!
anInvalidUserID

	^ 20! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'UNS 11/6/2023 20:30:32'!
createInputInterface


	|catalog userList|
	
	catalog := testObjectsFactory defaultCatalog.
	
	userList := testObjectsFactory userList.
	
	^InputInterface with: catalog and: userList.
	
	
	
	
	
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/8/2023 15:40:09'!
currentDateAndTime

	^ DateAndTime now! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'UNS 11/6/2023 20:20:55'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 19:17:46'!
test01CannotCreateCartWithAnInvalidUserID

	| inputInterface |
	
	inputInterface := self createInputInterface.
	
	self 
		should: [ inputInterface createCartWithUserId: self anInvalidUserID andPassword: self aValidPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: anError messageText = InputInterface authenticationFailedWhenCreatingCartError].	
	
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 19:18:11'!
test02CannotCreateCartWithAnInvalidPassword

	| inputInterface |
	
	inputInterface := self createInputInterface.
	
	self 
		should: [ inputInterface createCartWithUserId: self aValidUserID andPassword: self anInvalidPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: anError messageText = InputInterface authenticationFailedWhenCreatingCartError].	
	
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 19:18:43'!
test03CartIsCreatedSuccesfullyWhenUsingValidClient

	| inputInterface cartID | 
	
	inputInterface := self createInputInterface.
	
	self
		shouldnt: [ cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword]
		raise: Error - MessageNotUnderstood.
		
	self assert:  ((inputInterface cartAt: cartID) isEmpty).
	self assert:  ((inputInterface userAt: cartID) = self aValidUserID)
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 19:19:29'!
test04CannotAddItemToInvalidCart

	| inputInterface | 
	
	inputInterface := self createInputInterface.
	
	 inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword.
		
	self 
		should: [ inputInterface add: 1 of: testObjectsFactory itemSellByTheStore toCart:  self anInvalidCartID ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = InputInterface invalidCartIDError.]
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 19:25:19'!
test05AnItemCanBeAddedToValidCart

	| inputInterface cartID | 
	
	inputInterface := self createInputInterface.
	
	 cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword.
		
	self 
		shouldnt: [ inputInterface add: testObjectsFactory itemSellByTheStore toCart:  cartID]
		raise: Error - MessageNotUnderstood.
		
		
		
			
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 19:25:52'!
test06CannotListItemsForInvalidCart

	| inputInterface | 
	
	inputInterface := self createInputInterface.	
	
	inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword.
	
	self should: [ inputInterface listCart: self anInvalidCartID]
	      raise: Error - MessageNotUnderstood 
	      withExceptionDo: [ :anError |
				self assert: anError messageText = InputInterface invalidCartIDError].	
	
	
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/7/2023 20:08:03'!
test07CanListItemsForSucessfullyCreatedCart

	| inputInterface cartID bookList | 
	
	inputInterface := self createInputInterface.
	
	 cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword.
	
	bookList := OrderedCollection new.
	bookList add: 	testObjectsFactory itemSellByTheStore.
	bookList add: 	testObjectsFactory itemSellByTheStore.
	bookList add: 	testObjectsFactory itemSellByTheStore2.
	inputInterface add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.	
	inputInterface add: testObjectsFactory itemSellByTheStore2 toCart: cartID.
	
	self assert: bookList equals: (inputInterface listCart: cartID).
	self assert: 3 equals: (inputInterface listCart: cartID) size.
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/8/2023 11:30:18'!
test08CannotCheckoutInvalidCart

	| inputInterface | 
	
	inputInterface := self createInputInterface.	
	
	
	
	self should: [ inputInterface checkoutCart: self anInvalidCartID  
		                                     with: testObjectsFactory 
		                                     notExpiredCreditCard for:  self aValidUserID  
		                                     expiring: testObjectsFactory  today]
	      raise: Error - MessageNotUnderstood 
	      withExceptionDo: [ :anError |
				self assert: anError messageText = InputInterface invalidCartIDError].	
	
	 
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/8/2023 11:36:24'!
test09CanCheckoutAValidCart

	| inputInterface cartID bookList totalBookList checkoutTotal | 
	
	inputInterface := self createInputInterface.	
		
	 cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword.
	
	bookList := OrderedCollection new.
	bookList add: 	testObjectsFactory itemSellByTheStore.
	bookList add: 	testObjectsFactory itemSellByTheStore.
	bookList add: 	testObjectsFactory itemSellByTheStore2.
	inputInterface add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartID.	
	inputInterface add: testObjectsFactory itemSellByTheStore2 toCart: cartID.
			
	totalBookList := testObjectsFactory itemSellByTheStorePrice * 2 + testObjectsFactory itemSellByTheStorePrice2.
	
	checkoutTotal := inputInterface checkoutCart: cartID
	                                                   with: testObjectsFactory notExpiredCreditCard
	                                                   for: self aValidUserID 
	                                                   expiring: testObjectsFactory today.
	
	self assert: totalBookList equals: checkoutTotal.! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/8/2023 15:44:43'!
test10CannotAddItemToExpiredCart

	| inputInterface cartID timeForCart timeForCartExpired| 
	
	inputInterface := self createInputInterface.
	
	timeForCart := self currentDateAndTime.
	
	cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword at: timeForCart copy.
	
	timeForCartExpired :=  timeForCart + (Duration minutes: 30).
		
	self 
		should: [ inputInterface add: 1 of: testObjectsFactory itemSellByTheStore2 toCart: cartID at: timeForCartExpired. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = InputInterface expiredCartIDError.]
			! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/8/2023 15:53:13'!
test11CannotListItemsForExpiredCart

	| inputInterface cartID timeForCart timeForCartExpired | 
	
	inputInterface := self createInputInterface.
	
	timeForCart := self currentDateAndTime.
	
	cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword at: timeForCart copy.
	
	timeForCartExpired :=  timeForCart + (Duration minutes: 30).
		
	self should: [ inputInterface listCart: cartID at: timeForCartExpired]
	      raise: Error - MessageNotUnderstood 
	      withExceptionDo: [ :anError |
				self assert: anError messageText = InputInterface expiredCartIDError].	
		! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'ght 11/8/2023 16:03:42'!
test12CannotCheckoutAnExpiredCart

	| inputInterface cartID timeForCart timeForCartExpired | 
	
	inputInterface := self createInputInterface.	
	
	timeForCart := self currentDateAndTime.
	
	cartID := inputInterface createCartWithUserId: self aValidUserID andPassword: self aValidPassword at: timeForCart copy.
	
	timeForCartExpired :=  timeForCart + (Duration minutes: 30).	
	
	self should: [ inputInterface checkoutCart: cartID 
		                                     with: testObjectsFactory 
		                                     notExpiredCreditCard for:  self aValidUserID  
		                                     expiring: testObjectsFactory  today
						     at: timeForCartExpired]
	      raise: Error - MessageNotUnderstood 
	      withExceptionDo: [ :anError |
				self assert: anError messageText = InputInterface expiredCartIDError ].	
	
	 
			! !


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


!Cart methodsFor: 'queries' stamp: 'ght 11/7/2023 20:05:10'!
items

	^items ! !

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

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
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

!classDefinition: 'Cashier class' category: 'TusLibros'!
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


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InputInterface category: 'TusLibros'!
Object subclass: #InputInterface
	instanceVariableNames: 'catalog users currentID userForCartID cartForCartID debitBehavior lastTimeUsedForCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InputInterface methodsFor: 'initialization' stamp: 'ght 11/8/2023 15:13:59'!
initializeWith: aCatalog and: anUserList

	catalog := aCatalog.
	users := anUserList.
	currentID := 0.
	userForCartID := Dictionary new.
	cartForCartID := Dictionary new.
	lastTimeUsedForCartID := Dictionary new.! !


!InputInterface methodsFor: 'queries' stamp: 'UNS 11/6/2023 21:26:47'!
cartAt: cartID

	^cartForCartID at: cartID! !

!InputInterface methodsFor: 'queries' stamp: 'ght 11/7/2023 20:06:14'!
itemsFor: aCart

	^aCart items copy.! !

!InputInterface methodsFor: 'queries' stamp: 'ght 11/8/2023 15:49:11'!
lastTimeUsedFor: cartID

	^ lastTimeUsedForCartID at: cartID! !

!InputInterface methodsFor: 'queries' stamp: 'ght 11/8/2023 15:55:03'!
listCart: cartID 
	
	^self listCart: cartID at: DateAndTime now.! !

!InputInterface methodsFor: 'queries' stamp: 'ght 11/8/2023 15:54:00'!
listCart: cartID at: currentTime
	
	self assertValidCartId: cartID.
	
	self assertNonExpiredCartFor: cartID at: currentTime.
	
	^self itemsFor: (cartForCartID at: cartID).! !

!InputInterface methodsFor: 'queries' stamp: 'UNS 11/6/2023 21:27:07'!
userAt: cartID

	^userForCartID at: cartID! !


!InputInterface methodsFor: 'adding' stamp: 'ght 11/8/2023 15:38:25'!
add: aQuantity of: aBook toCart: cartID 
	
	^self add: aQuantity of: aBook toCart: cartID at: DateAndTime now.

! !

!InputInterface methodsFor: 'adding' stamp: 'ght 11/8/2023 15:49:43'!
add: aQuantity of: aBook toCart: cartID at: currentTime

	| cart |
	
	self assertValidCartId: cartID.
	
	self assertNonExpiredCartFor: cartID at: currentTime.
	
	cart := cartForCartID at: cartID.
	
	cart add: aQuantity of: aBook .
! !

!InputInterface methodsFor: 'adding' stamp: 'ght 11/7/2023 17:52:14'!
add: aBook toCart: cartID

	self add: 1 of: aBook toCart: cartID.! !


!InputInterface methodsFor: 'assertions' stamp: 'ght 11/8/2023 15:49:11'!
assertNonExpiredCartFor: cartID at: currentTime
	
	^((Duration minutes: 30) <= (currentTime  - (self lastTimeUsedFor: cartID))) ifTrue: [^self error: self class expiredCartIDError].
	
	! !

!InputInterface methodsFor: 'assertions' stamp: 'ght 11/7/2023 18:15:18'!
assertValidCartId: cartID

	(cartForCartID includesKey: cartID) ifFalse: [ self error: self class invalidCartIDError.]! !

!InputInterface methodsFor: 'assertions' stamp: 'ght 11/7/2023 15:11:07'!
assertValidPassword: aPassword forUserId: anUserId

	((users at: anUserId)= aPassword) ifFalse: [^self error: self class authenticationFailedWhenCreatingCartError]! !

!InputInterface methodsFor: 'assertions' stamp: 'ght 11/7/2023 15:11:02'!
assertValidUserId: anUserId

	(users includesKey: anUserId) ifFalse: [^self error: self class authenticationFailedWhenCreatingCartError].! !


!InputInterface methodsFor: 'cart creation' stamp: 'UNS 11/6/2023 21:25:49'!
createCart

	^Cart acceptingItemsOf: catalog ! !

!InputInterface methodsFor: 'cart creation' stamp: 'ght 11/8/2023 15:38:37'!
createCartWithUserId: anUserId andPassword: aPassword
	
	^self createCartWithUserId: anUserId andPassword: aPassword at: DateAndTime now.
	! !

!InputInterface methodsFor: 'cart creation' stamp: 'ght 11/8/2023 15:09:09'!
createCartWithUserId: anUserId andPassword: aPassword at: currentTime
	
	|cart|
	
	self assertValidUserId: anUserId.
	self assertValidPassword: aPassword forUserId: anUserId.
	
	cart := self createCart.
	currentID := currentID + 1.
	cartForCartID at: currentID put: cart.
	userForCartID at: currentID put: anUserId.
	lastTimeUsedForCartID at: currentID put: currentTime.
	
	^currentID
	! !


!InputInterface methodsFor: 'checkout' stamp: 'ght 11/8/2023 16:00:33'!
checkoutCart: cartID with: creditCard for: clientID expiring: aMonthOfYear

	^self checkoutCart: cartID with: creditCard for: clientID expiring: aMonthOfYear at: DateAndTime now.! !

!InputInterface methodsFor: 'checkout' stamp: 'ght 11/8/2023 16:00:00'!
checkoutCart: cartID with: creditCard for: clientID expiring: aMonthOfYear at: currentTime

	| debitedAmount debitedCreditCard cashier listPurchases |
	
	listPurchases := OrderedCollection new.
	
	self assertValidCartId: cartID.
	
	self assertNonExpiredCartFor: cartID at: currentTime.
	
	cashier:= Cashier 
		toCheckout: (self cartAt: cartID)
		charging: creditCard
		throught: self
		on: aMonthOfYear
		registeringOn: listPurchases.
	
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmount := anAmount.
		debitedCreditCard := aCreditCard ].
	
	^cashier checkOut.
	
	
	
	
	! !

!InputInterface methodsFor: 'checkout' stamp: 'ght 11/8/2023 11:49:35'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard
	
	
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InputInterface class' category: 'TusLibros'!
InputInterface class
	instanceVariableNames: ''!

!InputInterface class methodsFor: 'instance creation' stamp: 'UNS 11/6/2023 20:27:50'!
with: aCatalog and: anUserList

	^self new initializeWith: aCatalog and: anUserList! !


!InputInterface class methodsFor: 'as yet unclassified' stamp: 'ght 11/7/2023 15:10:20'!
authenticationFailedWhenCreatingCartError

	^'Cannot create cart with user authentication failed'! !

!InputInterface class methodsFor: 'as yet unclassified' stamp: 'ght 11/8/2023 14:42:15'!
expiredCartIDError

	^'Cannot operate with an expired cart'! !

!InputInterface class methodsFor: 'as yet unclassified' stamp: 'ght 11/7/2023 18:14:58'!
invalidCartIDError

	^'Cannot operate with an invalid cart ID'! !


!classDefinition: #Sale category: 'TusLibros'!
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

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ght 11/7/2023 19:10:50'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ght 11/7/2023 19:38:17'!
itemSellByTheStorePrice2
	
	^20! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ght 11/7/2023 19:38:06'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self itemSellByTheStore2 put: self itemSellByTheStorePrice2;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'users' stamp: 'UNS 11/6/2023 20:42:22'!
userList
	
	^ Dictionary with: 1 -> 'Password1'! !
