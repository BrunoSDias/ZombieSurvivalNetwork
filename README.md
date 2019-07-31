# Zombie Survival Social Network

Tests made with the own minitest from rails on `survivors` and `trade` controllers, just run `rake test` to use them.

## Endpoints

* **/survivors** (GET): Return all the survivors.

* **/survivors** (POST): Create a new survivor, expect the parameters of the object survivor, `:name, :age, :gender, :latitude, :longitude` and the parameters of the object inventory `:water, :food, :medication, :ammunition`, also return the new survivor.

* **/trade** (GET): Expects the id of the two survivors (`:survivor_1 e :survivor_2`) that will perform the exchange and return the objects inself.

* **/trade** (POST): Expects the id of the two survivors (`:survivor_1 e :survivor_2`) that will perform the exchange and the parameters `:itens1_values and :itens2_values` that are arrays compounded by how much of each item of the inventory of the respective survivor will be exchanged, for example:
  - The inventory object is compound by four fields beyond the survivor reference, these are:  
      &nbsp;&nbsp;**water, food, medication, ammunition**  
  - Then the parameter sended to controller must be compounded by a array of four integers values:  
      &nbsp;&nbsp;**[val1, val2, val3, val4]**  
  - Each value represents the field in the above order and will be exchanged to the another survivor when the action is complete.  
    Another detail is, to the exchange be well succeded, the points that each field represents must be the same:  

    | Item         | Points   |
    |:------------:|:--------:|
    | 1 Water      | 4 points |
    | 1 Food       | 3 points |
    | 1 Medication | 2 points |
    | 1 Ammunition | 1 point  |  

    So, for example, if the first survivor try to exchange 2 waters with 2 foods and 1 medication from the second, it will work, because (2x4 = 2x3+2)

* **/report** (GET): Expects the id of a survivor (`:id`) with the goal of report this survivor as contaminated, after the same survivor be reported at least three times, the survivor is flagged as infected and none of it itens is acessible anymore.

* **/survivors_info** (GET): Return some info about the situation of the survivors, these are:
    1. Percentage of infected survivors.
    2. Percentage of non-infected survivors.
    3. Average amount of each kind of resource by survivor
    4. Points lost because of infected survivor.

