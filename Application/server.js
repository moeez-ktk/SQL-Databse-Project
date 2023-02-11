const express = require('express'),
    cors = require('cors'),
    dbOperations = require('./dbFiles/dbOperation');

const API_PORT = process.env.PORT || 5000;
const app = express();


let client;
let session;
app.use(cors());
app.use(express.json());
app.use(express.urlencoded());

// ------------------------LOGIN---------------------------------

app.post('/login', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.login(req.body.name, req.body.pass, req.body.table);
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/createcustomer', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.createCustomers(req.body.name, req.body.password, req.body.firstname, req.body.lastname, req.body.dob, req.body.gender, req.body.phone, req.body.cnic, req.body.email, req.body.street, req.body.house, req.body.city);
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/createworker', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.createWorkers(req.body.name, req.body.password, req.body.firstname, req.body.lastname, req.body.dob, req.body.gender, req.body.phone, req.body.cnic, req.body.email, req.body.street, req.body.house, req.body.city, req.body.occup, req.body.exp, req.body.price, req.body.desc);
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/updateAccepted', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.updateAccepted();
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})


//----------------------------HOME PAGE---------------------------------------


app.post('/getservices', async (req, res) => {
    const result = await dbOperations.getServices();
    res.send(result.recordset)
})

app.post('/getcustomer', async (req, res) => {
    const result = await dbOperations.getCustomers(req.body.name);
    res.send(result.recordset)
})

app.post('/getcustomertotalbooking', async (req, res) => {
    const result = await dbOperations.getBookingCust(req.body.name);
    res.send(result.recordset)
})

app.post('/getcustprogressbooking', async (req, res) => {
    const result = await dbOperations.getProgressBookingCust(req.body.name);
    res.send(result.recordset)
})


app.post('/getpendingreview', async (req, res) => {
    const result = await dbOperations.getPReviewBook(req.body.name);
    res.send(result.recordset)
})

app.post('/updatereview', async (req, res) => {
    console.log("update server");
    const result = await dbOperations.updateReview(req.body.bookingid, req.body.review, req.body.rating);
    console.log(result);
    res.send(result.recordset)
})

//-----------------Custometr Home------------------

app.post('/getWorkerBookings', async (req, res) => {
    console.log('Called Get Worker Bookings');
    const worker1 = await dbOperations.getWorkerBookings(req.body.id,req.body.date)
    console.log(worker1);
    res.send(worker1.recordset)
})
app.post('/getworkerdata',async(req,res)=>{
    console.log('Called WorkerData');
    const worker=await dbOperations.getWorkerData(req.body.sid,req.body.user)
    console.log(worker);
    res.send(worker.recordset)
})

app.post('/getworkerdetails', async (req, res) => {
    console.log('Called WorkerDetailCalled');
    const worker1 = await dbOperations.getWorkerDetails(req.body.sid, req.body.type,req.body.user)
    console.log(worker1);
    res.send(worker1.recordset)
})

app.post('/savebooking', async (req, res) => {
    console.log('Called Save Bookings');
    const worker1 = await dbOperations.saveBooking(req.body.id,req.body.user,req.body.time,req.body.date,req.body.hrs)
    console.log(worker1);
    // res.send(worker1.recordset)
})


// ------------------------WORKER HOME---------------------------------

app.post('/updatebooking', async (req, res) => {
    console.log('Update Status Called');
    const result = await dbOperations.updateBooking(req.body.bookid, req.body.status, req.body.user, req.body.condition);
    console.log('api call')
    // console.log(result);
    res.send(result.recordset)
})

app.post('/getBooking', async (req, res) => {
    console.log('Get All Data Called');
    const result = await dbOperations.getBooking(req.body.user);
    console.log('api call')
    // console.log(result);
    res.send(result.recordset)
})

app.post('/getBookingCondition', async (req, res) => {
    console.log('Get All Data Condition Called');
    const result = await dbOperations.getBookingCondition(req.body.user, req.body.condition);
    console.log('api call')
    // console.log(result);
    res.send(result.recordset)
})


// ------------------------WORKER HOME CHART DATA---------------------------------

app.post('/getOrderChartData', async (req, res) => {
    console.log('Get All Data Condition Called');
    const result = await dbOperations.getOrderChartData(req.body.user, req.body.date);
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/getRatingChartData', async (req, res) => {
    console.log('Get All Data Condition Called');
    const result = await dbOperations.getRatingChartData(req.body.user, req.body.date);
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/getSummary', async (req, res) => {
    console.log('Get Summary Called');
    const result = await dbOperations.getSummary(req.body.user);
    console.log('api call')
    console.log(result);
    res.send(result.recordset)
})


// ------------------------QUIT---------------------------------

app.post('/quit', function (req, res) {
    console.log('Called Quit');
    res.send({ result: 'Closing' })
})

app.listen(API_PORT, () => console.log(`Listening on port ${API_PORT}`));

