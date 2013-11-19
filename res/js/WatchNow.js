var link;

function getLink(name,hoster) {

    link="";

    if(hoster=="kinox") {

            link = "http://kinox.to/Search.html?q="

}
    if(hoster=="tvmuse") {

        link = "http://www.tvmuse.eu/_search/?s="

    }

    if(hoster=="hulu") {

            link = "http://www.hulu.com/search?q="

        }

    if(hoster=="vodly") {

            link = "http://vodly.to/index.php?search_keywords="

        }

    link += name.replace(/\({1}\d+\){1}/g, "").trim().split(' ').join('+');
    return link;
}
