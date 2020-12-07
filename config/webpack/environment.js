const { environment } = require('@rails/webpacker')


// added for bootstrap-js to work (Jquery & Popper): 
const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))
// end of bootstrap-js installation

module.exports = environment
