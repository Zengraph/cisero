<div id="newsletter_block_left" class="col-12 order-first">
  <div class="row">
	<div class="col-md-6">
		<h4 class="title_block">{l s='Sign up to our newsletter' mod='blocknewsletter'}</h4>
		<p class="subline">{l s='Stay up-to-date with Cisero news, items releases, updates and events.' mod='blocknewsletter'}</p>
		{if isset($msg) && $msg}
			<p class="{if $nw_error}warning_inline{else}success_inline{/if}">{$msg}</p>
		{/if}
	</div>
	<div class="col-md-6">
		<form action="{$link->getPageLink('index', true)|escape:'html'}" method="post">				
			<label for="exampleFormControlInput1" class="form-label">Email*</label>
			<input type="email" class="form-control" id="newsletter-input" value="{if isset($value) && $value}{$value}{/if}">
			<p>{l s='You are subscribing to receive email marketing from Cisero. For further information view our' mod='blocknewsletter'} <a href="{$link->getCMSLink('2')|escape:'html'}" rel="noopener" target="_blank">{l s='privacy policy' mod='blocknewsletter'}</a>.</p>
			<input type="submit" value="SUBMIT" class="button_mini" name="submitNewsletter" />
			<input type="hidden" name="action" value="0" />	
		</form>
	</div>
  </div>
</div>

<script type="text/javascript">
    var placeholder = "{l s='your e-mail' mod='blocknewsletter' js=1}";
    {literal}
        $(document).ready(function() {
            $('#newsletter-input').on({
                focus: function() {
                    if ($(this).val() == placeholder) {
                        $(this).val('');
                    }
                },
                blur: function() {
                    if ($(this).val() == '') {
                        $(this).val(placeholder);
                    }
                }
            });
        });
    {/literal}
</script>
