var link;

function getLink(name,hoster) {

    link="";

    if(hoster=="kinox") {

            link = "http://kinox.to/Search.html?q="

}
    if(hoster=="tvlinkseu") {

        link = "http://www.tv-links.eu/_search/?s="

    }

    link += name.replace(/[^A-Za-z\s\']/g, "").trim().split(' ').join('+');
    return link;
}
