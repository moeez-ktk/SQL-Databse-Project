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

app.post('/login', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.login(req.body.name,req.body.pass,req.body.table);
   console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/createcustomer', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.createCustomers(req.body.name,req.body.password,req.body.firstname,req.body.lastname,req.body.dob,req.body.gender,req.body.phone,req.body.cnic,req.body.email,req.body.street,req.body.house,req.body.city);
   console.log('api call')
    console.log(result);
    res.send(result.recordset)
})

app.post('/createworker', async (req, res) => {
    console.log('Called');
    const result = await dbOperations.createWorkers(req.body.name,req.body.password,req.body.firstname,req.body.lastname,req.body.dob,req.body.gender,req.body.phone,req.body.cnic,req.body.email,req.body.street,req.body.house,req.body.city,req.body.occup,req.body.exp,req.body.price,req.body.desc);
   console.log('api call')
    console.log(result);
    res.send(result.recordset)
})



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
app.post('/getworkerdata',async(req,res)=>{
    console.log('Called WorkerData');
    const worker=await dbOperations.getWorkerData(req.body.sid,req.body.city)
    console.log(worker);
    res.send(worker.recordset)
})

app.post('/getworkerdetails',async(req,res)=>{
    console.log('Called WorkerDetailCalled');
    const worker1=await dbOperations.getWorkerDetails(req.body.sid,req.body.city)
    console.log(worker1);
    res.send(worker1.recordset)
})


app.post('/api', function (req, res) {
    res.send({ result: 'Good bye' })
})

app.post('/quit', function (req, res) {
    res.send({ result: 'Closing' })
})

app.listen(API_PORT, () => console.log(`Listening on port ${API_PORT}`));

