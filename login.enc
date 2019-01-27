function validate(){
    regx=new RegExp("1602-1[0-9]-73[0-9]-[0-9]{3}");
    uname=document.getElementById("rollno");
    pass=document.getElementById("pass");
    form=document.getElementById("myform");
    b=false;
    if(uname.value==''){
        document.getElementById("uerror").style.visibility="visible";
    }
    else{
        document.getElementById("uerror").style.visibility="hidden";
        b=true;
    }
    if(pass.value==''){
        document.getElementById("perror").style.visibility="visible";
    }
    else{
        document.getElementById("perror").style.visibility="hidden";   
        b=true;
    }
    if(!regx.test(uname.value)){
        document.getElementById("uerror").innerHTML="Enter valid username!";
        document.getElementById("uerror").style.visibility="visible";
    }
    else{
        document.getElementById("uerror").style.visibility="hidden";
        b=true;
    }
    if(pass.value.length<6){
        document.getElementById("perror").innerHTML="Weak Password!"
        document.getElementById("perror").style.visibility="visible";
    }
    else{
        document.getElementById("perror").style.visibility="hidden";   
        b=true;
    }
    return b;
}