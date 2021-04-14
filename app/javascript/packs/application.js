// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import pell from 'pell'
import * as ActiveStorage from "@rails/activestorage"
// import 'bootstrap/js/src/alert'
// import 'bootstrap/js/src/button'
// import 'bootstrap/js/src/carousel'
import 'bootstrap/js/src/collapse'
import 'bootstrap/js/src/dropdown'
// import 'bootstrap/js/src/modal'
// import 'bootstrap/js/src/popover'
import 'bootstrap/js/src/scrollspy'
// import 'bootstrap/js/src/tab'
// import 'bootstrap/js/src/toast'
// import 'bootstrap/js/src/tooltip'
//import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
/*
document.addEventListener("turbolinks:load", function() {
    let editor = document.getElementById("editor");
    let markup = document.getElementById("description_output");
    pell.init({
        element: editor,
        actions: ['bold', 'italic', 'underline', 'olist', 'ulist'],
        onChange: (html) => {
            console.log(html)
            markup.value = html
        }
    })
})
*/


