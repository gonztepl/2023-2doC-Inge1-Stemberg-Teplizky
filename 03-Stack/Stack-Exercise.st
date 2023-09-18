!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:23:50'!
test01IfPrefixDoesNotExistReturnsEmpty
	
	|stack aSentenceFinderByPrefix sentences|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	sentences := aSentenceFinderByPrefix find: 'prefix'.
	
	self assert: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:24:38'!
test02IfPrefixDoesExistReturnsNotEmpty
	
	|stack aSentenceFinderByPrefix sentences|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	stack push: 'this is a sentence'.
	sentences := aSentenceFinderByPrefix find: 'this'.
	
	self deny: sentences isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:25:14'!
test03FindMethodRejectsEmptyPrefix
	
	|stack aSentenceFinderByPrefix|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	self 
		should: [ aSentenceFinderByPrefix find: ''] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixError 
		].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:25:56'!
test04FindMethodRejectsSentencePrefix

	|stack aSentenceFinderByPrefix|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	self
		should: [aSentenceFinderByPrefix find: 'A sentence cannot be a prefix' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceAsPrefixError
		].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:26:58'!
test05FindMethodFindsOneSentenceWithItsPrefix
	
	|stack aSentenceFinderByPrefix anExample sentences|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	anExample := 'this is a sentence'.
	stack push: anExample.
	sentences := aSentenceFinderByPrefix find: 'this'.
	
	self assert: sentences size = 1. 
	self assert: sentences first = anExample.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:31:41'!
test06FindMethodFindsMultipleSentencesWithTheirPrefix
	
	|stack aSentenceFinderByPrefix sentences|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	stack push: 'winter is coming.'.	
	stack push: 'winning is everything.'.
	stack push: 'The winds of Winter.'.
	stack push: 'winter is here.'.
	sentences := aSentenceFinderByPrefix find: 'win'.
	
	self assert: sentences size = 3.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 11:33:46'!
test07FindMethodIsCaseSensitive
	
	|stack aSentenceFinderByPrefix sentences|
	
	stack := OOStack new.
	aSentenceFinderByPrefix  := SentenceFinderByPrefix over: stack.
	
	stack push: 'Winter is coming'.
	stack push: 'winter Is Here'.
	stack push: 'Winter Is Here'.
	stack push: 'winning is everything'.
	sentences := aSentenceFinderByPrefix find: 'Wint'.
	
	self assert: sentences size = 2.
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:51:05'!
initialize

	elements := OOStackBase new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:05:01'!
isEmpty

	^elements isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 23:00:30'!
pop
	|previousTopValue|
	
	previousTopValue := self top.
	elements := elements previousElement.
	^previousTopValue.
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 22:58:53'!
push: anElement

	elements := elements push: anElement.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:05:12'!
size

	^elements size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 23:06:44'!
top

	^elements topValue. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackModel category: 'Stack-Exercise'!
Object subclass: #OOStackModel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackModel methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:21:10'!
isEmpty
	
	^self subclassResponsibility.! !

!OOStackModel methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:33:58'!
previousElement
	
	^self subclassResponsibility.! !

!OOStackModel methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:35:28'!
push: anElement
	
	^OOStackTopElement after: self with: anElement.! !

!OOStackModel methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:40:23'!
size
	
	^self subclassResponsibility.! !

!OOStackModel methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 23:58:15'!
topValue
	
	^self subclassResponsibility.! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackModel subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:42:54'!
isEmpty

	^true.! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:47:59'!
previousElement
	
	^self stackEmptyThrowError.! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:46:50'!
size
	
	^0.! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:47:48'!
stackEmptyThrowError
	
	^self error: OOStack stackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 23:58:15'!
topValue
	
	^self stackEmptyThrowError.! !


!classDefinition: #OOStackTopElement category: 'Stack-Exercise'!
OOStackModel subclass: #OOStackTopElement
	instanceVariableNames: 'previousElement topValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:55:05'!
initializeAfter: anElement with: aValue
	
	previousElement := anElement.
	topValue := aValue.! !

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:49:21'!
isEmpty

	^false.! !

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:49:44'!
previousElement

	^previousElement.! !

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:50:05'!
size

	^previousElement size + 1.! !

!OOStackTopElement methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:56:18'!
topValue

	^topValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackTopElement class' category: 'Stack-Exercise'!
OOStackTopElement class
	instanceVariableNames: ''!

!OOStackTopElement class methodsFor: 'as yet unclassified' stamp: 'GHT 9/17/2023 20:38:02'!
after: anElement with: aValue
	
	^OOStackTopElement  new initializeAfter: anElement with: aValue. ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ght 9/18/2023 10:41:59'!
checkIfPrefixIsNotASentence: aPrefix

	(aPrefix includesSubString: ' ') ifTrue: [self error: SentenceFinderByPrefix sentenceAsPrefixError].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:16:51'!
checkIfPrefixIsNotEmpty: aPrefix

	aPrefix ifEmpty: [self error: SentenceFinderByPrefix emptyPrefixError].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:27:48'!
checkIfPrefixIsValid: aPrefix

	self checkIfPrefixIsNotEmpty: aPrefix.
	self checkIfPrefixIsNotASentence: aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:23:48'!
copyStack 
	
	|newStack tempStack|
	
	newStack := OOStack new.
	tempStack  := OOStack new.
	
	self over: stack do: [:anElement | 
		newStack push: anElement. 
		tempStack push: anElement.
	].
	self over: tempStack do: [: anElement | stack push: anElement].
	
	^newStack.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:28:02'!
find: aPrefix 
	self checkIfPrefixIsValid: aPrefix.
	^(self sentences) select: [:aSentence | aSentence beginsWith: aPrefix].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:11:40'!
initializeOver: aStack

	stack := aStack! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:31:13'!
over: aStack do: aBlock 
	
	|anElement|
	
	(aStack size) timesRepeat: [
		anElement := aStack pop.
		aBlock value: anElement.
	].
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:31:00'!
overStackDo: aBlock
	
	self over: (self copyStack) do: aBlock.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:30:16'!
sentences
	
	|sentences|
	
	sentences := OrderedCollection new.
	self overStackDo: [:aSentence | sentences add: aSentence].
	^sentences.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:09:38'!
emptyPrefixError

	^'El prefijo no puede ser vacío.'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:07:38'!
over: aStack
	
	^self new initializeOver: aStack! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'GHT 9/18/2023 00:10:34'!
sentenceAsPrefixError

	^'El prefijo no puede ser una oración.'! !
