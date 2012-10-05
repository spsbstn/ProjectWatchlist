function getShow(name) {
// todo parse name to fit URL
request("http://www.omdbapi.com/?i=&t=Breaking+Bad", function (o) {

                    // translate response into object
                       var d = eval('new Object(' + o.responseText + ')');

                    // access elements inside json object with dot notation (example)
            //name
            console.log(d.Title);
            //year
            console.log(d.Year);
            //title
            console.log(d.Genre);
            //short plot
            console.log(d.Plot);
            //url to poster
            console.log(d.Poster);

            // possible elements are Title, Year, Rated, Released, Runtime, Genre,
            // Director, Actors, Plot, Poster, imdbRating, imdbVotes and imdbID

                        });
    
}

function request(url, callback) {
       var req = new XMLHttpRequest();
       req.onreadystatechange = (function(c) {
           return function() {
               if (req.readyState == XMLHttpRequest.DONE){
               callback(c);
           }}
       })(req);
       req.open('GET', url, true);
    req.send('');
   }

