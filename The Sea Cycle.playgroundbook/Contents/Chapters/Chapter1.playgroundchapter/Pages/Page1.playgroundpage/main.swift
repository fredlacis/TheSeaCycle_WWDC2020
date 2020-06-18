//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
import PlaygroundSupport


let Glitter =       0
let Soap =          1
let CottonSwabs =   2
let Makeup =        3
let Moisturizer =   4
let Deodorant =     5
let ShowerGel =     6
let Sunscreen =     7
let BabyPowder =    8
let FaceScrubs =    9
let Toothpaste =    10
let BodyScrubs =    11


var shoppingCart : [Int] = []

//#-end-hidden-code
/*:
 # Welcome to the Drugstore 💊

 Here is were you can get all of your everyday self-care products.
 But most of the times we don't actually know what is inside them,
 before choosing what you will get, **try clicking some products to
 learn a bit more about them**.

   * Callout(Microplastics 📌):
   This are very small pieces of plastic, witch are very harmfull
   to the enviroment. Most microplastics are fragments of bigger plastic
   stuff, like packages. **Microbeads**, in the other hand, are a type of plastic
   especifically made to be small, and are very common on self-care
   products arround the world.
 
 - Important:
 Put the items that you want inside the shoppingCart array bellow,
 remember to separate them using "**,**".
 */
 //#-code-completion(everything, hide)
 //#-code-completion(identifier, show, Glitter, Soap, CottonSwabs, Makeup, Moisturizer, Deodorant, ShowerGel, Sunscreen, BabyPowder, FaceScrubs, Toothpaste, BodyScrubs)
 shoppingCart = [/*#-editable-code What will you get?*//*#-end-editable-code*/]
/*:
Now that your shoppingCart is full of AMAZING products, you can **run the code** and take it all home.
*/

//#-hidden-code
if let proxy = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy {
    //let dict = PlaygroundValue.dictionary(["grey" : PlaygroundValue.floatingPoint(grey)])
    
    var shoppingCartPV : [PlaygroundValue] = []
    for i in shoppingCart {
        shoppingCartPV.append(PlaygroundValue.integer(i))
    }
    let array = PlaygroundValue.array(shoppingCartPV)
    proxy.send(array)
}
//#-end-hidden-code

