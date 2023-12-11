const api_url = "http://localhost:3000"
let api_endpoint = api_url.concat("/gettopthree")

const request = new XMLHttpRequest();

function toggleVisibility(element) {
    var answer = document.getElementById(element.id);
    if (answer.style.display == "block"){
      answer.style.display = "none";
    }
    else {
      answer.style.display = "block";
    }
  }

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

    const name4 = document.getElementById("name-4");
    const score4 = document.getElementById("score-4");
    const videolink4 = document.getElementById("videolink-4");

    const name5 = document.getElementById("name-5");
    const score5 = document.getElementById("score-5");
    const videolink5 = document.getElementById("videolink-5");

    const name6 = document.getElementById("name-6");
    const score6 = document.getElementById("score-6");
    const videolink6 = document.getElementById("videolink-6");

    const name7 = document.getElementById("name-7");
    const score7 = document.getElementById("score-7");
    const videolink7 = document.getElementById("videolink-7");

    const name8 = document.getElementById("name-8");
    const score8 = document.getElementById("score-8");
    const videolink8 = document.getElementById("videolink-8");

    const name9 = document.getElementById("name-9");
    const score9 = document.getElementById("score-9");
    const videolink9 = document.getElementById("videolink-9");

    const name10 = document.getElementById("name-10");
    const score10 = document.getElementById("score-10");
    const videolink10 = document.getElementById("videolink-10");

    request.open("GET", api_endpoint, false);
    request.send(null);

    if (request.status === 200) {
        var response = JSON.parse(request.responseText);
        
        name1.innerHTML = response[0].name;
        score1.innerHTML = response[0].score;
        videolink1.href = response[0].video_link;

        name2.innerHTML = response[1].name;
        score2.innerHTML = response[1].score;
        videolink2.href = response[1].video_link;

        name3.innerHTML = response[2].name;
        score3.innerHTML = response[2].score;
        videolink3.href = response[2].video_link;

        name4.innerHTML = response[3].name;
        score4.innerHTML = response[3].score;
        videolink4.href = response[3].video_link;

        name5.innerHTML = response[4].name;
        score5.innerHTML = response[4].score;
        videolink5.href = response[4].video_link;

        name6.innerHTML = response[5].name;
        score6.innerHTML = response[5].score;
        videolink6.href = response[5].video_link;

        name7.innerHTML = response[6].name;
        score7.innerHTML = response[6].score;
        videolink7.href = response[6].video_link;

        name8.innerHTML = response[7].name;
        score8.innerHTML = response[7].score;
        videolink8.href = response[7].video_link;

        name9.innerHTML = response[8].name;
        score9.innerHTML = response[8].score;
        videolink9.href = response[8].video_link;

        name10.innerHTML = response[9].name;
        score10.innerHTML = response[9].score;
        videolink10.href = response[9].video_link;
    }
    else {
        console.log(request.status)
    }
};
