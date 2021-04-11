<script>
	let data = {
        characterName: undefined,
        loading: false,
    };

	async function getJson() {
		const response = await fetch('http://localhost:9090/sveltebackend/getTheJedi')
		const json = await response.json();
		if (response.ok && json) {
			return json;
		} else {
			throw new Error("some error");
		}
	}

	async function loadData() {
        data.loading = true;
		try {
			const character = await getJson();
			data = {
				characterName: character.name,
				loading: false,
			};	
		} catch (error) {
			data = {
				characterName: "Error",
				loading: false,
			};	
		}		
    }

	async function loadData2() {
		const character = await getJson();
		try {
			return character.name;
		} catch (error) {
			throw new Error("some error");
		}
	}

	let data2 = loadData2();
	function handleClick() {
		data2 = loadData2();
	}
</script>
<getthejedi>
	<button on:click={loadData}>Load Data</button>
    {#if data.loading === true}
        Loading Character Name...
    {:else if data.characterName !== undefined}
        {data.characterName}
    {/if}
	<button on:click={handleClick}>
		generate random number
	</button>	
	{#await data2}
		<p>...waiting</p>
	{:then test}
		<p>The star is {test}</p>
	{:catch error}
		<p style="color: red">{error.message}</p>
	{/await}
</getthejedi>

<style>
	getthejedi button{
		background-color: rgb(73, 250, 102);
		margin: 0;
	}
	getthejedi p{
		margin-block-start: 0.7em;
    	margin-block-end: 0.7em;
	}
</style>
