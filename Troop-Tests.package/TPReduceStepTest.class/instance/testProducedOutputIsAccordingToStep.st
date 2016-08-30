tests
testProducedOutputIsAccordingToStep

	| step execution |
	step := TPMergeStep new.
	step merger: [ :a :e | a + e ].
	step start.

	execution := TPJobExecution new.
	execution pushContext: (TPPartitionContext new partitions: 3).
	step inputQueue nextPut: { 1 . execution }.
	step inputQueue nextPut: { 4 . execution }.
	step inputQueue nextPut: { 27 . execution }.
	100 milliSeconds wait.

	self deny: step outputQueue isEmpty.
	self assert: step outputQueue next first equals: 32