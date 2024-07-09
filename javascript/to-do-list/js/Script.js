let list = document.getElementById("anand");
let input = document.getElementById("add-new");

let form = document.getElementById("todo-input");

let i=0;
let id=0;

function change(event) {
	let c = event.target;
	c.classList.toggle('bg-success'); 
	c.classList.toggle('bg-light'); 
}

function dlt(event) {
	let d = event.target.parentElement;
	d.remove(); 
}

function save() {
	let t = list.innerHTML;
	localStorage.setItem("save",t);
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

/*document.addEventListener('DOMContentLoaded', () => {
    const listItems = document.querySelectorAll('#anand li');

    listItems.forEach(item => {
        item.addEventListener('click', () => {
	    if(item.style.backgroundColor == "F8F9FA")
		{
			item.style.backgroundColor = "#198754";	
		}
	    else
		{
			item.style.backgroundColor = "#f8f9fa";
		}
        });
    });
});*/