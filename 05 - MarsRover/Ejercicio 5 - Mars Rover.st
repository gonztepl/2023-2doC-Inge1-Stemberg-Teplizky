!classDefinition: #TestXX category: 'Ejercicio 5 - Mars Rover'!
TestCase subclass: #TestXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 5 - Mars Rover'!

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/5/2023 21:42:09'!
test01MarsRoverDoesNotMoveWhenProcessingEmptyCommandList
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
	
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: ''.
	
	self assert: (aMarsRover isAt: anInitialPoint pointingTo: aCardinalPoint).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:05:04'!
test03MarsRoverMovesForwardWhenProcessingCommandListWithFs
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'fff'.
	
	self assert: (aMarsRover isAt: 0@3 pointingTo: aCardinalPoint).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:04:35'!
test05MarsRoverMovesBackwardsWhenProcessingCommandListWithBs
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'bbb'.
	
	self assert: (aMarsRover isAt: 0@-3 pointingTo: aCardinalPoint).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:13:41'!
test06MarsRoverPointsToWestWhenProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: #West).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:03:17'!
test07MarsRoverMovesForwardToWestAfterProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'lf'.
	
	self assert: (aMarsRover isAt: -1@0 pointingTo: #West).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:03:05'!
test08MarsRoverMovesBackwardsToEastAfterProcessingCommandL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'lb'.
	
	self assert: (aMarsRover isAt: 1@0 pointingTo: #West).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:13:49'!
test09MarsRoverPointsToEastWhenProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: #East).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:15:11'!
test10MarsRoverMovesForwardToEastAfterProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rf'.
	
	self assert: (aMarsRover isAt: 1@0 pointingTo: #East).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:20:29'!
test11MarsRoverMovesBackwardsToWestAfterProcessingCommandR
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'rb'.
	
	self assert: (aMarsRover isAt: -1@0 pointingTo: #East).
	! !

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/8/2023 13:25:18'!
test12MarsRoverPointsToSouthAfterProcessingEvenNumberOfCommandsL
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'll'.
	
	self assert: (aMarsRover isAt: 0@0 pointingTo: #South).
	! !


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


!MarsRover methodsFor: 'assertions' stamp: 'ght 10/5/2023 21:38:39'!
isAt: aPosition pointingTo: aCardinalPoint
	
	^currentPoint = aPosition  &   pointingTo = aCardinalPoint.! !


!MarsRover methodsFor: 'processing' stamp: 'ght 10/8/2023 14:30:10'!
processCommandList: aProcessCommandList 
	
	aProcessCommandList do: [:aCommand | 
		(aCommand = $l)				
			ifTrue: [
				(pointingTo = #West) 
				ifTrue: [pointingTo := #South]
			        ifFalse: [pointingTo := #West]
			]
			ifFalse:[	
				aCommand = $r 
				ifTrue: [pointingTo := #East] 
				ifFalse:[
					aCommand = $b
					ifTrue: 
						[
							pointingTo = #West 
							ifTrue: [currentPoint := currentPoint + (1@0)] 
							ifFalse: [
								pointingTo = #East
								ifTrue: [currentPoint := currentPoint - (1@0)]
								 ifFalse: [currentPoint := currentPoint - (0@1)]
							]
								
						]
					ifFalse:
						[
							pointingTo = #West 
							ifTrue: [currentPoint := currentPoint - (1@0)] 
							ifFalse: [
								pointingTo = #East 
								ifTrue: [currentPoint := currentPoint + (1@0)]
								ifFalse: [currentPoint := currentPoint + (0@1)]
									
								]
								
						]
					] 
		]
	]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio 5 - Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'ght 10/5/2023 21:39:30'!
at: anInitialPoint pointingTo: aCardinalPoint 

	^self new at: anInitialPoint pointingTo: aCardinalPoint. ! !
