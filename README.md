vocab_quest
===========

A simple GRE vocabulary test to help me practice ruby

basic requirements:
	1. can load lists of words and definition from at least one text file
	2. can display run at least one type of word - definition matching game
	3. displays a main menu

advanced requirements: (maybe implement someday...)
	1. during game modes, can keep track of words that were missed and keep cycling those back in until they are successfully matched
	2. keeps a list (saves at exit) trouble words and frequently uses them in game until they are mastered
	3. allows user to banish certain words that they know completely
	4. user can select certain files to load or load them all for use in games
	5. main menu displays (filename of) currently loaded words
	6. auto loads last used groups of words
	7. score
	8. maybe 6, 7 could be a state model serialized with yaml?
	9. uses a more clever algorithm to select words for use than random, could get the same word every time
	10. same goes for populating random definitions
	11. maybe we should load all words into the missed list and take words from there until it is empty?