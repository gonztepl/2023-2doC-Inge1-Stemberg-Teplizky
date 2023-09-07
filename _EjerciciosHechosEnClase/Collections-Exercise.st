!classDefinition: #XXX category: 'Collections-Exercise'!
Object subclass: #XXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Exercise'!

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:52:04'!
extractVowels
	
	'abcdefguijp' select:[:char | char isVowel].
! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:23:55'!
findDoubles
	
	|elements|
	
	elements:= #(1 2 5 6 9).
	
	^elements collect:[:element | element * 2].! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 9/7/2023 11:39:29'!
findFirstEven
	
	|elements|
	
	elements:= #(1 5 9).
	
	^elements detect:[:element | element even]. 
	"No es polimorfico. Devuelve la primer cosa que cumple la condición de la guarda"
	"Otro problema: que ocurre cuando ningun elemento cumple la condicion."! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:37:50'!
findFirstEvenWithoutMatching
	
	|elements|
	
	elements:= #(1 3 5 7 9).
	
	^elements detect: [:element | element even]
			  ifNone: [42]"[self error: 'Error']".  
! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 9/7/2023 11:48:27'!
findFirstEvenWithoutMatchingReturnString
	
	|elements|
	
	elements:= #(1 3 5 7 9).
	
	^elements detect: [:element | element even]
			  ifNone: ['No Hay Pares'].  
! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 9/7/2023 11:45:01'!
findFirstEvenWithoutMatchingThrowsException
	
	|elements|
	
	elements:= #(1 3 5 7 9).
	
	^[elements detect: [:element | element even]]
		on:  Error
		do: [ elements objectNotFoundDescription ]
! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 20:48:48'!
findOddsPart0

        | elements index odds |

        elements:= #(1 2 5 6 9).

        odds := OrderedCollection new.
        index := 1.

        [index <= elements size]
        whileTrue: [
                ((elements at: index) odd) ifTrue: [odds add: (elements at: index)].
                index := index +1.
                ].
        ^odds

! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:08:19'!
findOddsPart1

        | elements odds |

        elements:= #(1 2 5 6 9).

        odds := OrderedCollection new.
        
        elements do: [: ": inyectar argumentos" element |  
		(element odd) ifTrue: [odds add: element]	].
        
	^odds

! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:16:39'!
findOddsPart2

        | elements |

        elements:= #(1 2 5 6 9).
               
	^elements select:[:element | element odd].

! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:20:37'!
findOddsPart2_1

        | elements |

        elements:= #(1 2 5 6 9 9) asSet.
               
	^elements select:[:element | element odd].

! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 8/31/2023 21:45:56'!
sumElementsInjecting
	
	^#(1 5 9) inject: 0 into:[:sum :element | sum + element].  
	"la suma la pedimos con sum, que utiliza por abajo inject, que utiliza por abajo do"
! !

!XXX methodsFor: 'as yet unclassified' stamp: 'GHT 9/7/2023 11:51:28'!
sumElementsSum
	
	^#(1 5 9) sum  
	"simplificamos el Injection realizado en sumElementsInjecting con mensaje sum de las colecciones"
! !
