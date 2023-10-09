!classDefinition: #MarsRoverTest category: 'Ejercicio 5 - Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:19:57'!
test01MarsRoverDoesNotMoveWhenProcessingEmptyCommandList
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
	
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: ''.
	
	self assert: (aMarsRover isAt: anInitialPoint pointingTo: North).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:20:01'!
test03MarsRoverMovesForwardWhenProcessingCommandListWithFs
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'fff'.
	
	self assert: (aMarsRover isAt: 0@3 pointingTo: North).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:20:08'!
test05MarsRoverMovesBackwardsWhenProcessingCommandListWithBs
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'bbb'.
	
	self assert: (aMarsRover isAt: 0@-3 pointingTo: North).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:20:09'!
test06MarsRoverPointsToWestAfterProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: West).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:22:20'!
test07MarsRoverMovesForwardPointingToWestAfterProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'lf'.
	
	self assert: (aMarsRover isAt: -1@0 pointingTo: West).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:23:06'!
test08MarsRoverMovesBackwardsPointingToWestAfterProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'lb'.
	
	self assert: (aMarsRover isAt: 1@0 pointingTo: West).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:23:24'!
test09MarsRoverPointsToEastAfterProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: East).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:23:37'!
test10MarsRoverMovesForwardPointingToEastAfterProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rf'.
	
	self assert: (aMarsRover isAt: 1@0 pointingTo: East).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:23:50'!
test11MarsRoverMovesBackwardsPointingToWestAfterProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rb'.
	
	self assert: (aMarsRover isAt: -1@0 pointingTo: East).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:20:33'!
test12MarsRoverPointsToSouthAfterProcessingEvenNumberOfCommandsL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'll'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: South).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:24:14'!
test13MarsRoverMovesForwardPointingToSouthAfterProcessingEvenNumberOfCommandsL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'llf'.
	
	self assert: (aMarsRover isAt: 0@-1 pointingTo: South).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:24:33'!
test14MarsRoverMovesBackwardsPointingToSouthAfterProcessingEvenNumberOfCommandsL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'llb'.
	
	self assert: (aMarsRover isAt: 0@1 pointingTo: South).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:20:41'!
test15MarsRoverPointsToSouthAfterProcessingEvenNumberOfCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rr'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: South).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:20:44'!
test16MarsRoverPointsToNorthAfterProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'lr'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: North).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:20:55'!
test17MarsRoverPointsToNorthAfterProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rl'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: North).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:29:01'!
test18MarsRoverPointsToWestAfterProcessingEvenNumberOfCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'llr'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: West).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:29:12'!
test19MarsRoverPointsToEastAfterProcessingEvenNumberOfCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rrl'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: East).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 01:29:45'!
test20MarsRoverStopProcessingAfterWrongCommand
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rrlallb'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: East).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'UNS 10/9/2023 16:25:34'!
test21MarsRoverGeneralizationTest
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := North new.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rrffflbbbblffabb'.
	
	aMarsRover processCommandList: 'rrrrllll'.
	
	self assert: (aMarsRover isAt: -4@-1 pointingTo: North).
	! !


!classDefinition: #CardinalPoint category: 'Ejercicio 5 - Mars Rover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!CardinalPoint methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:44:32'!
moveBackwards: aMarsRover

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:45:12'!
moveForward: aMarsRover

	self subclassResponsibility! !


!CardinalPoint methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:45:26'!
rotate90DegreesLeft: aMarsRover

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:45:30'!
rotate90DegreesRight: aMarsRover

	self subclassResponsibility! !


!classDefinition: #East category: 'Ejercicio 5 - Mars Rover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!East methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:47:06'!
rotate90DegreesLeft: aMarsRover

	aMarsRover rotate90DegreesLeftPointingToEast! !

!East methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:47:19'!
rotate90DegreesRight: aMarsRover

	aMarsRover rotate90DegreesRightPointingToEast! !


!East methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:46:30'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsPointingToEast! !

!East methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:46:46'!
moveForward: aMarsRover

	aMarsRover moveForwardPointingToEast! !


!classDefinition: #North category: 'Ejercicio 5 - Mars Rover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!North methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:47:44'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsPointingToNorth! !

!North methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:47:53'!
moveForward: aMarsRover

	aMarsRover moveForwardPointingToNorth! !


!North methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:48:01'!
rotate90DegreesLeft: aMarsRover

	aMarsRover rotate90DegreesLeftPointingToNorth! !

!North methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:48:14'!
rotate90DegreesRight: aMarsRover

	aMarsRover rotate90DegreesRightPointingToNorth
	! !


!classDefinition: #South category: 'Ejercicio 5 - Mars Rover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!South methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:48:32'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsPointingToSouth! !

!South methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:48:48'!
moveForward: aMarsRover

	aMarsRover moveForwardPointingToSouth! !


