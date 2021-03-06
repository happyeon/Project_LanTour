const socket = io('/')
const videoGrid = document.getElementById('video-grid')
const guestvideoGrid = document.getElementById('guest-grid')

const myVideo = document.createElement('video')
const myAudio = document.createElement('audio')
myVideo.muted = true
myAudio.muted = true

const myPeer = new Peer()
const peers = {}
let myMediaStream;




if (member_grade == 'H') {
    navigator.mediaDevices.getUserMedia({
        video: { width: 1280, height: 720 },
        audio: true
    }).then(stream => {  
        myMediaStream = stream;
        console.log(stream.id)
        addVideoStream(myVideo, stream)
        myPeer.on('call', call => {
            call.answer(stream)
            const video = document.createElement('video')
            call.on('stream', userVideoStream => {
                addVideoStream(video, userVideoStream)
            })
        })
    
        
        socket.on('user-connected', userId => {
            setTimeout(() => {
                console.log(userId)
                connectToAllUser(userId, stream)
            }, 1000)
        })
        
    })
} else {
    navigator.mediaDevices.getUserMedia({
        video: false,
        audio: true
    }).then(stream => {  
        myMediaStream = stream;
        addAudioStream(myAudio, stream)

        myPeer.on('call', call => {
            call.answer(stream)
            const audio = document.createElement('audio')
            const video = document.createElement('video')
            call.on('stream', userVideoStream => {
                console.log(userVideoStream.getVideoTracks().length)
                if (userVideoStream.getVideoTracks().length == 1) {
                    addVideoStream(video, userVideoStream)
                } else {
                    addAudioStream(audio, userVideoStream)
                }
                
                
            })
        })
    
        
        socket.on('user-connected', userId => {
            console.log(userId)
            setTimeout(() => {
                connectToAllUser(userId, stream)
            }, 1000)
        })
        
    })
}



socket.on('user-disconnected', userId => {
    if (peers[userId]) {
        setTimeout(() => {
            peers[userId].close()
        }, 1000)
    }
})

myPeer.on('open', id => {
    socket.emit('join-room', ROOM_ID, id)
})


function addVideoStream(video, stream) {
    video.srcObject = stream
    video.addEventListener('loadedmetadata', () => {
        video.play()
    })      
        videoGrid.append(video)
}

function addAudioStream(audio, stream) {
    audio.srcObject = stream
    audio.addEventListener('loadedmetadata', () => {
        audio.play()
    })
    guestvideoGrid.append(audio)
}


function connectToAllUser(userId, stream){
    const call = myPeer.call(userId, stream)
    const audio = document.createElement('audio')
    console.log(stream)
    call.on('stream', userVideoStream => {
            addAudioStream(audio, userVideoStream)         
    })
    call.on('close', () => {
            audio.remove()
    })
    peers[userId] = call
}



// ?????? control (?????????, ????????? on/off)
const playStop = () => {
    let enabled = myMediaStream.getVideoTracks()[0].enabled;
    if (enabled) {
        myMediaStream.getVideoTracks()[0].enabled = false;
      setPlayVideo();
    } else {
      setStopVideo();
      myMediaStream.getVideoTracks()[0].enabled = true;
    }
};
  
const muteUnmute = () => {
    const enabled = myMediaStream.getAudioTracks()[0].enabled;
    if (enabled) {
        myMediaStream.getAudioTracks()[0].enabled = false;
        setUnmuteButton();
    } else {
      setMuteButton();
      myMediaStream.getAudioTracks()[0].enabled = true;
    }
};
  
const setPlayVideo = () => {
    const html = `<i class="unmute fa fa-pause-circle"></i>
    <span class="unmute">Start Video</span>`;
    document.getElementById("playPauseVideo").innerHTML = html;
};
  
const setStopVideo = () => {
    const html = `<i class=" fa fa-video-camera"></i>
    <span class="">Pause Video</span>`;
    document.getElementById("playPauseVideo").innerHTML = html;
};
  
const setUnmuteButton = () => {
    const html = `<i class="unmute fa fa-microphone-slash"></i>
    <span class="unmute">Unmute</span>`;
    document.getElementById("muteButton").innerHTML = html;
};

const setMuteButton = () => {
    const html = `<i class="fa fa-microphone"></i>
    <span>Mute</span>`;
    document.getElementById("muteButton").innerHTML = html;
};

//fullScreen
videoGrid.addEventListener(
    "click",
    function() {
        videoGrid.requestFullscreen();
    },
    true
)
//fullscreen ????????? ??? 
videoGrid.addEventListener("fullscreenchange", event=>{
    $("#fullChat").empty();
    if(document.fullscreenElement!=null){
        document.getElementById("fullChatSendButton").removeAttribute("hidden")

    }else{
        document.getElementById("fullChatSendButton").setAttribute("hidden","hidden")

    }
})

