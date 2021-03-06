<div id="layer_cart">
  <div class="row">
    <div class="layer_cart_product col-xs-12 col-md-6">
      <button type="button" class="close cross" title="{l s='Close window' mod='blockcart'}">&times;</button>
      <span class="text-success cart-title">
        <i class="fa fa-check"></i> {l s='Product successfully added to your shopping cart' mod='blockcart'}
      </span>
      <div class="row">
        <div class="col">
          <div class="thumbnail layer_cart_img"></div>
        </div>
        <div class="col">
          <div class="layer_cart_product_info m-4">
            <span id="layer_cart_product_title" class="product-name"></span>
            <p id="layer_cart_product_attributes"></p>
            <p>
              <strong>{l s='Quantity:' mod='blockcart'}</strong>
              <span id="layer_cart_product_quantity"></span>
            </p>
            <p>
              <strong>{l s='Total:' mod='blockcart'}</strong>
              <span id="layer_cart_product_price"></span>
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="layer_cart_cart text-start col-xs-12 col-md-6">
      <span class="title">
        <span class="ajax_cart_product_txt_s{if $cart_qties < 2} unvisible{/if}">
          {l s='There are [1]%d[/1] items in your cart.' mod='blockcart' sprintf=[$cart_qties] tags=['<span class="ajax_cart_quantity">']}
        </span>
        <span class="ajax_cart_product_txt {if $cart_qties > 1} unvisible{/if}">
          {l s='There is 1 item in your cart.' mod='blockcart'}
        </span>
      </span>
      <p class="layer_cart_row mt-5">
        <strong>
          {l s='Total products:' mod='blockcart'}
          {if $use_taxes && $display_tax_label && $show_tax}
            {if $priceDisplay == 1}
              {l s='(tax excl.)' mod='blockcart'}
            {else}
              {l s='(tax incl.)' mod='blockcart'}
            {/if}
          {/if}
        </strong>
        <span class="ajax_block_products_total">
          {if $cart_qties > 0}
            {convertPrice price=$cart->getOrderTotal(false, Cart::ONLY_PRODUCTS)}
          {/if}
        </span>
      </p>

      {if $show_wrapping}
        <p class="layer_cart_row">
          <strong>
            {l s='Wrapping:' mod='blockcart'}
            {if $use_taxes && $display_tax_label && $show_tax}
              {if $priceDisplay == 1}
                {l s='(tax excl.)' mod='blockcart'}
              {else}
                {l s='(tax incl.)' mod='blockcart'}
              {/if}
            {/if}
          </strong>
          <span class="price ajax_block_wrapping_cost">
            {if $priceDisplay == 1}
              {convertPrice price=$cart->getOrderTotal(false, Cart::ONLY_WRAPPING)}
            {else}
              {convertPrice price=$cart->getOrderTotal(true, Cart::ONLY_WRAPPING)}
            {/if}
          </span>
        </p>
      {/if}

      <p class="layer_cart_row">
        <strong class="{if $shipping_cost_float == 0 && ($cart_qties || $cart->isVirtualCart() || !isset($cart->id_address_delivery) || !$cart->id_address_delivery)} unvisible{/if}">
          {l s='Total shipping:' mod='blockcart'}&nbsp;{if $use_taxes && $display_tax_label && $show_tax}{if $priceDisplay == 1}{l s='(tax excl.)' mod='blockcart'}{else}{l s='(tax incl.)' mod='blockcart'}{/if}{/if}
        </strong>
        <span class="ajax_cart_shipping_cost{if $shipping_cost_float == 0 && ($cart_qties || $cart->isVirtualCart() || !isset($cart->id_address_delivery) || !$cart->id_address_delivery)} unvisible{/if}">
          {if $shipping_cost_float == 0}
            {if (!isset($cart->id_address_delivery) || !$cart->id_address_delivery)}{l s='To be determined' mod='blockcart'}{else}{l s='Free shipping!' mod='blockcart'}{/if}
          {else}
            {$shipping_cost}
          {/if}
        </span>
      </p>

      {if $show_tax && isset($tax_cost)}
        <p class="layer_cart_row">
          <strong>{l s='Tax:' mod='blockcart'}</strong>
          <span class="price ajax_cart_tax_cost">{$tax_cost}</span>
        </p>
      {/if}

      <p class="layer_cart_row">
        <strong>
          {l s='Total:' mod='blockcart'}
          {if $use_taxes && $display_tax_label && $show_tax}
            {if $priceDisplay == 1}
              {l s='(tax excl.)' mod='blockcart'}
            {else}
              {l s='(tax incl.)' mod='blockcart'}
            {/if}
          {/if}
        </strong>
        <span class="ajax_block_cart_total">
          {if $cart_qties > 0}
            {if $priceDisplay == 1}
              {convertPrice price=$cart->getOrderTotal(false)}
            {else}
              {convertPrice price=$cart->getOrderTotal(true)}
            {/if}
          {/if}
        </span>
      </p>

      <div class="button-container">
        <p class="cart_navigation d-grid gap-2 d-md-flex justify-content-md-between mt-3">
            <a href="#" class="continue btn btn-outline-dark" title="Continue shopping">
				<i class="fa fa-chevron-left"></i> {l s='Continue shopping' mod='blockcart'}
			</a>
			<a class="btn btn-dark standard-checkout" href="{$link->getPageLink("$order_process", true)|escape:"html":"UTF-8"}" title="{l s='Proceed to checkout' mod='blockcart'}" rel="nofollow">
				{l s='Proceed to checkout' mod='blockcart'} <i class="fa fa-chevron-right"></i>
			</a>
		</p>
      </div>
    </div>
  </div>
  <div class="crossseling"></div>
</div>

<div class="layer_cart_overlay"></div>
