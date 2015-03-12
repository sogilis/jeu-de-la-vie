Règles
======

En préambule, il faut préciser que le jeu de la vie n’est pas vraiment un jeu au sens ludique, puisqu’il ne nécessite aucun joueur ; il s’agit d’un automate cellulaire, un modèle où chaque état conduit mécaniquement à l’état suivant à partir de règles pré-établies.

Le jeu se déroule sur une grille à deux dimensions, théoriquement infinie (mais de longueur et de largeur finies et plus ou moins grandes dans la pratique), dont les cases — qu’on appelle des « cellules », par analogie avec les cellules vivantes — peuvent prendre deux états distincts : « vivantes » ou « mortes ».

À chaque étape, l’évolution d’une cellule est entièrement déterminée par l’état de ses huit voisines de la façon suivante :

  * Une cellule morte possédant exactement trois voisines vivantes devient vivante (elle naît).
  * Une cellule vivante possédant deux ou trois voisines vivantes le reste, sinon elle meurt.

Ainsi, la configuration

    ░░░░░░
    ██████
    ░░░░░░

donne au tour suivant la configuration

    ░░██░░
    ░░██░░
    ░░██░░

qui redonne ensuite la première.

On peut également formuler cette évolution ainsi :

  * Si une cellule a exactement trois voisines vivantes, elle est vivante à l’étape suivante.

        ██░░░░   ██░░░░
        ██░░██ → ██████
        ░░░░░░   ░░░░░░

  * Si une cellule a exactement deux voisines vivantes, elle reste dans son état actuel à l’étape suivante. Dans la configuration suivante, la cellule située entre les deux cellules vivantes reste morte à l’étape suivante.

        ░░░░░░   ░░░░░░
        ██░░██ → ██░░██
        ░░░░░░   ░░░░░░

  * Si une cellule a strictement moins de deux ou strictement plus de trois voisines vivantes, elle est morte à l’étape suivante. C’est le cas de la cellule rouge dans la configuration de gauche.

        ██████   ██████
        ████░░ → ██░░░░
        ░░░░░░   ░░░░░░

Si l'on considère la somme de ses côtés S et E l'état initial de la cellule, il est possible de calculer sont état suivant avec: (S = 3) OU (E = 1 ET S = 2). Avec 1 pour une cellule vivante et 0 pour une cellule morte.
