:- use_module(library(lambda)).

%list of moves, ensure it move the same way in both directions
move(F,1,T):- member([F,T], [[0,3], [3,0]]).
move(F,2,T):- member([F,T], [[0,5], [5,0]]).
move(F,3,T):- member([F,T], [[1,6], [6,1]]).
move(F,4,T):- member([F,T], [[1,8], [8,1]]).
move(F,4,T):- member([F,T], [[2,7], [7,2]]).
move(F,5,T):- member([F,T], [[2,9], [9,2]]).
move(F,6,T):- member([F,T], [[3,10], [10,3]]).
move(F,7,T):- member([F,T], [[3,12], [12,3]]).
move(F,7,T):- member([F,T], [[4,11], [11,4]]).
move(F,8,T):- member([F,T], [[4,13], [13,4]]).
move(F,8,T):- member([F,T], [[5,12], [12,5]]).
move(F,9,T):- member([F,T], [[5,14], [14,5]]).
move(F,4,T):- member([F,T], [[3,5], [5,3]]).
move(F,7,T):- member([F,T], [[6,8], [8,6]]).
move(F,8,T):- member([F,T], [[7,9], [9,7]]).
move(F,11,T):- member([F,T], [[10,12], [12,10]]).
move(F,12,T):- member([F,T], [[11,13], [13,11]]).
move(F,13,T):- member([F,T], [[12,14], [14,12]]).

%visualizes a solution for each first 5 positions others look the same after 120 degrees rotations
go:- go(Moves), show(Moves).

go(Moves):- replay([0], [1,2,3,4,5,6,7,8,9,10,11,12,13,14], [], Moves).

%replay a sequence of moves, showing the state of cells  
replay(_, [_], Terse, Moves):- reverse(Terse, Moves).
 
replay(None, Xs, Terse, Moves) :-
	select(F, Xs, Y), select(O, Y, Ys), select(T, None, F1),
	move(F, O, T), replay([F, O | F1], [T | Ys], [move(F,O,T) | Terse], Moves).

%shows the result by printing out successive states
show(Ms):- show(Ms, [0]).
 
show([], None) :-
	numlist(0,14, Terse),
	maplist(\X^M^(member(X, None) -> M = '.'; M = 'x'),Terse,
		[M0,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14]),
	format('    ~w        ~n', [M0]), format('   ~w ~w      ~n', [M1,M2]), format('  ~w ~w ~w    ~n', [M3,M4,M5]), format(' ~w ~w ~w ~w  ~n', [M6,M7,M8,M9]), format('~w ~w ~w ~w ~w~n', [M10,M11,M12,M13,M14]).
 
show([move(Begin, Middle, End) | Tail], None) :-
	numlist(0,14, Terse),
	maplist(\X^M^(member(X, None) -> M = '.'; M = 'x'),Terse,
		[M0,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14]), format('    ~w        ~n', [M0]), format('   ~w ~w      ~n', [M1,M2]), format('  ~w ~w ~w    ~n', [M3,M4,M5]), format(' ~w ~w ~w ~w  ~n', [M6,M7,M8,M9]), format('~w ~w ~w ~w ~w~n', [M10,M11,M12,M13,M14]),
	select(End, None, F1),
	show(Tail,  [Begin, Middle | F1]).