/*
* 
recognition.interimResults : ??????????????? ?????? ??????
recognition.continuous : ???????????? ????????? ?????? / ?????? ??????
recognition.start() : ?????? ?????? ??????
recognition.stop() : ?????? ?????? ???, continuous??? false?????? recognition.onresult ???????????? ?????? ????????? ???????????? ??????
recognition.onresult ??? ???????????? SpeechRecognitionResultList????????? ?????? [i][j]???????????? ????????? ?????? ??? ????????? ??????????????? ??????, ??????????????? ????????? ??????

*/
var check = false;
var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition
var SpeechRecognitionEvent = SpeechRecognitionEvent|| webkitSpeechRecognitionEvent
var string = "" // ???????????? ?????? ??????

var recognition = new SpeechRecognition();
var recognition2 = new SpeechRecognition();

recognition.continuous = true; // ?????? ???????????? ?????? ??? ?????? 
recognition.interimResults = false; //?????? ???????????? ??????

recognition2.continuous = true; // ?????? ???????????? ?????? ??? ?????? 
recognition2.interimResults = false; //?????? ???????????? ??????

var diagnostic = document.querySelector('.output');

function start() {
    alert("?????? ??????")
    var lang = document.getElementById("lang")
    recognition.lang = lang.options[lang.selectedIndex].value
    recognition2.lang = lang.options[lang.selectedIndex].value
    recognition.start()
    console.log('Ready to receive a color command.')
}

var i = 0;
//???????????? ????????? i??? ?????????
recognition.onspeechstart = function() {i = 0}
recognition2.onspeechstart = function() {i = 0}
recognition.onresult = function(event) {
    // The SpeechRecognitionEvent results property returns a SpeechRecognitionResultList object
    // The SpeechRecognitionResultList object contains SpeechRecognitionResult objects.
    // It has a getter so it can be accessed like an array
    // The first [0] returns the SpeechRecognitionResult at the last position.
    // Each SpeechRecognitionResult object contains SpeechRecognitionAlternative objects that contain individual results.
    // These also have getters so they can be accessed like arrays.
    // The second [0] returns the SpeechRecognitionAlternative at position 0.
    // We then return the transcript property of the SpeechRecognitionAlternative object
    var lang = document.getElementById("lang")
    recognition.lang = lang.options[lang.selectedIndex].value
    var res = event.results[i][0].transcript; // ???????????? ?????????
    string = string + " " + res
    console.log('Confidence: ' + event.results[i][0].confidence);
    document.getElementById("result").innerHTML = string
    socket.emit("VoiceRe", res, ROOM_ID)
    i = i + 1
}

recognition2.onresult = function(event) {
    var lang = document.getElementById("lang")
    recognition2.lang = lang.options[lang.selectedIndex].value
    var res = event.results[i][0].transcript;
    console.log('Confidence: ' + event.results[i][0].confidence);
    string = string + " " + res
    document.getElementById("result").innerHTML = string
    socket.emit("VoiceRe", res, ROOM_ID)
    i = i + 1
}


//???????????? ????????? ??????
recognition.onspeechend = function() {recognition2.start()}
recognition.onnomatch = function(event) {recognition2.start()}
recognition.onerror = function(event) {}
recognition2.onspeechend = function() {recognition.start()}
recognition2.onnomatch = function(event) {recognition.start()}
recognition2.onerror = function(event) {}



//????????????????????????
function reAbort() {
    recognition.abort()
    recognition2.abort()
}

//????????????????????????
function reStop() {
    recognition.stop()
    recognition2.stop()
}

$(function() {
    playpapago = setInterval(function() {
        $("#translate").trigger("click");
    }, 600000)
});

function trans(text) {
    var target = $("select[name=target]").val();
    if (text != "") {
        socket.emit("papago",target, text)
    };
    console.log(text)
}


socket.on("VoiceRe", text=>{
        trans(text)
})

