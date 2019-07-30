# Zombie Survival Network

## Endpoints

* /survivors(GET): Return a object of all the survivors.

* /survivors(POST): Create a new survivor, expect the parameters of the object survivor, :name, :age, :gender, :latitude, :longitude and the parameters of the object inventory :water, :food, :medication, :ammunition are filled.

* /trade(GET): Expects the id of the two survivor objects (:survivor_1 e :survivor_2) that will perform the exchange and return the objects inself.

* /trade(POST): Expects the id of the two survivor objects (:survivor_1 e :survivor_2) of the two survivor objects and the :itens1_ids, :itens2_ids that are arrays of the respective survivor object inventory that were selected to be exchange between the survivors.