!South methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:48:57'!
rotate90DegreesLeft: aMarsRover

	aMarsRover rotate90DegreesLeftPointingToSouth! !

!South methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:49:08'!
rotate90DegreesRight: aMarsRover

	aMarsRover rotate90DegreesRightPointingToSouth! !


!classDefinition: #West category: 'Ejercicio 5 - Mars Rover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!West methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:49:20'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsPointingToWest! !

!West methodsFor: 'movement' stamp: 'UNS 10/9/2023 00:49:28'!
moveForward: aMarsRover

	aMarsRover moveForwardPointingToWest! !


!West methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:49:35'!
rotate90DegreesLeft: aMarsRover

	aMarsRover rotate90DegreesLeftPointingToWest! !

!West methodsFor: 'rotation' stamp: 'UNS 10/9/2023 00:49:42'!
rotate90DegreesRight: aMarsRover

	aMarsRover rotate90DegreesRightPointingToWest! !


!classDefinition: #MarsRover category: 'Ejercicio 5 - Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPoint pointingTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!MarsRover methodsFor: 'initialize' stamp: 'ght 10/5/2023 21:39:30'!
at: anInitialPoint pointingTo: aCardinalPoint 
	
	currentPoint := anInitialPoint.
	pointingTo := aCardinalPoint. ! !


!MarsRover methodsFor: 'assertions' stamp: 'UNS 10/9/2023 01:59:45'!
isAWrongCommand: aCharCommand

	^(aCharCommand ~= $f) and: (aCharCommand ~= $b) 
	   and: (aCharCommand ~= $l) and: (aCharCommand ~= $r)! !

!MarsRover methodsFor: 'assertions' stamp: 'UNS 10/9/2023 01:22:43'!
isAt: aPosition pointingTo: aCardinalPoint
	
	^currentPoint = aPosition  and: [pointingTo class = aCardinalPoint.]! !


!MarsRover methodsFor: 'processing' stamp: 'UNS 10/9/2023 01:56:14'!
processCommand: aCharCommand
	
	(MarsRoverCommand aCommandFor: aCharCommand) 
		processCommandPointingTo: pointingTo for: self! !

!MarsRover methodsFor: 'processing' stamp: 'UNS 10/9/2023 02:00:13'!
processCommandList: aProcessCommandList 
	
	aProcessCommandList do: 
		[:aCommand |  
			(self isAWrongCommand: aCommand) ifTrue: [^self].
			 self processCommand: aCommand]
	! !


!MarsRover methodsFor: 'processing-east' stamp: 'UNS 10/9/2023 00:59:14'!
moveBackwardsPointingToEast

	currentPoint := currentPoint - (1@0)! !

!MarsRover methodsFor: 'processing-east' stamp: 'UNS 10/9/2023 00:59:35'!
moveForwardPointingToEast

	currentPoint := currentPoint + (1@0)! !

!MarsRover methodsFor: 'processing-east' stamp: 'UNS 10/9/2023 01:00:11'!
rotate90DegreesLeftPointingToEast

	pointingTo := North new! !

!MarsRover methodsFor: 'processing-east' stamp: 'UNS 10/9/2023 01:00:40'!
rotate90DegreesRightPointingToEast

	pointingTo := South new! !


!MarsRover methodsFor: 'processing-north' stamp: 'UNS 10/9/2023 01:01:23'!
moveBackwardsPointingToNorth

	currentPoint := currentPoint - (0@1)! !

!MarsRover methodsFor: 'processing-north' stamp: 'UNS 10/9/2023 01:01:37'!
moveForwardPointingToNorth

	currentPoint := currentPoint + (0@1)! !

!MarsRover methodsFor: 'processing-north' stamp: 'UNS 10/9/2023 01:01:58'!
rotate90DegreesLeftPointingToNorth

	pointingTo := West new.! !

!MarsRover methodsFor: 'processing-north' stamp: 'UNS 10/9/2023 01:02:12'!
rotate90DegreesRightPointingToNorth

	pointingTo := East new.! !


!MarsRover methodsFor: 'processing-south' stamp: 'UNS 10/9/2023 01:03:22'!
moveBackwardsPointingToSouth
	
	currentPoint := currentPoint + (0@1)! !

!MarsRover methodsFor: 'processing-south' stamp: 'UNS 10/9/2023 01:03:33'!
moveForwardPointingToSouth

	currentPoint := currentPoint - (0@1)! !

!MarsRover methodsFor: 'processing-south' stamp: 'UNS 10/9/2023 01:28:57'!
rotate90DegreesLeftPointingToSouth

	pointingTo := East new.! !

!MarsRover methodsFor: 'processing-south' stamp: 'UNS 10/9/2023 01:28:41'!
rotate90DegreesRightPointingToSouth

	pointingTo := West new.! !


!MarsRover methodsFor: 'processing-west' stamp: 'UNS 10/9/2023 01:05:49'!
moveBackwardsPointingToWest

	currentPoint := currentPoint + (1@0)! !

