module.exports = {
  entry: './src/coffee/index.coffee',
  output: {
    path: './dist',
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['', '.coffee', '.js', '.sass', 'scss', '.css']
  },
  module: {
    loaders: [
      {
        test: /\.coffee$/,
        loaders: ['coffee']
      },
      {
        test: /\.(sass|scss)$/,
        loaders: ['style', 'css', 'sass']
      },
      {
        test: /\.css$/,
        loaders: ['style', 'css']
      },
      {
        test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf)$/,
        loaders: ['url']
      }
    ]
  }
}
