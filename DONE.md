# Definition of done

What must be true for each model, one sentence per line, under its heading. Plain English,
no Ruby. Write the rules, not the columns: what can't be allowed, what can't be duplicated,
what must you be able to find? Every story in the README should be something these
sentences make true.

This file is yours. Your agent reads it and writes one test for each sentence, named with that
sentence. It doesn't write here. Whether every sentence got its test is yours to check.

## Studio
A studio cannot be saved without a name.
Two studios cannot have the same name.
I must be able to find all movies made by a studio.
## Movie
A movie cannot be saved without a title.
A movie cannot be saved without a release year.
A movie cannot be saved without a rating.
A movie must be linked to an existing studio.
Two movies cannot have the same title and release year.
I must be able to find a movie's studio.
I must be able to find every cast member's name and the character they play in a movie.
A movie cannot be saved without a director.
Given a movie, I can find the name of its director.
## Actor
An actor cannot be saved without a name.
Two actors cannot have the same name.
I must be able to find every movie an actor appears in.
## Role
A role must be linked to an existing movie.
A role must be linked to an existing actor.
A role cannot be saved without a character name.
Two roles cannot have the same movie, actor, and character name.
I must be able to find a role's actor.
I must be able to find a role's movie.