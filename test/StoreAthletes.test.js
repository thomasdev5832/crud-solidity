const StoreAthletes = artifacts.require("StoreAthletes");

contract('StoreAthletes', function(accounts){
    beforeEach(async () => {
        contract = await StoreAthletes.new();
        
    })

    it('Add Athlete', async () => {
        await contract.addAthlete({
            name: 'Thomas',
            age: 33,
            height: 173,
            weight: 62
        })
        const count = await contract.count();
        assert(count.toNumber() === 1, "Couldn't add athlete!");
    })

    it('Get Athlete', async () => {
        await contract.addAthlete({
            name: 'Thomas',
            age: 33,
            height: 173,
            weight: 62
        })
        const athlete = await contract.getAthlete(1);
        //console.log(athlete);
        assert(athlete.name === "Thomas", "Couldn't get the athlete!");
    })

    it('Edit Athlete', async () => {
        await contract.addAthlete({
            name: 'Thomas',
            age: 33,
            height: 173,
            weight: 62
        })
        await contract.editAthlete(1, {
            name: 'Gabriel',
            age: 34,
            height: 174,
            weight: 65
        });
        const athlete = await contract.getAthlete(1);
        //console.log(athlete);
        assert(athlete.name === "Gabriel" && athlete.age == 34 && athlete.height == 174 && athlete.weight == 65 , "Couldn't edit the athlete!");
    })

    it('Remove Athlete', async () => {
        await contract.addAthlete({
            name: 'Thomas',
            age: 33,
            height: 173,
            weight: 62
        })

        await contract.removeAthlete(1, {from: accounts[0]});

        const count = await contract.count();
        assert(count.toNumber() === 0, "Couldn't remove athlete!");
    })

})