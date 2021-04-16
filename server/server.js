const express = require('express')
const app = express()
const mongoose = require('mongoose')
const cors = require('cors')

const connectDB = () => {
    mongoose.connect('mongodb://localhost:27017/auth', {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useCreateIndex: true,
        useFindAndModify: false
    })
    console.log("DB Connected!");
}
connectDB()

// app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

app.get('/', (req, res) => res.send('hello world'))


//model
var schema = new mongoose.Schema({ email: 'String', password: 'String' })
var User = mongoose.model("User", schema)


//Signup Route
app.post('/signup', async (req, res) => {
    // console.log(req.body)
    const { email, password } = req.body
    console.log(email);
    console.log(password)
    let user = new User({
        email,
        password,
    })
    await user.save()
    res.json({
        token: "1234567890"
    })
    // return res.send("Signup route")
})

app.post('/login', async (req, res) => {
    // console.log(req.body)
    const { email, password } = req.body
    let user = await User.findOne({email})
    if(user.password != password) {
        return res.json({msg: "Password is not correct"})
    }
    return res.json({
        token: "1234567890"
    })
    // return res.send("Signup route")
})


let PORT = 5000
app.listen(PORT, () => console.log("Listening on PORT ", PORT))