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

{if $page_name =='index'}
<!-- Module HomeSlider -->
    {if isset($zenslider_slides)}
		<div id="homepage-zenslider" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-indicators">
			{foreach from=$zenslider_slides key=k item=slide}
				{if $slide.active}
					<button type="button" data-bs-target="#homepage-zenslider" data-bs-slide-to="{$k}" class="active" aria-current="true" aria-label="{$slide.legend|escape:'htmlall':'UTF-8'}"></button>
				{/if}
			{/foreach}
			</div>
			<div class="carousel-inner" id="zenslider">
				{foreach from=$zenslider_slides key=k item=slide}
					{if $slide.active}
						<div class="carousel-item{if $k==0} active{/if}">
							<a href="{$slide.url|escape:'html':'UTF-8'}" title="{$slide.legend|escape:'html':'UTF-8'}">
								<img src="{$link->getMediaLink("`$smarty.const._MODULE_DIR_`zenslider/images/`$slide.image|escape:'htmlall':'UTF-8'`")}" alt="{$slide.legend|escape:'htmlall':'UTF-8'}" />
							</a>
							{if isset($slide.description) && trim($slide.description) != ''}
								<div class="carousel-caption d-md-block">
									<h3>{$slide.title|escape:'htmlall':'UTF-8'}</h3>
									<p class="subtitle">{$slide.legend|escape:'htmlall':'UTF-8'}</p>
									{$slide.description}
								</div>
							{/if}
						</div>
					{/if}
				{/foreach}
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#homepage-zenslider" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#homepage-zenslider" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	{/if}
<!-- /Module HomeSlider -->
{/if}
