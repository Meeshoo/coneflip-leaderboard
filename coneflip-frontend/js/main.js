const request = new XMLHttpRequest();

window.onload = function() {

    const name1 = document.getElementById("name-1");
    const score1 = document.getElementById("score-1");
    const videolink1 = document.getElementById("videolink-1");

    const name2 = document.getElementById("name-2");
    const score2 = document.getElementById("score-2");
    const videolink2 = document.getElementById("videolink-2");

    const name3 = document.getElementById("name-3");
    const score3 = document.getElementById("score-3");
    const videolink3 = document.getElementById("videolink-3");

    request.open("GET", "http://localhost:3000/gettopthree", false);
    request.send(null);

    if (request.status === 200) {
        var response = JSON.parse(request.responseText);

        console.log(response);
        
        name1.innerHTML = response[0].name;
        score1.innerHTML = response[0].score;
        videolink1.href = response[0].video_link;

        name2.innerHTML = response[1].name;
        score2.innerHTML = response[1].score;
        videolink2.href = response[1].video_link;

        name3.innerHTML = response[2].name;
        score3.innerHTML = response[2].score;
        videolink3.href = response[2].video_link;
    }
    else {
        console.log(request.status)
    }
};