const path = require('path');

module.exports = {
  mode: 'development',
  entry: './app.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  resolve: {
    extensions: ['.js', '.json'],
  },
  devtool: 'source-map',
  performance: {
    maxEntrypointSize: 512000,
    maxAssetSize: 512000,
  },
};
