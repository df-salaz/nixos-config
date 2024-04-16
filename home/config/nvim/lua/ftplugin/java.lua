-- jdtls
local config = {
    cmd = { '/usr/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1]),
    settings = {
        java = {
            format = {
                settings = {
                    url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-1.8',
                        path = '/usr/lib/jvm/java-8-openjdk/',
                        javadoc = 'https://docs.oracle.com/en/java/javase/8/docs/api'
                    },
                    {
                        name = 'JavaSE-11',
                        path = '/usr/lib/jvm/java-11-openjdk/',
                        javadoc = 'https://docs.oracle.com/en/java/javase/11/docs/api'
                    },
                    {
                        name = 'JavaSE-17',
                        path = '/usr/lib/jvm/java-17-openjdk/',
                        javadoc = 'https://docs.oracle.com/en/java/javase/17/docs/api',
                        default = true
                    }
                }
            }
        }
    }
}
require('jdtls').start_or_attach(config)
