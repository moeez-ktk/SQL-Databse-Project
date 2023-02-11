const config = require('./dbConfig'),
    sql = require('mssql');

const getServices = async () => {
    try {
        let pool = await sql.connect(config);
        let services = pool.request().query("select * from Service")
        return services;
    }
    catch (error) {
        console.log(error);
    }
}

const getInfo = async (uname) => {
    try {
        let pool = await sql.connect(config);
        let customer = pool.request().query(`select * from Customer where uname = '${uname}'`)
        return customer;
    }
    catch (error) {
        console.log(error);
    }
}

const getBookingCust = async (uname) => {
    try {
        let pool = await sql.connect(config);
        let totalbooking = pool.request().query(`select count(BookId) as count from Booking where CUserName = '${uname}' and Status != 'Rejected'`)
        return totalbooking;
    }
    catch (error) {
        console.log(error);
    }
}

const getProgressBookingCust = async (uname) => {
    try {
        let pool = await sql.connect(config);
        let inprogress = pool.request().query(`select count(BookId) as count from Booking where CUserName = '${uname}' and Status != 'Accepted'`)
        return inprogress;
    }
    catch (error) {
        console.log(error);
    }
}

const getCustomers = async (uname) => {
    try {
        let pool = await sql.connect(config);
        let customers = pool.request().query(`select * from Customer where Username = '${uname}'`)
        return customers;
    }
    catch (error) {
        console.log(error);
    }
}

const getPReviewBook = async (uname) => {
    try {
        let pool = await sql.connect(config);
        let pendingreview = pool.request().query(`select top 1 * from Booking where CUsername = '${uname}' and Status = 'Completed' and Rating IS NULL`)
        return pendingreview;
    }
    catch (error) {
        console.log(error);
    }
}

const updateReview = async (bookid, review, rating) => {
    try {
        let pool = await sql.connect(config);
        let newreview = pool.request().query(`Update Booking set Review = '${review}', Rating = CAST(${rating} AS INT) where BookId = CAST(${bookid} AS INT)`)
        return newreview;
    }
    catch (error) {
        console.log(error);
    }
}
const getWorkerData = async (sid, city) => {
    try {
        let pool = await sql.connect(config);
        let worker = pool.request().query(`select * from Worker where SId=CAST(${sid} AS INT) AND WorkCity='${city}'`)
        console.log(worker);
        return worker;
    }
    catch (error) {
        console.log(error);
    }
}

const getWorkerDetails = async (sid, city) => {
    try {
        let pool = await sql.connect(config);
        let worker1 = pool.request().query(`select b.WUserName,count(b.BookId) as countProject,avg(b.Rating) as rating from Booking b INNER JOIN Worker w ON b.WUserName=w.Username where w.SId=CAST(${sid} AS INT) AND w.WorkCity='${city}' group by b.WUserName`)
        console.log(worker1);
        return worker1;
    }
    catch (error) {
        console.log(error);
    }
}

const login = async (uname, pass, table) => {
    try {
        let pool = await sql.connect(config);
        let customers = pool.request().query(`select * from ${table} where Username = '${uname}' AND Password='${pass}'`)
        // console.log(customers);
        return customers;
    }
    catch (error) {
        console.log(error);
    }
}

const createCustomers = async (uname, password, firstname, lastname, dob, gender, phone, cnic, email, street, house, city) => {
    try {
        let pool = await sql.connect(config);
        let customers = pool.request().query(`insert into Customer values ('${uname}','${firstname}','${lastname}','${dob}','${gender}','${phone}','${house}','${street}','${city}','${password}','${email}','${cnic}')`)
        // console.log(customers);
        return customers;
    }
    catch (error) {
        console.log(error);
    }
}

const createWorkers = async (uname, password, firstname, lastname, dob, gender, phone, cnic, email, street, house, city, occup, exp, price, desc) => {
    try {
        let pool = await sql.connect(config);
        let workers = pool.request().query(`insert into Worker values ('${uname}','${firstname}','${lastname}','${dob}','${gender}','${phone}','${house}','${street}','${city}',CAST(${exp} as INT),CAST(${price} as INT),'${desc}','${password}','${email}',CAST(${occup} AS INT),'${cnic}')`)
        // console.log(customers);
        return workers;
    }
    catch (error) {
        console.log(error);
    }
}

module.exports = {
    getWorkerDetails,
    getServices,
    getWorkerData,
    getBookingCust,
    getProgressBookingCust,
    getPReviewBook,
    updateReview,
    createCustomers,
    createWorkers,
    login,
    getCustomers
}