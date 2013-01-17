var link;

function getLink(name) {

            link="";
            link = "http://kinox.to/Search.html?q="
            link += name.replace(/[^A-Za-z\s\']/g, "").trim().split(' ').join('+');
            return link;

}