socket.on("papago", (lang, text)=>{
    if(lang ==$("select[name=target]").val()){      
        var langtext = text.split(".");
        var lang = "";
        for(var i = 0; i < langtext.length; i++){
            lang += langtext[i];
            if(i % 2 == 0 && i != 0){
                var $langtext = $("<p>"+lang+"</p>");
                $("#langtext").append($langtext);
                lang = "";
            }
            if(i + 1 == langtext.length){
                var $langtext = $("<p>"+lang+"</p>");
                $("#langtext").append($langtext);							
            }
        }
        setTimeout(function () {
            $("#langtext").empty();
        },7000)
    }

    const selectLang = document.getElementById("target");	//?????????????????? ?????????
    if(check == true){
        speak(text, {
                rate: 0.9,	//?????? ?????? 0.1 ~ 10
                pitch: 1,	//????????? ?????? 0 ~ 2
                volume: 1.0,	//????????? ?????? 0 ~ 1
                lang: selectLang.options[selectLang.selectedIndex].value	//????????? ????????? ???????????? ????????? ?????? ?????? ??????
        })
    }
})

var lasttext = null
var pprop = null
//???????????? ????????? ????????? ?????????
window.speechSynthesis.addEventListener("ended", e => {
    speak(lasttext, pprop)
})

function speak(text, opt_prop) {
    if (typeof SpeechSynthesisUtterance === "undefined" || typeof window.speechSynthesis === "undefined") {
        alert("??? ??????????????? ?????? ????????? ???????????? ????????????.");
        return;
    }

    const prop = opt_prop;

    //speechmsg????????? ?????? ??????
    const speechMsg = new SpeechSynthesisUtterance();
    speechMsg.rate = prop.rate;
    speechMsg.pitch = prop.pitch;
    speechMsg.lang = prop.lang;
    speechMsg.text = text;
    speechMsg.volume = prop.volume;

    // SpeechSynthesisUtterance??? ????????? ????????? ???????????? ???????????? ??????
    if(window.speechSynthesis.speeking){
        speakOn = true
        pprop = opt_prop
        lasttext = text
    }else{
        window.speechSynthesis.speak(speechMsg);        	
    }

}

// ??????

//?????? ?????? ??????

const fullChatInput = document.querySelector("#fullTest");
const chatInput = document.querySelector("#test");

fullChatInput.addEventListener("keypress", (event) => {
    if(event.keyCode === 13){
        chatInput.value = fullChatInput.value
        send()
        fullChatInput.value = ""
    }
})

function fullSend(){
    chatInput.value = fullChatInput.value
    send()
    fullChatInput.value = ""
}



chatInput.addEventListener("keypress", (event) => {
    if(event.keyCode === 13){
        send()
    }
})



// ?????? ????????? ??? ?????? 
socket.on('connect', function() {
      const name = member_name
  // ????????? ????????? ????????? ????????? ?????? 
  socket.emit('newUser', name, ROOM_ID)
})
// ????????? ?????? 
function send() {
    // ?????????????????? ????????? ????????????
    var message = document.getElementById('test').value
    
    // ??????????????? ????????? ???????????? ??????
    document.getElementById('test').value = ''
  
    // ?????? ????????? ????????? ????????????????????? ??????
    var chat = document.getElementById('chat')
    var msg = document.createElement('div')
    var node = document.createTextNode("??? : "+message)
    msg.classList.add('me')
    msg.appendChild(node)
    if(document.fullscreenElement!=null){
        var message2 = document.createElement('div')
        var node2 = document.createTextNode("??? : "+message)
        message2.classList.add("fullChatClass")
        message2.appendChild(node2)
        var fullChat = document.getElementById('fullChat')
        fullChat.appendChild(message2)
        setTimeout(function () {
            var removeChat = document.getElementsByClassName('fullChatClass')
            removeChat[0].remove()
        },7000)
    }else{
        chat.appendChild(msg)
    }
  
    // ????????? message ????????? ?????? + ???????????? ??????
    socket.emit('message', {type: 'message', message: message}, ROOM_ID)
  }

  
// ??????????????? ????????? ?????? ?????? 
socket.on('update', function(data) {
    var chat = document.getElementById('chat')
  
    var message = document.createElement('div')
    var node = document.createTextNode(`${data.name}: ${data.message}`)
    var className = ''
  
    // ????????? ?????? ????????? ???????????? ????????? ??????
    switch(data.type) {
      case 'message':
        className = 'other'
        break
  
      case 'connect':
        className = 'connect'
        break
  
      case 'disconnect':
        className = 'disconnect'
        break
    }
  
    message.classList.add(className)
    message.appendChild(node)
    chat.appendChild(message)
    if(document.fullscreenElement!=null){
        var message2 = document.createElement('div')
        var node2 = document.createTextNode(`${data.name}: ${data.message}`)
        message2.classList.add("fullChatClass")
        message2.appendChild(node2)
        var fullChat = document.getElementById('fullChat')
        fullChat.appendChild(message2)
        setTimeout(function () {
            var removeChat = document.getElementsByClassName('fullChatClass')
            removeChat[0].remove()
        },7000)
    }

  })
  