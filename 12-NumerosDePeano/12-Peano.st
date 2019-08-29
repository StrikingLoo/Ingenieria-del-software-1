!classDefinition: #I category: #'12-Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'12-Peano'!
I class
	instanceVariableNames: 'sucesor'!

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:42:04'!
* aPeano
	^aPeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:02:54'!
+ aPeano
	^aPeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:10:37'!
- aPeano
    self error: (self descripcionDeErrorDeNumerosNegativosNoSoportados )! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:15:26'!
/ aPeano
	(aPeano = I) ifTrue: [^I].
	self error:(self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor )! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:23:43'!
< aPeano
	^(aPeano = I) not.! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:12:06'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:06:26'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No hay soporte para numeros negativos.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:34:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:36'!
invertedMinus: aPeano
	"This function represents the operation aPeano - self"
	"aPeano has to be greater than I"
	^aPeano previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:02:54'!
next
	sucesor := II.
	^sucesor! !


!classDefinition: #II category: #'12-Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'12-Peano'!
II class
	instanceVariableNames: 'sucesor previo'!

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:36'!
* aPeano
    ^(self previous * aPeano) + aPeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:36'!
+ aPeano
    ^self previous + aPeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:45:44'!
- aPeano
	^aPeano invertedMinus: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:29:00'!
/ aPeano
    (self = aPeano) ifTrue: [^I].
    (self < aPeano) ifTrue: [self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)].
    ^((self - aPeano) / aPeano) + I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:27:06'!
< aPeano
	(aPeano = I) ifTrue: [^false].
	^self previous < aPeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:12:15'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:06:50'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No hay soporte para numeros negativos.'! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:34:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := III.
	previo := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:36'!
invertedMinus: aPeano
	"This function represents the operation aPeano - self"
	"aPeano has to be greater than I"
	^(aPeano previous) - (self previous).! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:49'!
next
	sucesor ifNil: [ sucesor := self cloneNamed: self name, 'I'.
		sucesor previous: self].
	^sucesor! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:49'!
previous
    previo ifNil: [self previous: I].
    ^previo! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:03:49'!
previous: aPeano
	previo := aPeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:12:47'!
removeAllNext
	sucesor ifNotNil:
	[
		sucesor removeAllNext.
		sucesor removeFromSystem.
		sucesor := nil.
	]! !


!classDefinition: #III category: #'12-Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'12-Peano'!
III class
	instanceVariableNames: 'sucesor previo'!

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
* aPeano
    ^(self previous * aPeano) + aPeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
+ aPeano
    ^self previous + aPeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
- aPeano
	^aPeano invertedMinus: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
/ aPeano
    (self = aPeano) ifTrue: [^I].
    (self < aPeano) ifTrue: [self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)].
    ^((self - aPeano) / aPeano) + I.! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
< aPeano
	(aPeano = I) ifTrue: [^false].
	^self previous < aPeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No hay soporte para numeros negativos.'! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:34:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := IIII.
	previo := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
invertedMinus: aPeano
	"This function represents the operation aPeano - self"
	"aPeano has to be greater than I"
	^(aPeano previous) - (self previous).! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
next
	sucesor ifNil: [ sucesor := self cloneNamed: self name, 'I'.
		sucesor previous: self].
	^sucesor! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
previous
    previo ifNil: [self previous: I].
    ^previo! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
previous: aPeano
	previo := aPeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
removeAllNext
	sucesor ifNotNil:
	[
		sucesor removeAllNext.
		sucesor removeFromSystem.
		sucesor := nil.
	]! !


!classDefinition: #IIII category: #'12-Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'12-Peano'!
IIII class
	instanceVariableNames: 'sucesor previo'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
* aPeano
    ^(self previous * aPeano) + aPeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
+ aPeano
    ^self previous + aPeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
- aPeano
	^aPeano invertedMinus: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
/ aPeano
    (self = aPeano) ifTrue: [^I].
    (self < aPeano) ifTrue: [self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)].
    ^((self - aPeano) / aPeano) + I.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
< aPeano
	(aPeano = I) ifTrue: [^false].
	^self previous < aPeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No hay soporte para numeros negativos.'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:34:15'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := nil.
	previo := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
invertedMinus: aPeano
	"This function represents the operation aPeano - self"
	"aPeano has to be greater than I"
	^(aPeano previous) - (self previous).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:31'!
next
	sucesor ifNil: [ sucesor := self cloneNamed: self name, 'I'.
		sucesor previous: self].
	^sucesor! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:32'!
previous
    previo ifNil: [self previous: I].
    ^previo! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:32'!
previous: aPeano
	previo := aPeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 13:33:32'!
removeAllNext
	sucesor ifNotNil:
	[
		sucesor removeAllNext.
		sucesor removeFromSystem.
		sucesor := nil.
	]! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!