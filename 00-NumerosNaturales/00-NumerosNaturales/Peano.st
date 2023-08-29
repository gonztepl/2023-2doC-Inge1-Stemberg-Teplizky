!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operaciones' stamp: 'GHT 8/28/2023 20:40:46'!
* aNaturalNumber

	^aNaturalNumber! !

!I class methodsFor: 'operaciones' stamp: 'UNS 8/24/2023 21:02:54'!
+ aNaturalNumber

	^aNaturalNumber next! !

!I class methodsFor: 'operaciones' stamp: 'GHT 8/28/2023 21:48:46'!
- aNaturalNumber

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'operaciones' stamp: 'GHT 8/28/2023 21:52:01'!
/ aNaturalNumber

	aNaturalNumber  = self ifTrue: [^I.].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !


!I class methodsFor: 'auxiliares' stamp: 'UNS 8/29/2023 01:27:31'!
> aNaturalNumber
	
	^false! !

!I class methodsFor: 'auxiliares' stamp: 'GHT 8/28/2023 20:53:15'!
TimesToDivide: aNaturalNumber
	
	^aNaturalNumber ! !

!I class methodsFor: 'auxiliares' stamp: 'UNS 8/24/2023 20:54:09'!
next
	
	^II! !

!I class methodsFor: 'auxiliares' stamp: 'UNS 8/24/2023 21:57:25'!
restateA: aNaturalNumber

	^aNaturalNumber previous! !


!I class methodsFor: 'error' stamp: 'GHT 8/28/2023 21:49:43'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por 1'! !

!I class methodsFor: 'error' stamp: 'GHT 8/28/2023 21:48:46'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'No se puede restar al 1'! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'GHT 8/28/2023 20:45:09'!
* aNaturalNumber

	^aNaturalNumber + (self previous * aNaturalNumber )! !

!II class methodsFor: 'operaciones' stamp: 'UNS 8/24/2023 21:15:58'!
+ aNaturalNumber

	^self previous + aNaturalNumber next! !

!II class methodsFor: 'operaciones' stamp: 'UNS 8/24/2023 21:54:23'!
- aNaturalNumber
	
	^aNaturalNumber restateA: self.! !

!II class methodsFor: 'operaciones' stamp: 'UNS 8/29/2023 01:31:55'!
/ aNaturalNumber
	
	aNaturalNumber > self ifTrue:  [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^aNaturalNumber TimesToDivide: self! !


!II class methodsFor: 'auxiliares' stamp: 'UNS 8/29/2023 01:27:11'!
> aNaturalNumber

	aNaturalNumber  = I ifTrue: [^true.].
	^self previous > aNaturalNumber  previous! !

!II class methodsFor: 'auxiliares' stamp: 'GHT 8/28/2023 20:52:33'!
TimesToDivide: aNaturalNumber

	aNaturalNumber  = self ifTrue: [^I.].
	^aNaturalNumber - self / self + I.! !

!II class methodsFor: 'auxiliares' stamp: 'GHT 8/28/2023 21:14:20'!
next
	next ifNotNil: [^next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next! !

!II class methodsFor: 'auxiliares' stamp: 'UNS 8/24/2023 21:59:31'!
restateA: aNaturalNumber

	 ^aNaturalNumber previous - self previous
	! !


!II class methodsFor: 'error' stamp: 'GHT 8/28/2023 22:07:27'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un número mayor'! !


!II class methodsFor: 'colaboradores' stamp: 'UNS 8/24/2023 21:22:05'!
previous

	^previous.! !

!II class methodsFor: 'colaboradores' stamp: 'UNS 8/24/2023 21:27:40'!
previous: aNaturalNumber
	
	previous := aNaturalNumber! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'UNS 8/29/2023 01:48:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'UNS 8/29/2023 01:48:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'UNS 8/29/2023 01:48:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Peano'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Peano'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'UNS 8/29/2023 01:48:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Peano'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Peano'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'UNS 8/29/2023 01:48:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!