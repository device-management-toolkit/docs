
To use Webpack*, understand its Core Concepts:

- **Entry:** The entry point such as `/src/index.js`, which is the default for Webpack 4 is what Webpack will use to start building out/resolving its dependencies.

- **Output:** The output property, such as `./dist`, the default for Webpack 4, tells Webpack where to output the bundles it creates and how to name them.

- **Loaders:** Because Webpack only understands native Javascript code, these loaders enable Webpack to process different types of imported files and convert them into valid modules when it encounters a specific type of file. Loaders have two properties in the configuration file:
    - The test property identifies the file or files that should be transformed
    - The use property indicates the loader that can be used to do the transforming
- **Plugins:** The plugins enable the extension of Webpack capabilities to perform a wider range of tasks like bundle optimization, asset management, and injection of environment variables. 


## Install Webpack

Install both webpack and webpack cli as dev dependencies:

```
npm i webpack webpack-cli -D webpack-dev-server .
```


## Configure Webpack for the Development Environment

**To configure:**

1. Create a Webpack config file `webpack.config.dev.js` in the root of the project folder. 

2. Add the development environment to the  `webpack.config.dev.js` file:**

```javascript
const path = require('path');
module.exports = {
     mode: "development",
     entry: './src/reactjs/components/KVM/index.tsx', // entry points can be multiple

}
```

## Add Typescript
The example code below resolves the file extensions, .tsx, .ts and .js. Files with the extensions .tsx or .ts are processed by awesome-typescript-loader.

**To add Typescript support:**

1. Install the Typescript dependency, awesome-typescript-loader:

```
npm i awesome-typescript-loader -D
```
2. Add the configuration to the `webpack.config.dev.js` file:

Example: 
```javascript
const path = require('path');
module.exports = {
 ....
resolve: {
    extensions: [".tsx", ".ts", ".js"]
  },
  module: {
    rules: [
      { 
        test: /\.tsx?$/, 
        loader: 'awesome-typescript-loader'
      }
    ]
  }
}
```


## Add Styles

**To Add Styles support:**

1. Use npm to install css-loader and sass-loader:
```
npm i style-loader css-loader sass-loader -D
```
2. Add the configuration to the `webpack.config.dev.js` file:

```javascript
module.exports = {
 ....

  module: {
    rules: [
        ...
       {
        test: /\.(sc|sa|c)ss$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      }
    ]
  }
}
```

## Add HTML

**To add HTML support:**

1. Use the Webpack plugin html-webpack-plugin, which helps simplify the creation of HTML files to help serve our Webpack bundles:
```
npm i html-webpack-plugin -D.
```

2. Add the configuration to the `webpack.config.dev.js` file:

```javascript
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
 ....
  plugins: [
    new HtmlWebpackPlugin({
      filename: "kvm.htm",
      template: "./src/sample/sampleKVM.htm",
      inject: true,
      chunks: ["kvm"],
    }),
  ]
}
```

## Development Server

Set up a development server using the webpack-dev-server. This server opens a default browser upon npm start and provide us with live reloading.

```
npm i webpack-dev-server --D
```

## Update Package.json

Add webpack-dev-server to the `Package.json` file:

```javascript
"scripts": { 
  "start": "webpack-dev-server --config webpack.config.dev.js"
}
```

!!! Example
    Sample usage:

    1. Open command prompt.
    2. Run npm start command.


## Configure Webpack for Production Environment

**To add production environment support:**

1. Create a Webpack config file `webpack.config.prod.js` in the root of our project folder.

2. Add the configuration to the `webpack.config.prod.js` file: 

```javascript
const path = require('path');

module.exports = {
     mode: "production",
     entry: './src/reactjs/components/KVM/index.tsx', // entry points can be multiple
    output: {
        filename: "[name].min.js",
        path: path.resolve(__dirname, "./dist")
    },
  ....
}
```
3. Update Package.json:

   
```javascript
"scripts": { 
 "build": "webpack --config webpack.config.prod.js",
}
```

!!! Example
    Sample usage:

    1. Open command prompt.
    2. Run npm run build.


## Configure Webpack for External Environment
   
Create a Webpack config file `webpack.config.externals.js` in the root of our project folder.

**Add webpack-node-externals:**
 
1. Install webpack-node-externals dependencies:
```
 npm install webpack-node-externals -D
```
2. The webpack-node-externals library creates an externals function that ignores node_modules when bundling in Webpack. Add the following to `webpack.config.externals.js`:

```javascript
 const path = require("path"); //No ES6 in webpack config 
 const nodeExternals = require('webpack-node-externals');

module.exports = {
   ....
  externals: [nodeExternals()],
 
};
```
3. Update Package.json:

```javascript
"scripts": { 
 "build-ext": "webpack --config webpack.config.externals.js",
}
```

!!! Example
    Sample usage:

    1. Open command prompt.
    2. Run npm run build-ext command.


  
