function merge(obj1, obj2) {
    let resultObj = {}

    let obj1Keys = Object.keys(obj1)
    let obj2Keys = Object.keys(obj2)

    for (let index = 0; index < obj1Keys.length; index++) {
        resultObj[obj1Keys[index]] = obj1[obj1Keys[index]]
    }
    for (let index = 0; index < obj2Keys.length; index++) {
        resultObj[obj2Keys[index]] = obj2[obj2Keys[index]]
    }

    return resultObj
}

function vpc({ subnets }) {

    let locals = {}

    locals.subnets = {}
    for (let index = 0; index < subnets.length; index++) {
        locals.subnets[subnets[i].name] = subnets[i]
    }

    locals.private_subnets = {}
    for (let index = 0; index < subnets.length; index++) {
        if (subnets[i].type == "private") {
            locals.subnets[subnets[i].name] = subnets[i]
        }
    }
    
    locals.public_subnets = {}
    for (let index = 0; index < subnets.length; index++) {
        if (subnets[i].type == "public") {
            locals.subnets[subnets[i].name] = subnets[i]
        }
    }

    // main logic ---

    return { outputs }
}


{
    first: {name: "first"}
    second: {name: "second"}
}
// for_each
{
    first: { id: 12 }
    second: { id: 123123 }
}


[ "first", "second" ]
// count
[ {id: 1}, {id: 2} ]