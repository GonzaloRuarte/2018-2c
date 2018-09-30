!classDefinition: #QueueTest category: #'Queue-ExerciseWithPolimorfismo'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithPolimorfismo'!

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

!QueueTest methodsFor: 'test' stamp: 'ap 9/30/2018 16:47:17'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #BasicQueueElement category: #'Queue-ExerciseWithPolimorfismo'!
Object subclass: #BasicQueueElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithPolimorfismo'!

!BasicQueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 14:17:12'!
value

	self subclassResponsibility ! !


!classDefinition: #NullQueueElement category: #'Queue-ExerciseWithPolimorfismo'!
BasicQueueElement subclass: #NullQueueElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithPolimorfismo'!

!NullQueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 14:18:00'!
value

	self error: Queue queueEmptyErrorDescription! !


!classDefinition: #QueueElement category: #'Queue-ExerciseWithPolimorfismo'!
BasicQueueElement subclass: #QueueElement
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithPolimorfismo'!


!QueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 14:11:07'!
initializeWith: aValue

	value:=aValue! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 14:23:18'!
initializeWith: aValue before: aQueueElement

	value:=aValue.
	next:=aQueueElement! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 16:42:27'!
next

	^next! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 16:36:22'!
next: aQueueElement

	next:=aQueueElement! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 14:16:02'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'QueueElement class' category: #'Queue-ExerciseWithPolimorfismo'!
QueueElement class
	instanceVariableNames: ''!

!QueueElement class methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 16:33:04'!
initializeWith: aThing before: aQueueElement

	^ self new initializeWith: aThing before: aQueueElement.! !

!QueueElement class methodsFor: 'as yet unclassified' stamp: 'ap 9/30/2018 14:12:19'!
with: aValue

	^ QueueElement new initializeWith:  aValue! !


!classDefinition: #Queue category: #'Queue-ExerciseWithPolimorfismo'!
Object subclass: #Queue
	instanceVariableNames: 'firstElement lastElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithPolimorfismo'!

!Queue methodsFor: 'initialization' stamp: 'ap 9/30/2018 14:15:04'!
initialize

	size:=0.
	firstElement := NullQueueElement new.! !


!Queue methodsFor: 'operations' stamp: 'ap 9/30/2018 16:30:06'!
dequeue

	|firstElementNodeValue|
	
	firstElementNodeValue:=firstElement value.
	firstElement:=firstElement next.
	
	 size:=size-1.

	^firstElementNodeValue ! !

!Queue methodsFor: 'operations' stamp: 'ap 9/30/2018 16:46:31'!
enqueue: aThing

	|nullElement newQueueElement|
	nullElement:= NullQueueElement new.
	newQueueElement:=QueueElement initializeWith: aThing before:nullElement.
	self isEmpty
		ifTrue: [firstElement _ newQueueElement ]
		ifFalse: [lastElement next: newQueueElement].
	lastElement _ newQueueElement.
	size:=size+1.
	^aThing! !

!Queue methodsFor: 'operations' stamp: 'ap 9/30/2018 14:19:37'!
next
	
	|valueOfElement|
	
	valueOfElement:= firstElement  value.
	^valueOfElement! !

!Queue methodsFor: 'operations' stamp: 'ap 9/30/2018 14:14:51'!
size

	^size! !


!Queue methodsFor: 'testing' stamp: 'ap 9/30/2018 16:41:01'!
isEmpty

	^firstElement isKindOf: NullQueueElement ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-ExerciseWithPolimorfismo'!
Queue class
	instanceVariableNames: 'contents'!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !
