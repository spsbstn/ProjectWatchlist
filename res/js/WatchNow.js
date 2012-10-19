var link;

function getLink(name) {

            link="";
            link = "http://kinox.to/Search.html?q="
            link += name.split(' ').join('+');
            return link;

}
