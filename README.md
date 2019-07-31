# Zombie Survival Network

## Endpoints

* /survivors(GET): Return all the survivors.

* /survivors(POST): Create a new survivor, expect the parameters of the object survivor, `:name, :age, :gender, :latitude, :longitude` and the parameters of the object inventory `:water, :food, :medication, :ammunition` are filled, also return the new survivor.

* /trade(GET): Expects the id of the two survivors (`:survivor_1 e :survivor_2`) that will perform the exchange and return the objects inself.

* /trade(POST): Expects the id of the two survivors (`:survivor_1 e :survivor_2`) that will perform the exchange and the parameters `:itens1_ids and :itens2_ids` that are arrays compound by the value of each item of the inventory of the respective survivor, for example:
  The inventory object is compound by four fields beyond the survivor reference, these are:  
    water, food, medication, ammunition  
  Then the parameter sended to controller must be compounded by a array of four integers values:  
    [val1, val2, val3, val4]
