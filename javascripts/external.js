function externalLinks() {
    if (!document.getElementsByTagName) return;
    var anchors = document.getElementsByTagName("a");
    for (var i=0; i<anchors.length; i++) {
        var anchor = anchors[i];
        if (anchor.getAttribute("href") && anchor.getAttribute("rel") && ((anchor.getAttribute("rel").indexOf("external") >= 0) || (anchor.getAttribute("rel").indexOf("nofollow") >= 0))) {
            anchor.target = "_blank";
        }
    }
}
window.onload = externalLinks;

