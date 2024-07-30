let list = document.getElementById("anand");

let input = document.getElementById("add-new");

empty = () => { document.getElementById("add-new").value=''; }

let form = document.getElementById("todo-input");

let i=0;
let id=0;

change = (event) => {
	let c = event.target;
	c.classList.toggle('bg-success'); 
	c.classList.toggle('bg-light'); 
	save();
}

dlt = (event) => {
	let d = event.target.parentElement;
	d.remove(); 
	save();
}

save= () => {
	let t = list.innerHTML;
	localStorage.setItem("save",t);
}

retreive = () => {
	let data = localStorage.getItem("save");
	list.innerHTML = data;
}

NewLi = () => {
	const n = document.createElement("LI");
	const value = input.value;
	//alert(value);
	i+=1;
	n.innerHTML = value+'<button class="btn btn-close btn-sm bg-primary rounded" onclick="dlt(event)"></button>';
	n.className="list-group-item d-flex flex-row justify-content-between rounded p-1 mb-1";
	n.setAttribute('id',i);
	n.classList.toggle('bg-light'); 
	n.setAttribute('onclick','change(event)');
	list.appendChild(n);
	//localStorage.setItem("id",value);	
}



form.addEventListener('submit',function(e)
{		
		e.preventDefault();
		NewLi();
		save();
		empty();		
});

window.onload = retreive();