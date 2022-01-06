{**
 * Copyright (C) 2017-2019 thirty bees
 * Copyright (C) 2007-2016 PrestaShop SA
 *
 * thirty bees is an extension to the PrestaShop software by PrestaShop SA.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@thirtybees.com so we can send you a copy immediately.
 *
 * @author    thirty bees <modules@thirtybees.com>
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2017-2019 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   Academic Free License (AFL 3.0)
 * PrestaShop is an internationally registered trademark of PrestaShop SA.
 *}

{if count($languages) > 1}
<div class="col-xl-auto order-last"></div>
<div class="col-auto order-last mb-4 mb-0-sm" id="languages_block_foot">
	<div id="countries_foot" class="btn-group">
	{* @todo fix display current languages, removing the first foreach loop *}
		{foreach from=$languages key=k item=language name="languages"}
			{if $language.iso_code == $lang_iso}
				<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					<img src="{$img_lang_dir}{$language.id_lang}.jpg" alt="{$language.iso_code|escape:'html':'UTF-8'}" width="16" height="11" /> {$language.name|escape:'html':'UTF-8'}
				</button>
			{/if}
		{/foreach}
		<ul class="dropdown-menu">
		{foreach from=$languages key=k item=language name="languages"}
			{if $language.iso_code != $lang_iso}
				<li>
					{assign var=indice_lang value=$language.id_lang}
					{if isset($lang_rewrite_urls.$indice_lang)}
						<a class="dropdown-item" href="{$lang_rewrite_urls.$indice_lang|escape:htmlall}" title="{$language.name|escape:'html':'UTF-8'}" rel="alternate" hreflang="{$language.iso_code|escape:'html':'UTF-8'}"><img src="{$img_lang_dir}{$language.id_lang}.jpg" alt="{$language.iso_code|escape:'html':'UTF-8'}" width="16" height="11" /> {$language.name|escape:'html':'UTF-8'}</a>
					{else}
						<a class="dropdown-item" href="{$link->getLanguageLink($language.id_lang)|escape:htmlall}" title="{$language.name|escape:'html':'UTF-8'}" rel="alternate" hreflang="{$language.iso_code|escape:'html':'UTF-8'}"><img src="{$img_lang_dir}{$language.id_lang}.jpg" alt="{$language.iso_code|escape:'html':'UTF-8'}" width="16" height="11" /> {$language.name|escape:'html':'UTF-8'}</a> 
					{/if}
				</li>
			{/if}
		{/foreach}
		</ul>
	</div>
</div>
{/if}