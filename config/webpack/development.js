process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

//const webpack = require('webpack')
//environment.plugins.preped('Provide',
//  new webpack.ProvidePlugin({
//    $: 'jquery/src/jquery',
//    jQuery: 'jquery/src/jquery'
//  })
//  )