!MarsRover methodsFor: 'processing-west' stamp: 'UNS 10/9/2023 01:05:59'!
moveForwardPointingToWest

	currentPoint := currentPoint - (1@0)! !

!MarsRover methodsFor: 'processing-west' stamp: 'UNS 10/9/2023 01:06:36'!
rotate90DegreesLeftPointingToWest

	pointingTo := South new.! !

!MarsRover methodsFor: 'processing-west' stamp: 'UNS 10/9/2023 01:07:04'!
rotate90DegreesRightPointingToWest

	pointingTo := North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio 5 - Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'ght 10/5/2023 21:39:30'!
at: anInitialPoint pointingTo: aCardinalPoint 

	^self new at: anInitialPoint pointingTo: aCardinalPoint. ! !


!classDefinition: #MarsRoverCommand category: 'Ejercicio 5 - Mars Rover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!MarsRoverCommand methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:25:06'!
processCommandPointingTo: aCardinalPoint

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'Ejercicio 5 - Mars Rover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:19:07'!
aCommandFor: aCharCommand

	^((self subclasses detect: [:aMarsRoverCommandClass | aMarsRoverCommandClass canHandle: aCharCommand ]) new)! !

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:19:37'!
canHandle

	self subclassResponsibility ! !


!classDefinition: #MoveBackwardsCommand category: 'Ejercicio 5 - Mars Rover'!
MarsRoverCommand subclass: #MoveBackwardsCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!MoveBackwardsCommand methodsFor: 'processing' stamp: 'UNS 10/9/2023 00:33:32'!
processCommandPointingTo: aCardinalPoint for: aMarsRover

	aCardinalPoint moveBackwards: aMarsRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwardsCommand class' category: 'Ejercicio 5 - Mars Rover'!
MoveBackwardsCommand class
	instanceVariableNames: ''!

!MoveBackwardsCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:20:30'!
canHandle: aCharCommand

	^aCharCommand  = $b! !


!classDefinition: #MoveForwardCommand category: 'Ejercicio 5 - Mars Rover'!
MarsRoverCommand subclass: #MoveForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!MoveForwardCommand methodsFor: 'processing' stamp: 'UNS 10/9/2023 00:33:26'!
processCommandPointingTo: aCardinalPoint for: aMarsRover
	
	aCardinalPoint moveForward: aMarsRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwardCommand class' category: 'Ejercicio 5 - Mars Rover'!
MoveForwardCommand class
	instanceVariableNames: ''!

!MoveForwardCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:20:56'!
canHandle: aCharCommand

	^aCharCommand = $f! !


!classDefinition: #Rotate90DegreesLeftCommand category: 'Ejercicio 5 - Mars Rover'!
MarsRoverCommand subclass: #Rotate90DegreesLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!Rotate90DegreesLeftCommand methodsFor: 'processing' stamp: 'UNS 10/9/2023 00:33:03'!
processCommandPointingTo: aCardinalPoint for: aMarsRover
	
	aCardinalPoint rotate90DegreesLeft: aMarsRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rotate90DegreesLeftCommand class' category: 'Ejercicio 5 - Mars Rover'!
Rotate90DegreesLeftCommand class
	instanceVariableNames: ''!

!Rotate90DegreesLeftCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:21:12'!
canHandle: aCharCommand

	^aCharCommand = $l! !


!classDefinition: #Rotate90DegreesRightCommand category: 'Ejercicio 5 - Mars Rover'!
MarsRoverCommand subclass: #Rotate90DegreesRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!Rotate90DegreesRightCommand methodsFor: 'processing' stamp: 'UNS 10/9/2023 00:32:47'!
processCommandPointingTo: aCardinalPoint for: aMarsRover

	aCardinalPoint rotate90DegreesRight: aMarsRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rotate90DegreesRightCommand class' category: 'Ejercicio 5 - Mars Rover'!
Rotate90DegreesRightCommand class
	instanceVariableNames: ''!

!Rotate90DegreesRightCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 00:21:23'!
canHandle: aCharCommand

	^aCharCommand = $r! !


!classDefinition: #WrongCommand category: 'Ejercicio 5 - Mars Rover'!
MarsRoverCommand subclass: #WrongCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!WrongCommand methodsFor: 'processing' stamp: 'UNS 10/9/2023 01:42:45'!
processCommandPointingTo: aCardinalPoint for: aMarsRover

	^aMarsRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WrongCommand class' category: 'Ejercicio 5 - Mars Rover'!
WrongCommand class
	instanceVariableNames: ''!

!WrongCommand class methodsFor: 'as yet unclassified' stamp: 'UNS 10/9/2023 01:41:40'!
canHandle: aCharCommand

	^(aCharCommand ~= $f) and: (aCharCommand ~= $b) 
	   and: (aCharCommand ~= $l) and: (aCharCommand ~= $r)! !
