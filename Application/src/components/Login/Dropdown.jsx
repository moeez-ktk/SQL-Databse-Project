import React from "react";

class Dropdown extends React.Component {
    constructor(props) {
        super(props);
        this.state = { value: 1 };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({ value: event.target.value });
    }

    handleSubmit(event) {
        event.preventDefault();
    }

    render() {
        return (
            <label id="occupation">
                Occupation
                <select value={this.state.value} onChange={this.handleChange} id='occup'>
                    <option value={4}>Plumber</option>
                    <option value={1}>Electrician</option>
                    <option value={2}>Mechanic</option>
                    <option value={3}>Carpenter</option>
                    <option value={5}>Pest Control</option>
                    <option value={6}>Beautician</option>
                    <option value={8}>Gardener</option>
                    <option value={9}>Painter</option>
                    <option value={7}>Laundry</option>
                </select>
            </label>
        );
    }
}

class Experience extends React.Component {
    constructor(props) {
        super(props);
        this.state = { value: 1 };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({ value: event.target.value });
    }

    handleSubmit(event) {
        event.preventDefault();
    }

    render() {
        return (
            <label id="experience">
                Experience
                <select value={this.state.value} onChange={this.handleChange} id='exp'>
                    <option value='1'>1 Year</option>
                    <option value='2'>2 Years</option>
                    <option value='3'>3 Years</option>
                    <option value='4'>4+ Years</option>
                </select>
            </label>
        );
    }
}

class Cities extends React.Component {
    constructor(props) {
        super(props);
        this.state = { value: 'Islamadb' };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({ value: event.target.value });
    }

    handleSubmit(event) {
       
        event.preventDefault();
    }

    render() {
        return (
            <label id="City">
                City
                <select value={this.state.value} onChange={this.handleChange} id='city'>
                    <option value='Islamabad'>Islamabad</option>
                    <option value='Rawalpindi'>Rawalpindi</option>
                    <option value='Karachi'>Karachi</option>
                    <option value='Lahore'>Lahore</option>
                    <option value='Quetta'>Quetta</option>
                    <option value='Peshawar'>Peshawar</option>
                </select>
            </label>
        );
    }
}

export { Dropdown, Experience, Cities }; 