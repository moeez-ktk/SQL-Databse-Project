const config = {
    user: 'username of database management system',
    password: 'password of database management system',
    server: 'Your PC Name or Server Name',
    database: 'Database Name',
    options: {
        trustServerCertificate: true,
        trustedConnection: false,
        enableArithAbort: true,
        instancename: 'SQLEXPRESS'
    },
    port: 1433
}

module.exports = config;