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

!TestXX methodsFor: 'as yet unclassified' stamp: 'ght 10/5/2023 21:48:24'!
test02
	
	|aMarsRover anInitialPoint aCardinalPoint|
	
	anInitialPoint := 0@0.
	aCardinalPoint  := #North.
		
	aMarsRover := MarsRover at: anInitialPoint pointingTo: aCardinalPoint. 
	
	aMarsRover processCommandList: 'f'.
	
	self assert: (aMarsRover isAt: 0@1 pointingTo: aCardinalPoint).
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


!MarsRover methodsFor: 'processing' stamp: 'ght 10/5/2023 21:49:08'!
processCommandList: aProcessCommandList 
	
	(aProcessCommandList = 'f') ifTrue: [
		currentPoint := currentPoint + (0@1). 
		] 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio 5 - Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'ght 10/5/2023 21:39:30'!
at: anInitialPoint pointingTo: aCardinalPoint 

	^self new at: anInitialPoint pointingTo: aCardinalPoint. ! !
