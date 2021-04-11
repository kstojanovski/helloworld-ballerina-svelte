<script>
    let sentFormDataFeedback = "";

    const backendUrl = "http://localhost:9090/sveltebackend/sentFormData";

   	const formData = new FormData();
    formData.append("data1", "Hello");
    formData.append("data2", "World");

	function sendData() {
		const upload = fetch(backendUrl, {
            method: "POST",
            body: formData
        })
		.then((response) => response.json()).then((result) => {
            console.log("Success:", result);
			sentFormDataFeedback = result.status;
        })
		.catch((error) => {
			console.error("Error:", error);
			sentFormDataFeedback = "error";
		});
	}

	async function sendDataAsync() {
		let returnState = "";
		const upload = await fetch(backendUrl, {
            method: "POST",
            body: formData
        })
		.then((response) => response.json()).then((result) => {
            console.log("Success:", result);
			returnState = result.status;
        })
		.catch((error) => {
			console.error("Error:", error);
			returnState = "error";
		});
		return returnState;
	}

	let sentFormDataFeedbackAsync = sendDataAsync();
	async function handleSentFormDataFeedback() {
		sentFormDataFeedbackAsync = sendDataAsync();
	}
</script>
<sentFormData>
    <button on:click={sendData}>
		Send data
	</button>
	{#if sentFormDataFeedback !== ""}
		{sentFormDataFeedback}
	{/if}
	<button on:click={handleSentFormDataFeedback}>
		Send data
	</button>
	{#await sentFormDataFeedbackAsync}
		<p>...waiting</p>
	{:then value}
		<p>{value}</p>
	{:catch error}
		<p style="color: red">{error}</p>
	{/await}
</sentFormData>
<style>
    sentFormData button{
		background-color: rgb(73, 250, 226);
        margin: 0;
	}
	sentFormData p{
		margin-block-start: 0.7em;
    	margin-block-end: 0.7em;
	}
</style>
