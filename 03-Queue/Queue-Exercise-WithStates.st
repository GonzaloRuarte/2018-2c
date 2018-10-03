!classDefinition: #QueueTest category: #'Queue-Exercise-WithStates'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise-WithStates'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #Container category: #'Queue-Exercise-WithStates'!
Object subclass: #Container
	instanceVariableNames: 'queue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise-WithStates'!

!Container methodsFor: 'operations' stamp: 'GR 10/2/2018 00:47:04'!
addLast: aThing

	self subclassResponsibility.! !

!Container methodsFor: 'operations' stamp: 'GR 10/2/2018 00:46:14'!
first
	
	self subclassResponsibility! !

!Container methodsFor: 'operations' stamp: 'GR 10/2/2018 00:46:43'!
removeFirst

	self subclassResponsibility! !

!Container methodsFor: 'operations' stamp: 'GR 10/2/2018 00:14:03'!
size
	self subclassResponsibility! !


!Container methodsFor: 'testing' stamp: 'GR 10/2/2018 00:12:40'!
belongsToQueue: aQueue
	queue := aQueue! !

!Container methodsFor: 'testing' stamp: 'GR 10/2/2018 00:16:41'!
isEmpty

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Container class' category: #'Queue-Exercise-WithStates'!
Container class
	instanceVariableNames: ''!

!Container class methodsFor: 'instance creation' stamp: 'GR 10/2/2018 23:11:33'!
with: aCollection

	|distincionDeContainer|

	distincionDeContainer:=self subclasses detect:[:subclass | subclass isFor: (aCollection size)].
	
	^distincionDeContainer basicNew initializeWith: aCollection! !


!classDefinition: #EmptyContainer category: #'Queue-Exercise-WithStates'!
Container subclass: #EmptyContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise-WithStates'!

!EmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 23:10:36'!
addLast: aThing
	
	|aContainer|
	
	aContainer := NonEmptyContainer basicNew initializeWith: (OrderedCollection with: aThing).
	queue hasTheContainer: aContainer.
	aContainer belongsToQueue: queue.	
	
	^aThing! !

!EmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 00:47:22'!
first
	
	self error: Queue queueEmptyErrorDescription! !

!EmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 00:46:43'!
removeFirst

	self error: Queue queueEmptyErrorDescription! !

!EmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 00:14:19'!
size
	^0! !


!EmptyContainer methodsFor: 'testing' stamp: 'GR 10/2/2018 00:16:19'!
isEmpty

	^true! !


!EmptyContainer methodsFor: 'initialization' stamp: 'GR 10/2/2018 23:10:50'!
initializeWith: aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyContainer class' category: #'Queue-Exercise-WithStates'!
EmptyContainer class
	instanceVariableNames: ''!

!EmptyContainer class methodsFor: 'instance creation' stamp: 'GR 10/2/2018 01:09:25'!
isFor: aValue
	^aValue  = 1! !


!classDefinition: #NonEmptyContainer category: #'Queue-Exercise-WithStates'!
Container subclass: #NonEmptyContainer
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise-WithStates'!

!NonEmptyContainer methodsFor: 'initialization' stamp: 'GR 10/2/2018 23:11:23'!
initializeWith: aValue

	elements := aValue.! !


!NonEmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 00:47:04'!
addLast: aThing
	^elements addLast: aThing.! !

!NonEmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 00:47:35'!
first
	
	^elements first! !

!NonEmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 01:13:22'!
removeFirst
	|aContainer|
		aContainer := Container with: elements.
		queue hasTheContainer: aContainer.
	aContainer belongsToQueue: queue.
	^elements removeFirst! !

!NonEmptyContainer methodsFor: 'operations' stamp: 'GR 10/2/2018 00:14:45'!
size
	^elements size! !


!NonEmptyContainer methodsFor: 'testing' stamp: 'GR 10/2/2018 00:16:29'!
isEmpty

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyContainer class' category: #'Queue-Exercise-WithStates'!
NonEmptyContainer class
	instanceVariableNames: ''!

!NonEmptyContainer class methodsFor: 'instance creation' stamp: 'GR 10/2/2018 01:09:19'!
isFor: aValue
	^aValue  > 1! !


!classDefinition: #Queue category: #'Queue-Exercise-WithStates'!
Object subclass: #Queue
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise-WithStates'!

!Queue methodsFor: 'initialization' stamp: 'GR 10/2/2018 00:12:01'!
initialize
	contents := EmptyContainer new.
	contents belongsToQueue: self.! !


!Queue methodsFor: 'operations' stamp: 'GR 10/2/2018 00:45:33'!
dequeue

	^contents removeFirst! !

!Queue methodsFor: 'operations' stamp: 'GR 10/2/2018 00:45:49'!
enqueue: aThing
	^contents addLast: aThing.! !

!Queue methodsFor: 'operations' stamp: 'GR 10/2/2018 00:47:55'!
next
	
	^contents first.! !

!Queue methodsFor: 'operations' stamp: 'GR 9/28/2018 15:09:14'!
size
	^contents size! !


!Queue methodsFor: 'testing' stamp: 'GR 10/2/2018 00:21:33'!
hasTheContainer: aContainer

	contents := aContainer! !

!Queue methodsFor: 'testing' stamp: 'GR 9/28/2018 15:46:10'!
isEmpty
	^contents isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise-WithStates'!
Queue class
	instanceVariableNames: 'contents'!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !
