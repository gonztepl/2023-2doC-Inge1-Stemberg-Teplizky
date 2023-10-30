!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:10:43'!
emptyCollection

	^OrderedCollection new! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:14:08'!
headingObserverFor: aMarsRover
	
	|logger| 
	
	logger := MarsRoverLogger new.
	logger initializeWith: [:aPosition | logger logPosition: aPosition].
	
	aMarsRover addHeadingObserver: (logger notifyBlock).
	
	^logger! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:11:40'!
onePositionCollection

	|collection|
	
	collection := OrderedCollection new.
	collection add: 1@2.
	^collection! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:18:43'!
onePositionHeadCollection

	|collection|
	
	collection := OrderedCollection new.
	collection add: 'East'.
	^collection! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:14:58'!
positionAndHeadingObserverFor: aMarsRover
	
	|logger| 
	
	logger := MarsRoverLogger new.
	logger initializeWith: [:aPosition | logger logPosition: aPosition].
	
	aMarsRover addPositionObserver: (logger notifyBlock).
	aMarsRover addHeadingObserver: (logger notifyBlock).
	
	^logger! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:14:47'!
positionObserverFor: aMarsRover
	
	|logger| 
	
	logger := MarsRoverLogger new.
	logger initializeWith: [:aPosition | logger logPosition: aPosition].
	
	aMarsRover addPositionObserver: (logger notifyBlock).
	
	^logger! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:12:31'!
test01LoggersAreEmptyAfterNoCommandProcessed

	|aMarsRover positionLogger headingLogger positionAndHeadingLogger |
	
	aMarsRover := MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	
	positionLogger := self positionObserverFor: aMarsRover.
	headingLogger := self headingObserverFor: aMarsRover.
	positionAndHeadingLogger := self positionAndHeadingObserverFor: aMarsRover.
	
	aMarsRover process: ''.
	
	self assert: self emptyCollection equals: positionLogger log.
	self assert: self emptyCollection equals: headingLogger log.
	self assert: self emptyCollection equals: positionAndHeadingLogger log! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:10:28'!
test02PositionLoggersAreUpdatedAfterOneMovementCommandButNoHeadingOnes

	|aMarsRover positionLogger headingLogger positionAndHeadingLogger|
	
	aMarsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLogger := self positionObserverFor: aMarsRover.
	headingLogger := self headingObserverFor: aMarsRover.
	positionAndHeadingLogger := self positionAndHeadingObserverFor: aMarsRover.
	
	aMarsRover process: 'f'.
	
	self assert: self onePositionCollection equals: positionLogger log.
	self assert: self emptyCollection equals: headingLogger log.
	self assert: self onePositionCollection equals: positionAndHeadingLogger log! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:22:20'!
test03HeadingLoggersAreUpdatedAfterChangeHeadingButNoPositionOnes

	|aMarsRover positionLogger headingLogger positionAndHeadingLogger|
	
	aMarsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLogger := self positionObserverFor: aMarsRover.
	headingLogger := self headingObserverFor: aMarsRover.
	positionAndHeadingLogger := self positionAndHeadingObserverFor: aMarsRover.
	
	aMarsRover process: 'r'.
	
	self assert: self emptyCollection equals: positionLogger log.
	self assert: self onePositionHeadCollection equals: headingLogger log.
	self assert: self onePositionHeadCollection equals: positionAndHeadingLogger log! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:28:34'!
test04PositionLoggerAreUpdatedAfterDoubleMovement

	|aMarsRover positionLogger |
	
	aMarsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLogger := self positionObserverFor: aMarsRover.
	
	aMarsRover process: 'ff'.
	
	self assert: self twoPositionCollection equals: positionLogger log.! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:27:56'!
test05HeadLoggerAreUpdatedAfterDoubleHeading

	|aMarsRover headingLogger |
	
	aMarsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingLogger := self headingObserverFor: aMarsRover.
	
	aMarsRover process: 'rl'.
	
	self assert: self twoPositionHeadCollection equals: headingLogger log.! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:30:59'!
test06PositionAndHeadingLoggerShowsBothThingsAfterCommands

	|aMarsRover positionAndHeadingLogger |
	
	aMarsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionAndHeadingLogger := self positionAndHeadingObserverFor: aMarsRover.
	
	aMarsRover process: 'fr'.
	
	self assert: self twoPositionHeadingCollection equals: positionAndHeadingLogger log.! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:25:19'!
twoPositionCollection

	|collection|
	
	collection := OrderedCollection new.
	collection add: 1@2.
	collection add: 1@3.
	^collection! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:28:12'!
twoPositionHeadCollection

	|collection|
	
	collection := OrderedCollection new.
	collection add: 'East'.
	collection add: 'North'.
	^collection! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:31:22'!
