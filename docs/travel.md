# Travel Notes
## Some thoughts on how people might move 

* Entities represent individuals or groups
* For each Tick, entity.movement executes a .move
  - .move uses entity.speed to update position
    - start with straight line calculations
    - later factor in terrain as speed modifier (road faster than field, field faster than forest, etc.)
    - later factor in geography as route modifier (are there impassable rivers, mountains, etc?)
  - after each .move, someone (map?) checks to see which entities are within interaction distance and resolves possible interactions (trades, attacks, information or member exchanges, etc.)

## Possible relationships:
* class: Position
 - attrs: coordinates
 - methods: site (if any)
 - has_one: map

* module: Travel
  * class: Movement
    - attrs: origin, destination, entity
    - belongs_to: entity
    - has_one: position through: entity
    - includes: geography
    - methods: move, complete?

* class: Entity
 - attrs: speed
 - has_one: position
 - has_many: movements
 - includes: travel

## Issues
* How do moving entities interact? If only when sharing same position (or radius around positions), then Tick length effects probability of entities interacting during movement. 
  - e.g. If `Tick == 1.day`, and two entities are making the same movement in opposite directions, and the movement takes less than one day, we only resolve interactions at the end of the tick, so these entities that should have passed on the road do not interact.  


