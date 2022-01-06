{if !empty($products)}

  {$show_functional_buttons = $page_name != 'index'}

  <div {if !empty($id)} id="{$id}"{/if} class="product_list row row-cols-auto gap-3{if !empty($class)} {$class}{/if}">
    {foreach from=$products item=product}
	<div class="ajax_block_product flex-fill text-center p-3 border">
		{include file='./product-list-item.tpl' product=$product}
	</div>
	{/foreach}
  </div>

  {addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
  {addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
  {addJsDef comparator_max_item=$comparator_max_item}
  {addJsDef comparedProductsIds=$compared_products}
{/if}
