!classDefinition: #Falso category: 'verdaderoFalso'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'verdaderoFalso'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: 'verdaderoFalso'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'OPVF' stamp: 'UNS 8/17/2023 21:26:00'!
no
	^Verdadero! !

!Falso class methodsFor: 'OPVF' stamp: 'UNS 8/17/2023 21:41:23'!
o: bool 
	^bool! !

!Falso class methodsFor: 'OPVF' stamp: 'UNS 8/17/2023 21:38:13'!
y: bool 
 	 ^Falso! !


!Falso class methodsFor: 'closure' stamp: 'UNS 8/17/2023 21:53:25'!
siEsFalso: closure 
	^closure value! !

!Falso class methodsFor: 'closure' stamp: 'UNS 8/17/2023 21:52:35'!
siEsVerdadero: closure 
	^self! !


!classDefinition: #Verdadero category: 'verdaderoFalso'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'verdaderoFalso'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: 'verdaderoFalso'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'opVF' stamp: 'UNS 8/17/2023 21:22:35'!
no
	^Falso! !

!Verdadero class methodsFor: 'opVF' stamp: 'UNS 8/17/2023 21:39:51'!
o: bool 
	^Verdadero! !

!Verdadero class methodsFor: 'opVF' stamp: 'UNS 8/17/2023 21:40:04'!
y: bool
	^bool
	 
	! !


!Verdadero class methodsFor: 'closure' stamp: 'UNS 8/17/2023 21:51:41'!
siEsFalso: closure 
	^self! !

!Verdadero class methodsFor: 'closure' stamp: 'UNS 8/17/2023 21:48:29'!
siEsVerdadero: closure 
	^closure value! !


!classDefinition: #VerdaderoFalsoTest category: 'verdaderoFalso'!
DenotativeObject subclass: #VerdaderoFalsoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'verdaderoFalso'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VerdaderoFalsoTest class' category: 'verdaderoFalso'!
VerdaderoFalsoTest class
	instanceVariableNames: ''!

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'GHT 9/7/2023 11:58:11'!
test01VerdaderoNo

	Assert that: Verdadero no isEqualTo: Falso ! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:24:10'!
test02FalsoNo

	Assert that: Falso no isEqualTo: Verdadero ! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:33:00'!
test03VerdaderoYVerdadero

	Assert that: ( Verdadero y: Verdadero ) isEqualTo: Verdadero! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:37:01'!
test04VerdaderoYFalso

	Assert that: ( Verdadero y: Falso ) isEqualTo: Falso! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:37:30'!
test05FalsoyVerdadero

	Assert that: ( Falso y: Verdadero ) isEqualTo: Falso! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:38:33'!
test06FalsoyFalso

	Assert that: ( Falso y: Falso ) isEqualTo: Falso! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:39:13'!
test07VerdaderoOVerdadero

	Assert that: ( Verdadero o: Verdadero ) isEqualTo: Verdadero! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:40:25'!
test08VerdaderoOFalso

	Assert that: ( Verdadero o: Falso ) isEqualTo: Verdadero! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:40:50'!
test09FalsoOVerdadero

	Assert that: ( Falso o: Verdadero ) isEqualTo: Verdadero! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:41:39'!
test10FalsoOFalso

	Assert that: ( Falso o: Falso ) isEqualTo: Falso! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:51:13'!
test11SiEsFalsoVerdadero

	Assert that: (Verdadero siEsFalso: [1+1]) isEqualTo: Verdadero ! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 22:01:24'!
test11SiEsVerdaderoVerdadero

	Assert that: (Verdadero siEsVerdadero: [1+1]) isEqualTo: 2! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:52:08'!
test12SiEsVerdaderoFalso

	Assert that: (Falso siEsVerdadero: [1+1]) isEqualTo: Falso! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 22:01:30'!
test12SiEsVerdaderoVerdadero

	Assert that: (Verdadero siEsVerdadero: [1+1]) isEqualTo: 2! !

!VerdaderoFalsoTest class methodsFor: 'as yet unclassified' stamp: 'UNS 8/17/2023 21:53:06'!
test13SiEsFalsoFalso

	Assert that: (Falso siEsFalso: [1+1]) isEqualTo: 2! !
