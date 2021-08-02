const session = require('express-session')
const express = require('express')
const cors = require('cors')
const app = express()
const fs = require('fs')
const { v4: uuidV4 } = require('uuid')

const java = require("java")
java.classpath.push('./jar/papago.jar')

const papagoC = java.import('papago.PapagoController')
const instance = new papagoC()

app.use(cors())

const options = { 
    key: fs.readFileSync('./keys/cert.key'),
    cert: fs.readFileSync('./keys/cert.crt')
}
const server = require('https').createServer(options, app)
const io = require('socket.io')(server)

app.use(session({ 
    secret: 'keyboard cat', 
    resave: false, 
    saveUninitialized: true 
}))


app.set('view engine', 'ejs')
app.use(express.static('public'))
app.use(express.json());
app.use(express.urlencoded({ extended: false }))

app.get('/', (req, res) => {
    res.redirect(`/${uuidV4()}`)
})

app.get('/:room', (req, res) => { 
    if (req.session.member_grade != 'H') {
        req.session.member_name = req.query.member_name
    }
    res.render('room', {
        roomId: req.params.room,
        member_grade: req.session.member_grade,
        member_no: req.session.member_no,
        lantour_no: req.session.lantour_no,
        member_name: req.session.member_name
    })
})

app.post('/',(req, res)=>{
    req.session.member_grade = req.body.member_grade
    req.session.member_no = req.body.member_no
    req.session.lantour_no = req.body.lantour_no
    req.session.member_name = req.body.member_name
    console.log(req.session.member_grade)
    console.log(req.session.member_no)
    console.log(req.session.lantour_no)
    console.log(req.session.member_name)
    res.redirect(`/${uuidV4()}`)
 })



io.on('connection', socket => {
    //음성인식
    socket.on("VoiceRe", (text, roomid)=>{
        socket.broadcast.to(roomid).emit("VoiceRe", text)
    } )
    //파파고 번역
    socket.on("papago", (lang, target)=>{
        socket.emit("papago", lang,instance.papagolangSync(target,lang))
    })

    // 새로운 유저가 접속했을 경우 다른 소켓에게도 알려줌 
    socket.on('newUser', function(name, roomid) {
        // 소켓에 이름 저장해두기 
        socket.name = name

        // 모든 소켓에게 전송(brodcast는 나 빼고 다 전송)
        socket.broadcast.to(roomid).emit('update', {type: 'connect', name: 'SERVER', message: name + '님이 접속하였습니다.'})
        socket.emit('update', {type: 'connect', name: 'SERVER', message: name + '님이 접속하였습니다.'})

    })
    
    // 전송한 메시지 받기 
    socket.on('message', function(data, roomid) {
        // 받은 데이터에 누가 보냈는지 이름을 추가 
        data.name = socket.name
        
        console.log(data)

        //보낸 사람을 제외한 나머지 유저에게 메시지 전송 
        socket.broadcast.to(roomid).emit('update', data);
    })


    socket.on('join-room', (roomId, userId) => {
        socket.join(roomId)
        socket.broadcast.to(roomId).emit('user-connected', userId)

        socket.on('disconnect', () => {
            socket.broadcast.emit('update', {type: 'disconnect', name: 'SERVER', message: socket.name + '님이 나가셨습니다.'});
            socket.broadcast.to(roomId).emit('user-disconnected', userId)
        })
    })

    
})

server.listen(3000)