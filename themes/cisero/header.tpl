<!DOCTYPE HTML>
<html{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}{if isset($isRtl) && $isRtl} dir="rtl"{/if}>
<head>
    <meta charset="utf-8">
    <title>{$meta_title|escape:'html':'UTF-8'}</title>
    {if isset($meta_description) AND $meta_description}
        <meta name="description" content="{$meta_description|escape:'html':'UTF-8'}">
    {/if}
    {if isset($meta_keywords) AND $meta_keywords}
        <meta name="keywords" content="{$meta_keywords|escape:'html':'UTF-8'}">
    {/if}
    <meta name="generator" content="thirty bees">
    <meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow">
    <meta name="viewport" content="width=device-width, minimum-scale=0.25, maximum-scale=5, initial-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <link rel="icon" type="image/vnd.microsoft.icon" href="{$favicon_url}?{$img_update_time}">
    <link rel="shortcut icon" type="image/x-icon" href="{$favicon_url}?{$img_update_time}">
    <link rel="stylesheet" href="{$css_dir|escape:'html':'UTF-8'}bootstrap.5.1.3.min.css" type="text/css">
	{if isset($css_files)}
        {foreach from=$css_files key=css_uri item=media}
                <link rel="stylesheet"
                      href="{$css_uri|escape:'html':'UTF-8'}"
                      type="text/css"
                      media="{$media|escape:'html':'UTF-8'}"
                >
        {/foreach}
    {/if}
    {if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
        {$js_def}
        {foreach from=$js_files item=js_uri}
            <script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>
        {/foreach}
    {/if}
    {$HOOK_HEADER}

</head>
<body{if isset($page_name)} id="{$page_name|escape:'html':'UTF-8'}"{/if}
        class="{if isset($page_name)}{$page_name|escape:'html':'UTF-8'}{/if}{if isset($body_classes) && $body_classes|@count} {implode value=$body_classes separator=' '}{/if}{if $hide_left_column} hide-left-column{else} show-left-column{/if}{if $hide_right_column} hide-right-column{else} show-right-column{/if}{if isset($content_only) && $content_only} content_only{/if} lang_{$lang_iso}">
{if !isset($content_only) || !$content_only}

{if isset($restricted_country_mode) && $restricted_country_mode}
    <div id="restricted-country">
        <p>{l s='You cannot place a new order from your country.'}
          {if isset($geolocation_country) && $geolocation_country}<span class="bold">{$geolocation_country|escape:'html':'UTF-8'}</span>{/if}
        </p>
    </div>
{/if}

<main>
  <header id="header">

    {capture name='displayBanner'}{hook h='displayBanner'}{/capture}
    {if $smarty.capture.displayBanner}
        <div id="header-banners">
            {$smarty.capture.displayBanner}
        </div>
    {/if}
	
    <div id="header-blocks" class="container-fluid">
	  <div class="container">
        <div class="row d-flex align-items-center toprow">
			<div class="col-12 col-lg-4 order-3 order-lg-1">
				{capture name='displaySearch'}{hook h='displaySearch'}{/capture}
				{if $smarty.capture.displaySearch}{$smarty.capture.displaySearch}{/if}
			</div>
            <div class="col-8 col-sm-7 col-lg-4 text-center order-1 order-lg-2" id="shop-logo">
				<div class="d-flex align-items-center justify-content-between justify-content-lg-center">
					<nav class="navbar navbar-expand-lg navbar-light me-3">
					   <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#zentopmenu" aria-controls="zentopmenu" aria-expanded="false" aria-label="Toggle navigation">
						 <span class="navbar-toggler-icon"></span>
					 </button> 
					</nav> 
                    <a href="{$link->getPageLink('index', true)|escape:'html':'UTF-8'}" title="{$shop_name|escape:'html':'UTF-8'}">
						<img class="img-fluid center-block" src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}" title="{$shop_name|escape:'html':'UTF-8'}"{if isset($logo_image_width) && $logo_image_width} width="{$logo_image_width}"{/if}{if isset($logo_image_height) && $logo_image_height} height="{$logo_image_height}"{/if}>
					</a>
				</div>
            </div>
			<div class="col-4 col-sm-5 col-lg-4 order-2 order-lg-3 txt-lg d-flex justify-content-end justify-content-lg-end"> 
				{if !empty($HOOK_TOP)}{$HOOK_TOP}{/if}
			</div>
		</div>
	  </div>
	  <div class="row">
		{capture name='displayNav'}{hook h='displayNav'}{/capture}
		{if $smarty.capture.displayNav}{$smarty.capture.displayNav}{/if}
	  </div>
	</div>
</header>

{capture name='displayTopColumn'}{hook h='displayTopColumn'}{/capture}
{if !empty($smarty.capture.displayTopColumn)}
    <div id="top_column">
		{$smarty.capture.displayTopColumn}
    </div>
{/if}

<div id="fullpageslide"></div>

{if $page_name !='index' && $page_name !='pagenotfound'}
    {include file="$tpl_dir./breadcrumb.tpl"}
{/if}
<div id="columns" class="container">
    <div class="row">
        {if isset($left_column_size) && !empty($left_column_size)}
            <aside id="left_column" class="col-xs-12 col-lg-{$left_column_size|intval} p-5">{$HOOK_LEFT_COLUMN}</aside>
        {/if}
        {if isset($left_column_size) && isset($right_column_size)}{assign var='cols' value=(12 - $left_column_size - $right_column_size)}{else}{assign var='cols' value=12}{/if}
        <main id="center_column" class="col-xs-12 col-lg-{$cols|intval} p-4 p-xl-5 mb-4">
            {/if}
