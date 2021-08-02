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



// 버튼 control (비디오, 오디오 on/off)
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
//fullscreen 변화할 때 
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
recognition.interimResults : 중간결과값 리턴 여부
recognition.continuous : 중간중간 결과값 리턴 / 내부 필드
recognition.start() : 음성 인식 시작
recognition.stop() : 음성 인식 끝, continuous가 false이면 recognition.onresult 마지막에 실행 아니면 중간중간 실행
recognition.onresult 의 내부에는 SpeechRecognitionResultList객체가 있음 [i][j]배열이며 음성이 인식 될 때마다 첫번째칸이 추가, 두번째칸은 정확도 구분

*/
var check = false;
var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition
var SpeechRecognitionEvent = SpeechRecognitionEvent|| webkitSpeechRecognitionEvent
var string = "" // 음성인식 결과 뭉치

var recognition = new SpeechRecognition();
var recognition2 = new SpeechRecognition();

recognition.continuous = true; // 인식 중간중간 결과 값 리턴 
recognition.interimResults = false; //중간 결과값도 리턴

recognition2.continuous = true; // 인식 중간중간 결과 값 리턴 
recognition2.interimResults = false; //중간 결과값도 리턴

var diagnostic = document.querySelector('.output');

function start() {
    alert("녹음 시작")
    var lang = document.getElementById("lang")
    recognition.lang = lang.options[lang.selectedIndex].value
    recognition2.lang = lang.options[lang.selectedIndex].value
    recognition.start()
    console.log('Ready to receive a color command.')
}

var i = 0;
//음성인식 시작시 i값 초기화
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
    var res = event.results[i][0].transcript; // 음성인식 결과값
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


//음성인식 종료시 반복
recognition.onspeechend = function() {recognition2.start()}
recognition.onnomatch = function(event) {recognition2.start()}
recognition.onerror = function(event) {}
recognition2.onspeechend = function() {recognition.start()}
recognition2.onnomatch = function(event) {recognition.start()}
recognition2.onerror = function(event) {}



//음성인식종료버튼
function reAbort() {
    recognition.abort()
    recognition2.abort()
}

//음성인식종료버튼
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

    const selectLang = document.getElementById("target");	//어느나라말로 말할지
    if(check == true){
        speak(text, {
                rate: 0.9,	//속도 설정 0.1 ~ 10
                pitch: 1,	//음높이 설정 0 ~ 2
                volume: 1.0,	//목소리 크기 0 ~ 1
                lang: selectLang.options[selectLang.selectedIndex].value	//선택한 언어의 옵션값을 받아와 해당 음성 출력
        })
    }
})

var lasttext = null
var pprop = null
//말하기가 끝나면 이어서 말하기
window.speechSynthesis.addEventListener("ended", e => {
    speak(lasttext, pprop)
})

function speak(text, opt_prop) {
    if (typeof SpeechSynthesisUtterance === "undefined" || typeof window.speechSynthesis === "undefined") {
        alert("이 브라우저는 음성 합성을 지원하지 않습니다.");
        return;
    }

    const prop = opt_prop;

    //speechmsg에있는 값을 저장
    const speechMsg = new SpeechSynthesisUtterance();
    speechMsg.rate = prop.rate;
    speechMsg.pitch = prop.pitch;
    speechMsg.lang = prop.lang;
    speechMsg.text = text;
    speechMsg.volume = prop.volume;

    // SpeechSynthesisUtterance에 저장된 내용을 바탕으로 음성합성 실행
    if(window.speechSynthesis.speeking){
        speakOn = true
        pprop = opt_prop
        lasttext = text
    }else{
        window.speechSynthesis.speak(speechMsg);        	
    }

}

// 채팅

//엔터 치면 전송

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



// 접속 되었을 때 실행 
socket.on('connect', function() {
      const name = member_name
  // 서버에 새로운 유저가 왔다고 알림 
  socket.emit('newUser', name, ROOM_ID)
})
// 메시지 전송 
function send() {
    // 입력되어있는 데이터 가져오기
    var message = document.getElementById('test').value
    
    // 가져왔으니 데이터 빈칸으로 변경
    document.getElementById('test').value = ''
  
    // 내가 전송할 메시지 클라이언트에게 표시
    var chat = document.getElementById('chat')
    var msg = document.createElement('div')
    var node = document.createTextNode("나 : "+message)
    msg.classList.add('me')
    msg.appendChild(node)
    if(document.fullscreenElement!=null){
        var message2 = document.createElement('div')
        var node2 = document.createTextNode("나 : "+message)
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
  
    // 서버로 message 이벤트 전달 + 데이터와 함께
    socket.emit('message', {type: 'message', message: message}, ROOM_ID)
  }

  
// 서버로부터 데이터 받은 경우 
socket.on('update', function(data) {
    var chat = document.getElementById('chat')
  
    var message = document.createElement('div')
    var node = document.createTextNode(`${data.name}: ${data.message}`)
    var className = ''
  
    // 타입에 따라 적용할 클래스를 다르게 지정
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
  