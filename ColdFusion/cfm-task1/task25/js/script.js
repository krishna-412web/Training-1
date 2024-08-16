let colours=["black","gold","blue","green","yellow","orange","red","forestgreen","lightgreen","cyan","magenta"];
let i=n=0;
let o=document.getElementsByClassName("output");
for(i=0;i<o.length;i++)
{	
	if(n >colours.length)
		n=0;
	o[i].style.color=colours[n];
	n+=1;	
}

