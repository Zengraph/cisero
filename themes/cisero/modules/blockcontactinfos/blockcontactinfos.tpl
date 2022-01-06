<div class="col" id="block_contact_infos">
	<h4 class="title_block">{l s='Contact us' mod='blockcontactinfos'}</h4>
	<ul class="list-unstyled">
		{if $blockcontactinfos_company != ''}<li><strong>{$blockcontactinfos_company|escape:'html':'UTF-8'}</strong></li>{/if}
		{if $blockcontactinfos_address != ''}<li>{$blockcontactinfos_address|escape:'html':'UTF-8'|nl2br}</li>{/if}
		{if $blockcontactinfos_phone != ''}<li>{l s='Tel' mod='blockcontactinfos'} {$blockcontactinfos_phone|escape:'html':'UTF-8'}</li>{/if}
		{if $blockcontactinfos_email != ''}<li>{l s='Email:' mod='blockcontactinfos'} {mailto address=$blockcontactinfos_email|escape:'html':'UTF-8' encode="hex"}</li>{/if}
	</ul>
</div>
