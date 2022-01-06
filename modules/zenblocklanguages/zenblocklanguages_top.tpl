{if count($languages) > 1}
<div class="col-auto order-last" id="languages_block_top">
	<div id="countries_top">
	{* @todo fix display current languages, removing the first foreach loop *}
		{foreach from=$languages key=k item=language name="languages"}
			{if $language.iso_code == $lang_iso}
				<a class="nav-link dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					{$language.name|escape:'html':'UTF-8'}
				</a>
			{/if}
		{/foreach}
		<ul class="dropdown-menu dropdown-menu-dark">
		{foreach from=$languages key=k item=language name="languages"}
			{if $language.iso_code != $lang_iso}
				<li>
					{assign var=indice_lang value=$language.id_lang}
					{if isset($lang_rewrite_urls.$indice_lang)}
						<a class="dropdown-item" href="{$lang_rewrite_urls.$indice_lang|escape:htmlall}" title="{$language.name|escape:'html':'UTF-8'}" rel="alternate" hreflang="{$language.iso_code|escape:'html':'UTF-8'}">{$language.name|escape:'html':'UTF-8'}</a>
					{else}
						<a class="dropdown-item" href="{$link->getLanguageLink($language.id_lang)|escape:htmlall}" title="{$language.name|escape:'html':'UTF-8'}" rel="alternate" hreflang="{$language.iso_code|escape:'html':'UTF-8'}"> {$language.name|escape:'html':'UTF-8'}</a> 
					{/if}
				</li>
			{/if}
		{/foreach}
		</ul>
	</div>
</div>
{/if}