twoPositionHeadingCollection

	|collection|
	
	collection := OrderedCollection new.
	collection add: 1@2.
	collection add: 'East'.
	^collection! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 16:48:59'!
onePositionCollection

	|collection|
	
	collection := OrderedCollection new.
	collection add: 1@2.
	^collection! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 16:46:26'!
test01WindowEmptyAfterNoCommandProcessed

	|aMarsRover positionWindow headingWindow|
	
	aMarsRover := MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	
	positionWindow := self positionObserverFor: aMarsRover.
	headingWindow := self headingObserverFor: aMarsRover.
	
	aMarsRover process: ''.
	
	self assert: self emptyWindow equals: positionWindow window.
	self assert: self emptyWindow equals: headingWindow window.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'UNS 10/30/2023 16:48:48'!
test02PositionWindowUpdatedAfterMovementCommand

	|aMarsRover positionWindow |
	
	aMarsRover := MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	
	positionWindow := self positionObserverFor: aMarsRover.
	
	aMarsRover process: 'f'.
	
	self assert: self onePositionCollection equals: positionWindow window.! !


!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:42:32'!
emptyBothWindow

	|window|
	
	window := OrderedCollection new.
	window add: ''.
	window add: ''.
	^window! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:42:22'!
emptyWindow

	|window|
	
	window := OrderedCollection new.
	window add: ''.
	^window! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:57:25'!
headingObserverFor: aMarsRover
	
	|window| 
	
	window := MarsRoverPositionOrHeadingWindow new.
	window initializeWith: [:aPosition | window logPosition: aPosition].
	
	aMarsRover addHeadingObserver: (window notifyBlock).
	
	^window! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:45:04'!
positionAndHeadingObserverFor: aMarsRover
	
	|window| 
	
	window := MarsRoverWindow new.
	window initializeWith: [:aPosition | window logPosition: aPosition].
	
	aMarsRover addPositionObserver: (window notifyBlock).
	aMarsRover addHeadingObserver: (window notifyBlock).
	
	^window! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:57:52'!
positionObserverFor: aMarsRover
	
	|window| 
	
	window := MarsRoverPositionOrHeadingWindow new.
	window initializeWith: [:aPosition | window logPosition: aPosition].
	
	aMarsRover addPositionObserver: (window notifyBlock).
	
	^window! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'UNS 10/29/2023 20:16:37'!
initializeAt: aPosition heading: aHeadingType

	position := PositionProxy at: aPosition.
	head := HeadProxy heading: aHeadingType for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'UNS 10/29/2023 22:23:02'!
initializeObserverForAnObservable: anInitBlock

	^anInitBlock value! !


!MarsRover methodsFor: 'heading' stamp: 'UNS 10/29/2023 19:55:12'!
headEast
	
	head headTo: MarsRoverHeadingEast! !

!MarsRover methodsFor: 'heading' stamp: 'UNS 10/29/2023 19:54:57'!
headNorth
	
	head headTo: MarsRoverHeadingNorth! !

!MarsRover methodsFor: 'heading' stamp: 'UNS 10/29/2023 19:54:46'!
headSouth
	
	head headTo: MarsRoverHeadingSouth! !

!MarsRover methodsFor: 'heading' stamp: 'UNS 10/29/2023 19:54:34'!
headWest
	
	head headTo: MarsRoverHeadingWest ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'UNS 10/29/2023 00:23:10'!
isAt: aPosition heading: aHeadingType

	^(position isAt: aPosition) and: [ head isHeading: aHeadingType ] ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'UNS 10/29/2023 00:30:54'!
moveEast
	
	position changePosition: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'UNS 10/29/2023 00:32:27'!
