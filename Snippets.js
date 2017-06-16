// Impure functions
var name = "Bob";

function getName () {
    return name;
}

// Currying functions
function add (a) {
    return function (b) {
        return a + b;
    }
}

const add = a => b => a + b

add(1)(2)

// Chaining functions
const person = {
    name: 'Gabriel',
    age: 28,
    weight: 75
}

const incrementAge = person => ({ 
    …person , age: person.age + 1 
})

const incrementWeight = person => ({ 
    …person , weight: person.weight + 1 
})

incrementAge( incrementWeight( person ) )

// Mutability
var arr = [0, 1, 2]

arr.push(3) // 4

arr // [0, 1, 2, 3]

arr === [0, 1, 2, 3] // false

[0, 1, 2, 3] === [0, 1, 2, 3] //false


// Dynamic types
[] + [] // ""
[] - [] // 0

[] + {} // "[object Object]"
{} + [] // 0

[] == [] // false
[] == ![] // false

// Undefined is not a function
function foo(num) {
    if (num > 10) {
        return "Bigger than ten"
    }
}

foo(11).toUpperCase() // "BIGGER THAN TEN"

foo(1).toUpperCase() // Error

// Modules
// CommonJS
var $ = require('jquery');

// AMD
define(['jquery'] , function ($) {
   return function () {};
});

// UMD = CommonJS + AMD

// ES Modules
import $ jquery from 'jquery'
import {something} from './myModule'

// Side effects
const getRandomGif = topic => dispatch => {
   const url = 'someEndpoint/'
   return fetch(url + topic)
       .then(response => dispatch(newGiftAction())
       .catch(response => dispatch(newGiftError())
}