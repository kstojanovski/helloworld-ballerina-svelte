<script lang="ts">
	import GetTheJedi from "./GetTheJedi.svelte";
	import SentFormData from "./SentFormData.svelte";

	export let name: string;
</script>

<main>
	<h1>Hello {name}!</h1>
	<p>Visit the <a href="https://svelte.dev/tutorial">Svelte tutorial</a> to learn how to build Svelte apps.</p>
	<p><b>Test</b></p>

	<GetTheJedi/>
	<SentFormData/>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}
	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 10
		;
	}
	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>