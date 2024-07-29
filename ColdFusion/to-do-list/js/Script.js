let list = document.getElementById("anand");
let input = document.getElementById("add-new");

let form = document.getElementById("todo-input");

let i=0;
let id=0;

function change(event) {
	let c = event.target;
	c.classList.toggle('bg-success'); 
	c.classList.toggle('bg-light'); 
	save();
}

function dlt(event) {
	let d = event.target.parentElement;
	d.remove(); 
	save();
}

function save() {
	let t = list.innerHTML;
	localStorage.setItem("save",t);
}

function retreive(){
	let data = localStorage.getItem("save");
	list.innerHTML = data;
}

function NewLi(){
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
});

window.onload = retreive();