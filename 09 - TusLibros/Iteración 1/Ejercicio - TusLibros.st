!classDefinition: #CartTest category: 'Ejercicio - TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:33:08'!
catalogueBooks

	|catalogueBooks|
	catalogueBooks := OrderedCollection new.
	
	catalogueBooks add: 'Libro1'.
	catalogueBooks add: 'Libro2'.
	catalogueBooks add: 'Libro3'.
	catalogueBooks add: 'Libro10'.
	
	^catalogueBooks! !

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:33:58'!
test01CartAtStartIsEmpty

	|cart catalogueBooks|
	
	catalogueBooks := self catalogueBooks.
	cart := Cart withCatalogue: catalogueBooks.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:49:28'!
test02CartHasABookThatHasAdded

	|cart catalogueBooks book bookList|
	
	catalogueBooks := self catalogueBooks.
	cart := Cart withCatalogue: catalogueBooks.
	bookList := OrderedCollection new.
	book := 'Libro1'.
	
	bookList add: book.
	cart addToCart: 1 copiesOf: book. 
	
	self deny: cart isEmpty.
	self assert: bookList equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:49:48'!
test03CartCanHaveMoreThanABook

	|cart catalogueBooks book book2 book3 bookList|
	
	catalogueBooks := self catalogueBooks.
	cart := Cart withCatalogue: catalogueBooks.
	bookList := OrderedCollection new.
	book := 'Libro1'.
	book2 := 'Libro2'.
	book3 := 'Libro3'.
	
	cart addToCart: 1 copiesOf: book.
	cart addToCart: 1 copiesOf: book2.
	cart addToCart: 1 copiesOf: book3.
	
	bookList add: book.
	bookList add: book2.
	bookList add: book3. 
	
	self deny: cart isEmpty.
	self assert: bookList equals: cart listCart ! !

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:56:22'!
test04CartCanHaveARepeatedBook

	|cart catalogueBooks book book2 book3 bookList|
	
	catalogueBooks := self catalogueBooks.
	cart := Cart withCatalogue: catalogueBooks.
	bookList := OrderedCollection new.
	book := 'Libro1'.
	book2 := 'Libro2'.
	book3 := 'Libro3'.
	
	cart addToCart: 2 copiesOf: book.
	cart addToCart: 1 copiesOf: book2.
	cart addToCart: 1 copiesOf: book3.
	
	bookList add: book.
	bookList add: book.
	bookList add: book2.
	bookList add: book3.
	
	self deny: cart isEmpty.
	self assert: bookList equals: cart listCart! !

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:58:25'!
test05CartCannotAddABookOutOfTheCatalogue

	|cart catalogueBooks book book2 book3 book7 bookList|
	
	catalogueBooks := self catalogueBooks.
	cart := Cart withCatalogue: catalogueBooks.
	bookList := OrderedCollection new.
	
	book := 'Libro1'.
	book2 := 'Libro2'.
	book3 := 'Libro3'.
	book7 := 'Libro7'.
		
	cart addToCart: 1 copiesOf: book.
	cart addToCart: 1 copiesOf: book2.
	cart addToCart: 1 copiesOf: book3.
	
	bookList add: book.
	bookList add: book2.
	bookList add: book3. 
	
	self
		should: [ cart addToCart: 1 copiesOf: book7 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart cannotAddBookOutOfHisCatalogue equals: anError messageText.
			self deny: (cart includes: book7).
			self assert: bookList equals: cart listCart
		]! !

!CartTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 21:48:49'!
test06CartMustAddPositiveNumberOfCopiesOfABook

	|cart catalogueBooks book bookList|
	
	catalogueBooks := self catalogueBooks.
	cart := Cart withCatalogue: catalogueBooks.
	bookList := OrderedCollection new.
	book := 'Libro1'.
	
	self
		should: [ cart addToCart: 0 copiesOf: book ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart cannotAddNotPositiveCopiesOfABook equals: anError messageText.
			self assert: cart isEmpty.
			self assert: bookList equals: cart listCart
		]! !


!classDefinition: #Cart category: 'Ejercicio - TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalogue books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TusLibros'!

!Cart methodsFor: 'status' stamp: 'UNS 10/30/2023 19:53:31'!
hasBook: aBook
	
	^books includes: aBook! !

!Cart methodsFor: 'status' stamp: 'UNS 10/30/2023 19:47:20'!
isEmpty
	
	^books isEmpty! !


!Cart methodsFor: 'adding' stamp: 'UNS 10/30/2023 21:55:22'!
addCopies: numberOfCopies of: aBook 
	
	numberOfCopies timesRepeat: [books add: aBook]! !

!Cart methodsFor: 'adding' stamp: 'UNS 10/30/2023 21:55:44'!
addToCart: numberOfCopies copiesOf: aBook 
	
	self assertCanAddBook: aBook.
	self assertPositiveNumberOfCopies: numberOfCopies.
	
	self addCopies: numberOfCopies of: aBook! !


!Cart methodsFor: 'initialization' stamp: 'UNS 10/30/2023 20:48:20'!
catalogueForCart

	|catalogueBooks|
	catalogueBooks := OrderedCollection new.
	
	catalogueBooks add: 'Libro1'.
	catalogueBooks add: 'Libro2'.
	catalogueBooks add: 'Libro3'.
	catalogueBooks add: 'Libro10'.
	catalogueBooks add: 'Libro45'.
	catalogueBooks add: 'Libro77'.! !

!Cart methodsFor: 'initialization' stamp: 'UNS 10/30/2023 21:36:55'!
initializeWith: aCatalogue

	books := OrderedCollection new.
	catalogue := aCatalogue! !


!Cart methodsFor: 'books' stamp: 'UNS 10/30/2023 20:02:39'!
listCart
	
	^books! !


!Cart methodsFor: 'assertions' stamp: 'UNS 10/30/2023 21:38:27'!
assertCanAddBook: aBook 
	
	(catalogue includes: aBook) ifFalse: [self error: self class cannotAddBookOutOfHisCatalogue].
	! !

!Cart methodsFor: 'assertions' stamp: 'UNS 10/30/2023 21:46:44'!
assertPositiveNumberOfCopies: aNumberOfCopies

	(aNumberOfCopies <= 0) ifTrue: [self error: self class cannotAddNotPositiveCopiesOfABook]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 21:58:06'!
includes: aBook
	
	^books includes: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio - TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'UNS 10/30/2023 21:36:08'!
withCatalogue: aCatalogue
	
	^self new initializeWith: aCatalogue! !


!Cart class methodsFor: 'error' stamp: 'UNS 10/30/2023 21:11:45'!
cannotAddBookOutOfHisCatalogue

	^'Cannot add a book out of his catalogue'! !

!Cart class methodsFor: 'error' stamp: 'UNS 10/30/2023 21:44:58'!
cannotAddNotPositiveCopiesOfABook

	^'Cannot add not positive number of copies of a book'! !
