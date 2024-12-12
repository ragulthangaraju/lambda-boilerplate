'use strict';
const path = require('path');
const WebpackZipPlugin = require('zip-webpack-plugin');

module.exports = {
    mode: 'production',
    entry: './handler.js',
    target: 'node',
    plugins: [
        new WebpackZipPlugin({
            filename: 'lambda.zip',
        }),
    ],
    output: {
        path: path.resolve(__dirname, 'target/'),
        filename: 'index.js',
        clean: true,
        libraryTarget: 'commonjs',
    },
    externals: {
        'aws-sdk': 'aws-sdk',
    },
};
