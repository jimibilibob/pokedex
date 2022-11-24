# The Pokedex App
Hi there, Welcome to the world of Pokémon ! My name is Oak, peoplecall me the Pokémon Prof. This world is inhabited by creatures calledPokémon. For some people Pokémon are pets, other use them forfights, myself... I study Pokémon as a profession.
For many years trainers around the world have worked together tocollect data about Pokémon and created thePokéapiI heard you are adeveloper and I would like you to help us creating a Pokédex app. I’llspecify all the requirements for the new Pokédex as a set ofchallenges I’m sure you will be able to overcome. Why challenges doyou ask? well that’s what professors do.If you have any questions, feel free to leave a comment.

## Installation
To install the application you need to install the dependencies by executing in the root directory of the project

> `pod install`

Then your able to run the application into an iOS device.
## Prehooks Setup

At first is necessary to make these files executables, so open a terminal and move to the hook folder and run:
> `chmod +x install-hooks.bash pre-commit.bash`

Finally once we run the above command we need to run the _install-hooks.bash_ script which will generate a linked file in the  _.git/hooks_ folder called _pre-commit_ which will point to _pre-commit.bash_, so if we need to change the _pre-commit_ script we just need to modify _pre-commit.bash_ file.