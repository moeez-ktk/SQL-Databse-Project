import { createSlice } from '@reduxjs/toolkit'

export const sidSlice = createSlice({
    name: 'sid',
    initialState: {
        value: null,
    },
    reducers: {
        setSid: (state,action) => {
            // console.log('select', action);
            state.value = action.payload
        },
        removeSid: (state) => {
            // console.log('select', action);
            state.value = null
        }
    },
})

export const selectSid = (state) => state.sid.value;

// Action creators are generated for each case reducer function
export const { setSid,removeSid } = sidSlice.actions

export default sidSlice.reducer