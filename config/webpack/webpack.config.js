const path    = require("path")
const webpack = require("webpack")

const mode = process.env.NODE_ENV ? "development" : process.env.NODE_ENV;

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const RemoveEmptyScriptsPlugin = require('webpack-remove-empty-scripts');

module.exports = {
  mode,
  devtool: "source-map",
  entry: {
    application: [
      "./app/assets/javascripts/application.js",
      "./app/assets/stylesheets/application.scss"
    ]
  },
  module: {
    rules: [
      {
        test: /\.(?:sa|sc|c)ss$/i,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      },
      {
        test: /\.(png|jpe?g|gif|eot|woff2|woff|ttf|svg)$/i,
        use: 'file-loader',
      }
    ],
  },
  resolve: {
    extensions: ['.js', '.scss', '.css'],
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "..", "..", "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    }),
    new RemoveEmptyScriptsPlugin(),
    new MiniCssExtractPlugin(),
  ]
}
