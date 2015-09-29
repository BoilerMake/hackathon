module.exports = {
  entry: './lib/sponsors/index.js',
  output: {
    path: './public/sponsors',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel'
      }
    ]
  }
};
