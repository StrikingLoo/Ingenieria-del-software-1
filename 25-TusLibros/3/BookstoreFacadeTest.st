'From Cuis 5.0 [latest update: #3958] on 14 November 2019 at 9:33:37 pm'!
!classDefinition: #BookstoreFacadeTest category: #TusLibros!
TestCase subclass: #BookstoreFacadeTest
	instanceVariableNames: 'exampleCatalog factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!BookstoreFacadeTest commentStamp: '<historical>' prior: 0!
Puede un usuario tener mas de un carrito simultaneamente?  No!! Por suerte, deberiamos modelar cada carrito asociado a un solo usuario, mappeado por el orquestador.
Deberia el carrito conocer su ID y su usuario? No!! El orquestador conoce ambas propiedades del carrito y es el que se encarga de manejar tales interacciones.!


!BookstoreFacadeTest methodsFor: 'initialization' stamp: 'C. L. 11/14/2019 18:17:56'!
initialize
	factory := StoreTestObjectsFactory new.! !


!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 21:18:23'!
test01CreatingACartForANonExistingUserFails
	| bookstore aUserId aPassword |
	bookstore := factory defaultBookstoreFacade.
	aUserId := 1234.
	aPassword := 'cambiame'.
	
	self should: [bookstore createCartFor: aUserId withPassword: aPassword]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade nonExistentUserErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 21:18:32'!
test02CreatingACartForAUserWithAWrongPasswordFails
	| bookstore aUserId aWrongPassword |
	bookstore := factory defaultBookstoreFacade.
	aUserId := factory aValidUser .
	aWrongPassword := 'cambiame'.
	
	self should: [bookstore createCartFor: aUserId withPassword: aWrongPassword]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade wrongPasswordErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 20:46:09'!
test03ListingANonExistingCartRaisesAnError
	| bookstore aCartId |
	bookstore := factory defaultBookstoreFacade.
	aCartId := 1234.
	
	self should: [bookstore listCart: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade nonExistentCartErrorDescription).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 21:04:24'!
test04ListingAnExistingCartWithoutBooksIsEmpty
	| bookstore aCartId |
	bookstore := factory defaultBookstoreFacade.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidUserPassword).
	self assert: (bookstore listCart: aCartId) isEmpty.! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 20:57:13'!
test05ListingAnExistingCartWithABookShowsTheBook
	| bookstore aCartId |
	bookstore := factory defaultBookstoreFacade.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidUserPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	
	self assert: ((bookstore listCart: aCartId) includes: (factory itemSellByTheStore)).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 21:07:30'!
test06AddingABookToACartOnlyAffectsSaidCart
	| bookstore aCartIdWithBooks aCartIdWithoutBooks |
	bookstore := factory defaultBookstoreFacade.
	
	aCartIdWithBooks := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidUserPassword).
	aCartIdWithoutBooks := bookstore createCartFor: (factory anotherValidUser) withPassword: (factory anotherValidUserPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartIdWithBooks.
	
	self assert: ((bookstore listCart: aCartIdWithBooks) includes: (factory itemSellByTheStore)).
	self deny: ((bookstore listCart: aCartIdWithoutBooks) includes: (factory itemSellByTheStore)).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/14/2019 21:25:10'!
test07AddingABookThatIsNotInTheCatalogFails
	| bookstore aCartId |
	bookstore := factory defaultBookstoreFacade.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidUserPassword).
	self should: [bookstore add: 1 of: (factory itemNotSellByTheStore) to: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: ((Cart new) invalidItemErrorMessage).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreFacadeTest class' category: #TusLibros!
BookstoreFacadeTest class
	instanceVariableNames: 'factory'!
