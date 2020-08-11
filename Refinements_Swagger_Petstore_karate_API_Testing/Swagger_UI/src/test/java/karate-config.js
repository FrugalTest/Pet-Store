function fn(){
    var response1 = karate.callSingle('classpath:Addpet.feature');
    var orderid=karate.callSingle('classpath:random.js');
    var petid = response1.response.category.id;
    var id={
        petid: petid,
        orderid:orderid
    }
    return id;
}