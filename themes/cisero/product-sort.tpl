{if isset($orderby) AND isset($orderway)}

  <div id="productsSortForm{if isset($paginationId)}_{$paginationId}{/if}" class="productsSortForm d-flex align-items-center flex-nowrap me-3 me-sm-4 pb-3">
	<form action="{$request|escape:'html':'UTF-8'}">
      <select id="selectProductSort{if isset($paginationId)}_{$paginationId}{/if}" class="selectProductSort form-select">
        <option value="{if $page_name != 'best-sales'}{$orderbydefault|escape:'html':'UTF-8'}:{$orderwaydefault|escape:'html':'UTF-8'}{/if}"{if !in_array($orderby, array('price', 'name', 'quantity', 'reference')) && $orderby eq $orderbydefault} selected="selected"{/if}>{l s='Sort by'}</option>
        {if !$PS_CATALOG_MODE}
          <option value="price:asc"{if $orderby eq 'price' AND $orderway eq 'asc'} selected="selected"{/if}>{l s='Price: Lowest first'}</option>
          <option value="price:desc"{if $orderby eq 'price' AND $orderway eq 'desc'} selected="selected"{/if}>{l s='Price: Highest first'}</option>
        {/if}
        <option value="name:asc"{if $orderby eq 'name' AND $orderway eq 'asc'} selected="selected"{/if}>{l s='Product Name: A to Z'}</option>
        <option value="name:desc"{if $orderby eq 'name' AND $orderway eq 'desc'} selected="selected"{/if}>{l s='Product Name: Z to A'}</option>
        {if $PS_STOCK_MANAGEMENT && !$PS_CATALOG_MODE}
          <option value="quantity:desc"{if $orderby eq 'quantity' AND $orderway eq 'desc'} selected="selected"{/if}>{l s='In stock'}</option>
        {/if}
        <option value="reference:asc"{if $orderby eq 'reference' AND $orderway eq 'asc'} selected="selected"{/if}>{l s='Reference: Lowest first'}</option>
        <option value="reference:desc"{if $orderby eq 'reference' AND $orderway eq 'desc'} selected="selected"{/if}>{l s='Reference: Highest first'}</option>
      </select>
    </form>
  </div>

  {if !isset($paginationId) || $paginationId == ''}
    {addJsDef request=$request}
  {/if}

{/if}
