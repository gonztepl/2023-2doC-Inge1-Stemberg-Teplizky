!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'UNS 9/6/2023 18:55:47'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	^self testAction: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 50
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'UNS 9/6/2023 18:56:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  	
	^self testAction: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 	100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'UNS 9/6/2023 19:54:17'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'UNS 9/6/2023 19:17:20'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	^self checkIfCustomerBook: customerBook performingAction: [customerBook removeCustomerNamed: 'Paul McCartney'.] hasError: NotFound .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ght 9/6/2023 22:23:52'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addAndSuspendCustomerNamed: paulMcCartney.
	
	^self checkIf: customerBook hasACostumerWithSuspended: 1 andTotalCostumers: 1 withAction: [self assert: 	 	(customerBook includesCustomerNamed: paulMcCartney)]. 
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ght 9/6/2023 22:24:01'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addSuspendAndRemoveCustomerNamed: paulMcCartney.
	
	^self checkIf: customerBook hasACostumerWithSuspended: 0 andTotalCostumers: 0 withAction: [self deny: 	(customerBook includesCustomerNamed: paulMcCartney)].


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'UNS 9/6/2023 19:17:44'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	^self checkIfCustomerBook: customerBook performingAction: [customerBook suspendCustomerNamed: 'George Harrison'.] hasError: CantSuspend .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'UNS 9/6/2023 19:25:31'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addAndSuspendCustomerNamed: johnLennon .
	
	^self checkIfCustomerBook: customerBook performingAction: [customerBook suspendCustomerNamed: johnLennon.] hasError: CantSuspend .! !


!CustomerBookTest methodsFor: 'new methods' stamp: 'ght 9/6/2023 22:23:13'!
checkIf: aCustomerBook hasACostumerWithSuspended: suspendedCostumers andTotalCostumers: totalCustomers withAction: anAction

	self assert: 0 equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCostumers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aCustomerBook numberOfCustomers.
	anAction value.! !

!CustomerBookTest methodsFor: 'new methods' stamp: 'UNS 9/6/2023 19:16:35'!
checkIfCustomerBook: aCustomerBook performingAction: anAction hasError: errorType
	
	| johnLennon |
	johnLennon := 'John Lennon'.
	
	[ anAction value.
	self fail ]
		on: errorType
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'new methods' stamp: 'ght 9/6/2023 22:15:34'!
testAction: anAction takesLessThan: numberOfMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (numberOfMilliseconds * millisecond)! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'UNS 9/6/2023 19:24:53'!
addAndSuspendCustomerNamed: customerName

	self addCustomerNamed: customerName.
	self suspendCustomerNamed: customerName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'ght 9/7/2023 10:44:13'!
addSuspendAndRemoveCustomerNamed: customerName

	self addAndSuspendCustomerNamed:customerName. 
	self removeCustomerNamed:  customerName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'UNS 9/6/2023 20:36:18'!
removeCustomerNamed: aName 
 	
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^NotFound signal.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
