
let i = 0;
document.addEventListener("load", function() {
    i = 0;
});
document.getElementById("forward").addEventListener("click", function(){
    i = Math.min(9, i + 1);
    document.getElementById(`${i + 1}`).scrollIntoView();
});
document.getElementById("backward").addEventListener("click", function(){
    i = Math.max(0, i - 1);
    // window.location = `#${i + 1}`;
    document.getElementById(`${i + 1}`).scrollIntoView();
});