import React, { useEffect, useState, useRef } from "react";
import { NavLink } from "react-router-dom";
import { PopupMenu } from "react-simple-widgets";
import './Home.css';
import Header from '../Common/Header'
import Footer from '../Common/Footer';
import Card from "./ServiceCard";
import Rating from "./Rating";

import { MdPhone } from 'react-icons/md';
import { MdLocationOn } from 'react-icons/md';
import { MdEmail } from 'react-icons/md';
import { CgProfile } from 'react-icons/cg';
import { RiCloseCircleFill } from 'react-icons/ri'

import char1 from '../../characters/char1u.jpg'
import char2 from '../../characters/char2u.jpg'
import char3 from '../../characters/char3u.jpg'
import char4 from '../../characters/char4u.jpg'
import reviewdone from '../../characters/reviewdone.png'
import { useSelector } from "react-redux";
import { selectUser } from '../../state/userSlice';

function Home() {

    const user = useSelector(selectUser);
    const cardContainerRef = useRef(null);
    const [isVisible, setIsVisible] = useState(false); // state to keep track of whether the container is visible
    const [service, setService] = useState([]);     //store service data
    const [customer, setCustomer] = useState([]);   //store customer information
    const [countbook, setCountBook] = useState(0);  //count total no of bookings
    const [countprogress, setCountProgress] = useState(0);  // count no of in progres booking
    const [booking, setBooking] = useState([]);     //store booking data(for the review)
    const [bookingid, setBookingId] = useState(-1);
    const [pending, setPending] = useState(false);  //state of the review div


    // ------------------GETTING DATA---------------------------
    // Services daata
    const getservice = async (url) => {
        const Data = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({

            })
        })
            .then(res => res.json())
            .then(Data => {
                setService(Data);
            });
    }

    //customer data
    const getData = async (url, uname) => {
        const Data = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                name: uname
            })
        })
            .then(res => res.json())
            .then(Data => {
                setCustomer(Data[0]);
            });
    }

    //customer total no of bookings
    const getTotalBooking = async (url, uname) => {
        const Data = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                name: uname
            })
        })
            .then(res => res.json())
            .then(Data => {
                setCountBook(Data[0].count);
            });
    }

    //customer In Progress no of booking
    const getInProgressBooking = async (url, uname) => {
        const Data = await fetch(url, {

            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                name: uname
            })
        })
            .then(res => res.json())
            .then(Data => {
                setCountProgress(Data[0].count);
            });
    }


    //Bookings with no reviews
    const getBooking = async (url, uname) => {
        const Data = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                name: uname
            })
        })
            .then(res => res.json())
            .then(Data => {
                setBooking(Data);
                setBookingId(Data[0].BookId);

            });
    }


    const updateReview = async (url, bookid, review, rating) => {
        const Data = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({
                bookingid: bookid,
                review: review,
                rating: rating

            })
        })
    }

    //-----------------------------------


    const handleReviewSubmit = async (event) => {

        //Prevent page reload
        event.preventDefault();

        var { review, rating } = document.forms[0];

        await updateReview('http://localhost:5000/updatereview', bookingid, review.value, rating.value);

        //updating the review div data
        setBookingId(-1);
        await getBooking('http://localhost:5000/getpendingreview', user);
    }


    //useeffect
    useEffect(() => {

        console.log("hello user ");
        console.log(user);
        getservice('http://localhost:5000/getservices');
        getData('http://localhost:5000/getcustomer', user);
        getTotalBooking('http://localhost:5000/getcustomertotalbooking', user);
        getInProgressBooking('http://localhost:5000/getcustprogressbooking', user);
        getBooking('http://localhost:5000/getpendingreview', user);



        function handleScroll() {
            // check if the container is in the viewport
            const containerPosition = cardContainerRef.current.getBoundingClientRect();
            if (containerPosition.top < window.innerHeight && containerPosition.bottom > 0) {
                setIsVisible(true); // if it is, set the state to true
            } else {
                setIsVisible(false); // if it isn't, set the state to false
            }
        }

        window.addEventListener('scroll', handleScroll); // add the scroll event listener

        return () => {
            window.removeEventListener('scroll', handleScroll); // remove the event listener when the component unmounts
        };
    }, []);



    //if the customer has to give rating
    const renderReviewForm = (
        <>

            <div className="review-div">
                <div className="close-div">
                    <RiCloseCircleFill className="close-icon" onClick={() => setPending(false)} />
                </div>
                <h1>Rating and Review</h1>

                <div className="review-card">
                    <h4>Worker Name: {bookingid != -1 ? booking[0].WorkFirstName + " " + booking[0].WorkLastName : booking.WorkFirstName}</h4>
                    <h4>Booking Date: {bookingid != -1 ? booking[0].Date : booking.Date}</h4>
                    <h4>Start Time: {bookingid != -1 ? booking[0].StartTime : booking.StartTime} </h4>
                    <h4>End Time: {bookingid != -1 ? booking[0].FinishTime : booking.FinishTime} </h4>

                    <form >
                        <div className="form-div"><Rating /></div>

                        <div className="form-div">
                            <label className="lblreview">Review</label>
                            <textarea name="review" className="rating-select" rows="4"></textarea>
                        </div>

                        <div >
                            <input type="submit" id="submit" onClick={handleReviewSubmit} />
                        </div>
                    </form>
                </div>

            </div>
        </>
    );


    //if the customer does not have to give rating
    const renderNoReviewForm = (
        <>

            <div className="review-div">
                <div className="close-div">
                    <RiCloseCircleFill className="close-icon" onClick={() => setPending(false)} />
                </div>
                <h1>Rating and Review</h1>
                <div className="no-review">
                    <h3>There is no pending review or rating</h3>
                    <img src={reviewdone} className="imgnoreview" />
                </div>

            </div>
        </>
    );



    //...........................RETURN....................
    return (
        <>

            <Header className="home-header" />

            {/* Displaying review div or not */}
            {pending ? bookingid != -1 ? renderReviewForm : renderNoReviewForm : <></>}


            {/* Main Section */}
            <div id="mainSection" style={{ overflow: pending ? 'hidden' : 'auto', height: pending ? "37.8em" : "auto", opacity: pending ? 0.7 : 1 }}>

                {/* Customer Profile */}
                <div className="profile" id="userprofile">
                    <PopupMenu className="pop-up">
                        <div className="profile-btn-container">
                            <CgProfile className="profile-icon" />
                        </div>

                        <div className="profile-card">

                            <div className="circle-avatar" >
                                <span ><h1>{customer.FirstLetter}</h1></span>
                            </div>
                            <div className="profile-div">
                                <h2 className="">{customer.CustFirstName} {customer.CustLastName}</h2>
                                <p className="">{customer.Username}</p>
                                <p className="">{customer.Email}</p>
                                <p className="">{customer.CNIC}</p>
                                <p className="">{customer.CustPhoneNo}</p>
                            </div>

                            <div className="profile-div">
                                <h3>Bookings</h3>
                                <p>Total Bookings: {countbook}</p>
                                <p>In Progress: {countprogress}</p>
                            </div>

                            <div className="profile-div">
                                <button className="profile-btn" onClick={() => setPending(true)}>Pending Reviews</button>

                            </div>

                            <div className="profile-div">
                                <NavLink to="/" ><button className="profile-btn">Log Out</button></NavLink>
                            </div>

                        </div>
                    </PopupMenu>
                </div>



                {/* About Us Setion */}
                <div className="aboutSection" id="about">
                    <div className="contentBox">
                        <h1>Know About Us</h1>
                        <p>The basic purpose of Servicely is to provide all kinds of services at customer’s doorsteps with a one-stop solution to make their life easy and convenient anywhere at any time by the service providers. We realize the challenges that every home face on a regular basis is getting skilled service provider at a convenient time. </p>
                        <p>We intend to be Pakistan’s largest online home services platform and provide our customers with the best experience from beginning to end, easy to book services, and on-demand quality services at their homes.</p>
                    </div>

                    <div className="imgContainer">
                        <img src={char1} id='char1' />
                        <img src={char2} id='char2' />
                        <img src={char3} id='char3' />
                        <img src={char4} id='char4' />
                    </div>
                </div>

                {/* Services Section */}
                <div id="services" ref={cardContainerRef} className={`card-container services ${isVisible ? 'visible' : ''}`}>
                    <h1>Services Offered</h1>
                    <div className="flex-grid" >

                        {
                            service.map((getser) => (
                                <Card key={getser.SName}
                                    title={getser.SName}
                                    text={getser.SDesc}
                                    sid={getser.SId}
                                ></Card>
                            )

                            )
                        }
                    </div>
                </div>



                {/* Contact US */}
                <div className="contact" id="contact">
                    <h1>Contact Us</h1>
                    <div className="contact-grid">
                        <div className="contact-card">
                            <MdPhone className="icon" />
                            <h2>Phone</h2>
                            <p>+92 310 5004239 </p>
                            <p>+92 311 4193173 </p>
                            <p>+92 333 5759396 </p>
                            <p>+92 309 0106401 </p>
                        </div>


                        <div className="contact-card mid-card">
                            <MdLocationOn className="icon" />
                            <h2>Address</h2>
                            <p>Military College of Signals, NUST</p>
                        </div>

                        <div className="contact-card ">
                            <MdEmail className="icon" />
                            <h2>Email</h2>
                            <p>mkhattak.bse2021mcs@student.nust.edu.pk</p>
                            <p>mhanif.bse2021mcs@student.nust.edu.pk</p>
                            <p>zsohail.bse2021mcs@student.nust.edu.pk</p>
                            <p>rashraf.bse2021mcs@student.nust.edu.pk</p>
                        </div>

                    </div>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3324.0709686499017!2d73.06105811505151!3d33.5775065807378!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x38df9369c223da7f%3A0xa69202fe0256feee!2sMilitary%20College%20of%20Signals%2C%20NUST!5e0!3m2!1sen!2s!4v1672641895525!5m2!1sen!2s"
                        title="Military College of Signals"
                        width="100%"
                        height="100%"
                        style={{ border: '0px' }}
                        allowfullscreen=""
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>

            <Footer />
        </>

    )
}

export default Home