moveNorth
	
	position changePosition: (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'UNS 10/29/2023 00:32:54'!
moveSouth
	
	position changePosition: (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'UNS 10/29/2023 00:33:00'!
moveWest
	
	position changePosition: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'UNS 10/30/2023 16:04:13'!
addHeadingObserver: aNotifyBlock

	head addSuscriber: aNotifyBlock! !

!MarsRover methodsFor: 'observers' stamp: 'UNS 10/30/2023 15:56:18'!
addPositionObserver: aNotifyBlock

	position addSuscriber: aNotifyBlock! !

!MarsRover methodsFor: 'observers' stamp: 'UNS 10/29/2023 22:08:29'!
head

	^head! !

!MarsRover methodsFor: 'observers' stamp: 'UNS 10/29/2023 22:08:25'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover headProxy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

!MarsRoverHeading methodsFor: 'initialization' stamp: 'UNS 10/30/2023 15:27:55'!
initializeFor: aMarsRover withObservable: aHeadObservable
	
	marsRover := aMarsRover.
	headProxy := aHeadObservable! !


!MarsRoverHeading methodsFor: 'name' stamp: 'UNS 10/29/2023 20:10:44'!
headName

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'UNS 10/30/2023 15:29:02'!
for: aMarsRover withObservable: aHeadObservable
	
	^self new initializeFor: aMarsRover withObservable: aHeadObservable! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 22:13:18'!
headName

	^'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 22:13:18'!
headName

	^'North'! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 22:13:18'!
headName

	^'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 22:13:18'!
headName

	^'West'! !


!classDefinition: #MarsRoverObservable category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObservable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #HeadProxy category: 'MarsRover-WithHeading'!
MarsRoverObservable subclass: #HeadProxy
	instanceVariableNames: 'suscribersClosures marsRover head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 20:09:20'!
addSuscriber: aSuscriberClosure

	suscribersClosures add: aSuscriberClosure! !

!HeadProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 20:15:28'!
doesNotUnderstand: aMessage

	aMessage sendTo: head! !

!HeadProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 15:30:24'!
headTo: aHeadingClass

	head := aHeadingClass for: marsRover withObservable: self.
	self notifySuscribers! !

!HeadProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 15:27:31'!
initializeHeading: aHeadingType for: aMarsRover 
	
	marsRover := aMarsRover.
	head := aHeadingType for: aMarsRover withObservable: self.
	suscribersClosures := OrderedCollection new.! !

!HeadProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 21:45:26'!
isHeading: aHeadingType

	^head isHeading: aHeadingType! !

!HeadProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 20:10:24'!
notifySuscribers
	
	suscribersClosures do: [ :aSuscriberClosure | aSuscriberClosure value: head headName]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadProxy class' category: 'MarsRover-WithHeading'!
HeadProxy class
	instanceVariableNames: ''!

!HeadProxy class methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 20:17:18'!
heading: aHeadingType for: aMarsRover 

	^self new initializeHeading: aHeadingType for: aMarsRover! !


!classDefinition: #PositionProxy category: 'MarsRover-WithHeading'!
MarsRoverObservable subclass: #PositionProxy
	instanceVariableNames: 'suscribersClosures marsRover position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/28/2023 22:39:17'!
addSuscriber: aSuscriberClosure

	suscribersClosures add: aSuscriberClosure! !

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 00:33:49'!
changePosition: aMove
	
	position := position + aMove.
	self notifySuscribers! !

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 00:18:56'!
initializeAt: aPosition

	position := aPosition.
	suscribersClosures := OrderedCollection new! !

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/28/2023 22:38:43'!
initializeFor: aMarsRover

	marsRover := aMarsRover.
	suscribersClosures := OrderedCollection new! !

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 00:21:05'!
isAt: aPosition

	^position = aPosition! !

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 00:35:13'!
notifySuscribers
	
	suscribersClosures do: [ :aSuscriberClosure | aSuscriberClosure value: position]! !

!PositionProxy methodsFor: 'as yet unclassified' stamp: 'UNS 10/28/2023 22:46:44'!
suscribersClosures

	^suscribersClosures! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionProxy class' category: 'MarsRover-WithHeading'!
PositionProxy class
	instanceVariableNames: ''!

!PositionProxy class methodsFor: 'as yet unclassified' stamp: 'UNS 10/29/2023 00:18:37'!
at: aPosition

	^self new initializeAt: aPosition! !

!PositionProxy class methodsFor: 'as yet unclassified' stamp: 'UNS 10/28/2023 22:37:47'!
for: aMarsRover

	^self new initializeFor: aMarsRover! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'log notifyBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'log' stamp: 'UNS 10/30/2023 15:49:57'!
log
	 
	^log! !

!MarsRoverLogger methodsFor: 'log' stamp: 'UNS 10/30/2023 16:12:55'!
logPosition: aPosition
	
	log add: aPosition! !


!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 15:49:40'!
initializeWith: aBlock
	
	log := OrderedCollection new.
	notifyBlock := aBlock! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 15:51:39'!
notifyBlock
	
	^notifyBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 15:49:03'!
withNotifyClosure: aBlock

	^self new initializeWith:  aBlock! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'notifyBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:45:44'!
initializeWith: aBlock
	
	notifyBlock := aBlock! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:46:42'!
notifyBlock
	
	^notifyBlock ! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:47:23'!
window

	|window|
	window := OrderedCollection new.
	window add: ''.
	 ^window! !


!classDefinition: #MarsRoverPositionOrHeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverWindow subclass: #MarsRoverPositionOrHeadingWindow
	instanceVariableNames: 'window'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionOrHeadingWindow methodsFor: 'as yet unclassified' stamp: 'UNS 10/30/2023 16:55:14'!
initializeWith: aBlock

	|windowCollection|
	
	super initializeWith: aBlock.
	windowCollection := OrderedCollection new.
	windowCollection add: ''.
	window := windowCollection.! !
