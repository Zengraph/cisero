
{include file="$tpl_dir./errors.tpl"}

{if !empty($category) && $category->id}
    {if !$category->active}
        <div class="alert alert-warning">{l s='This category is currently unavailable.'}</div>
    {else}
        <main>
        <section id="category-info">
            <h1 class="page-heading{if (isset($subcategories) && !$products) || (isset($subcategories) && $products) || !isset($subcategories) && $products} product-listing{/if}">
                <span class="cat-name">{$category->name|escape:'html':'UTF-8'}{if isset($categoryNameComplement)}&nbsp;{$categoryNameComplement|escape:'html':'UTF-8'}{/if}</span>
            </h1>
            {if !empty($category->description)}
                <div id="category-description" class="rte text-center p-3">{$category->description}</div>
            {/if}
        </section>
		
        {if !empty($products)}
            <section id="category-products">
                <div class="content_sortPagiBar d-flex justify-content-between">
                    <div class="col-6 sortPagiBar">
                        {include file="./product-sort.tpl"}
                        {include file="./nbr-product-page.tpl"}
                    </div>
                    <div class="col-6 text-end top-pagination-content form-inline">
                        {include file="./product-compare.tpl"}
                        {include file="$tpl_dir./pagination.tpl"}
                    </div>
                </div>
                {include file="./product-list.tpl" products=$products}
            </section>
        {/if}

    {/if}
    </main>
{/if}
