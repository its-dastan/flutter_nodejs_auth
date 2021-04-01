const express = require('express')
const app = express()
const cors = require('cors')



// app.use(cors())
app.use(express.json())
app.use(express.urlencoded({extended: false}))

app.get('/', (req, res) => res.send('hello world'))


app.post('/signup', (req, res) => {
    console.log(req.body);
    res.send("Signup route")
})


let PORT = 3000
app.listen(PORT, () => console.log("Listening on PORT 3000"))