babel = require 'babel-core'
babelExtensions = /.*\.(es6|es|jsx|js6|js)$/            # RexExp for all ES6 file extensions

module.exports = [                                      # This ResourceConverter is using an [] instead of {}.
                                                        # Key names of RC are assumed from their posision in the array:

    '$babeljs'                                          # `name` & flags as a String at pos 0

    "babeljs transformer, defaults to `presets: ['es2015']`." # `descr` at pos 1

    [ babelExtensions ]                                 # `filez` [] at pos 2

    (modyle)->                                          # `convert` Function at pos 3
      babel.transform(modyle.converted, @options).code
        .replace('"use strict";', '')                   # babel adds 'use strict' outside the function wrapper,
        .replace("'use strict';", '')                   # which breaks the AMD recognition - it can always be added later while building

    (srcFilename)->                                     # `convFilename` Function at pos 4
      ext = srcFilename.replace babelExtensions, "$1"   # retrieve matched extension
      srcFilename.replace (new RegExp ext + '$'), 'js'  # replace it and return new filename

    presets: ['es2015']                                 # the default options object. If convFilename is absent, it can take its place.
  ]
