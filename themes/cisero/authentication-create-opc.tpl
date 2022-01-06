<div class="d-grid">
	<button class="btn btn-lg btn-outline-dark my-3" type="button" data-bs-toggle="collapse" data-bs-target="#OpcAccountCreate" aria-expanded="false" aria-controls="OpcAccountCreate">
		{l s='Order as a Guest'} <i class="fas fa-cart-plus"></i>
	</button>
	<div class="collapse" id="OpcAccountCreate">
	  <div class="card card-body">
		<form action="{$link->getPageLink('authentication', true, NULL, "back=$back")|escape:'html':'UTF-8'}" method="post" id="new_account_form">
		  <div class="row">
			<div id="opc_account_form" class="col-lg-6">
			  <h3 class="page-heading mt-3">{l s='Instant checkout'}</h3>
			  <p class="required mb-2"><sup>*</sup>{l s='Required field'}</p>
			  <div class="required input-group mb-3">
				<label class="input-group-text" for="guest_email">{l s='Email address'} <sup>*</sup></label>
				<input type="text" class="is_required validate form-control" data-validate="isEmail" id="guest_email" name="guest_email" value="{if isset($smarty.post.guest_email)}{$smarty.post.guest_email}{/if}">
			  </div>
			  <div class="input-group mb-3">
				<label class="input-group-text">{l s='Title'}</label>
					<select id="id_gender" name="id_gender" class="form-select">
						<option value="">choose your title...</option>
						{foreach from=$genders key=k item=gender}			 
							<option value="{$gender->id}" {if isset($smarty.post.id_gender) && $smarty.post.id_gender == $gender->id}selected="selected"{/if}>{$gender->name}</option>
						{/foreach}
					</select>
				</label>					
			  </div>
			  <div class="input-group mb-3">
				<span class="input-group-text">{l s='First name'} <sup>*</sup></span>
				<input type="text" class="is_required validate form-control" data-validate="isName" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}">
			  </div>
			  <div class="input-group mb-3">
				<span class="input-group-text">{l s='Last name'} <sup>*</sup></span>
				<input type="text" class="is_required validate form-control" data-validate="isName" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}">
			  </div>
			  <div class="input-group date-select mb-3">
				<label class="input-group-text me-2">{l s='Date of Birth'}</label>
				<select id="days" name="days" class="form-select me-2">
					<option value="">{l s='day'}</option>
					{foreach from=$days item=day}
						<option value="{$day}" {if ($sl_day == $day)} selected="selected"{/if}>{$day}&nbsp;&nbsp;</option>
					{/foreach}
				</select>
				<select id="months" name="months" class="form-select me-2">
					<option value="">{l s='month'}</option>
					{foreach from=$months key=k item=month}
						<option value="{$k}" {if ($sl_month == $k)} selected="selected"{/if}>{l s=$month}&nbsp;</option>
					{/foreach}
				</select>
				<select id="years" name="years" class="form-select">
					<option value="">{l s='year'}</option>
						{foreach from=$years item=year}
							<option value="{$year}" {if ($sl_year == $year)} selected="selected"{/if}>{$year}&nbsp;&nbsp;</option>
						{/foreach}
				</select>
			  </div>
			  {if isset($newsletter) && $newsletter}
				<div class="form-check">
					<input class="form-check-input" type="checkbox" name="newsletter" id="newsletter" value="" {if isset($smarty.post.newsletter) AND $smarty.post.newsletter == 1} checked="checked"{/if}>
					<label class="form-check-label" for="newsletter">
						{l s='Sign up for our newsletter!'}{if array_key_exists('newsletter', $field_required)}<sup> *</sup>{/if}
					</label>
				</div>
			  {/if}
		      {if isset($optin) && $optin}
				<div class="form-check">
					<input class="form-check-input" type="checkbox" name="optin" id="optin" value="" {if isset($smarty.post.optin) AND $smarty.post.optin == 1} checked="checked"{/if}>
					<label class="form-check-label"  for="optin">
						{l s='Receive special offers from our partners!'}{if array_key_exists('optin', $field_required)}<sup> *</sup>{/if}
					</label>
			  </div>
			  {/if}			  
			</div>
			<div class="col-lg-6">
			  <h3 class="page-heading my-cust">{l s='Delivery address'}</h3>
			  {foreach from=$dlv_all_fields item=field_name}
				{if $field_name eq "company"}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
					<input type="text" class="form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}">
				  </div>
				{elseif $field_name eq "vat_number"}
				  {if isset($vat_display) && $vat_display >= 3}
					<div class="checkbox">
					  <label for="vat-exemption">
						<input
								type="checkbox"
								name="vat_exemption"
								id="vat-exemption"
								value="1"
								{if (isset($address->vat_exemption) && $address->vat_exemption)
								|| (isset($address->vat_number) && strlen($address->vat_number))}
								  checked="checked"
								{/if}
						>
						{l s='Yes, I qualify for VAT Relief!'}
					  </label>
					</div>
					<p id="vat-exemption-hint" class="help-block" style="display: none;">
					  {l s='You\'ll get asked to verify your qualification.'}
					</p>
				  {/if}
				  <div id="vat_number" style="display:none;">
					<div class="input-group mb-3">
					  <span class="input-group-text">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
					  <input id="vat-number" type="text" class="form-control" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{/if}">
					</div>
				  </div>
				{elseif $field_name eq "dni"}
				  {assign var='dniExist' value=true}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='Identification number'} <sup>*</sup></span>
					<input type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{/if} aria-describedby="dniHelpBlock">">
					<div id="dniHelpBlock" class="form-text ms-2"><small>DNI / NIF / NIE</small></div>
				  </div>
				{elseif $field_name eq "address1"}
				  <div class="input-group mb-3">
					 <span class="input-group-text">{l s='Address'} <sup>*</sup></span>
					<input type="text" class="form-control" name="address1" id="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{/if}">
				  </div>
				{elseif $field_name eq "address2"}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
					<input type="text" class="form-control" name="address2" id="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}">
				  </div>
				{elseif $field_name eq "postcode"}
				  {assign var='postCodeExist' value=true}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='Zip/Postal Code'} <sup>*</sup></span>
					<input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}">
				  </div>
				{elseif $field_name eq "city"}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='City'} <sup>*</sup></span>
					<input type="text" class="form-control" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}">
				  </div>
				  {* if customer hasn't update his layout address, country has to be verified but it's deprecated *}
				{elseif $field_name eq "Country:name" || $field_name eq "country"}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='Country'} <sup>*</sup></span>
					<select name="id_country" id="id_country" class="form-control">
					  {foreach from=$countries item=v}
						<option value="{$v.id_country}"{if (isset($smarty.post.id_country) AND  $smarty.post.id_country == $v.id_country) OR (!isset($smarty.post.id_country) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name}</option>
					  {/foreach}
					</select>
				  </div>
				{elseif $field_name eq "State:name"}
				  {assign var='stateExist' value=true}
				  <div class="input-group mb-3">
					<span class="input-group-text">{l s='State'} <sup>*</sup></span>
					<select name="id_state" id="id_state" class="form-control">
					  <option value="">-</option>
					</select>
				  </div>
				{/if}
			  {/foreach}
			  {if $stateExist eq false}
				<div class="input-group mb-3 unvisible">
				  <span class="input-group-text">{l s='State'} <sup>*</sup></span>
				  <select name="id_state" id="id_state" class="form-control">
					<option value="">-</option>
				  </select>
				</div>
			  {/if}
			  {if $postCodeExist eq false}
				<div class="input-group mb-3 unvisible">
				 <span class="input-group-text">{l s='Zip/Postal Code'} <sup>*</sup></span>
				  <input type="text" class="validate form-control" name="postcode" id="postcode" data-validate="isPostCode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}">
				</div>
			  {/if}
			  {if $dniExist eq false}
				<div class="input-group mb-3">
				    <span class="input-group-text">{l s='Identification number'}<sup>*</sup></span>
				    <input type="text" class="text form-control" name="dni" id="dni" value="{if isset($smarty.post.dni) && $smarty.post.dni}{$smarty.post.dni}{/if}" aria-describedby="dniHelpBlock">
					<div id="dniHelpBlock" class="form-text ms-2"><small>{l s='DNI / NIF / NIE'}</small></div>
				</div>
			  {/if}
			  <div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}input-group mb-3">
				 <span class="input-group-text">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</span>
				<input type="text" class="form-control" name="phone_mobile" id="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{/if}">
			  </div>
			  <input type="hidden" name="alias" id="alias" value="{l s='My address'}">
			  <input type="hidden" name="is_new_customer" id="is_new_customer" value="0">
			  <div class="form-check mb-4">
				  <input class="form-check-input" type="checkbox" name="invoice_address" id="invoice_address"{if (isset($smarty.post.invoice_address) && $smarty.post.invoice_address) || (isset($smarty.post.invoice_address) && $smarty.post.invoice_address)} checked="checked"{/if} autocomplete="off">
				  <label class="form-check-label" for="invoice_address">{l s='Please use another address for invoice'}</span>
			  </div>
			  <div id="opc_invoice_address"  class="unvisible">
				{assign var=stateExist value=false}
				{assign var=postCodeExist value=false}
				{assign var=dniExist value=false}
				<h3 class="page-subheading my-3">{l s='Invoice address'}</h3>
				{foreach from=$inv_all_fields item=field_name}
				  {if $field_name eq "company"}
					<div class="input-group mb-3">
					  <span class="input-group-text">{l s='Company'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
					  <input type="text" class="text form-control" id="company_invoice" name="company_invoice" value="{if isset($smarty.post.company_invoice) && $smarty.post.company_invoice}{$smarty.post.company_invoice}{/if}">
					</div>
				  {elseif $field_name eq "vat_number"}
					{if isset($vat_display) && $vat_display >= 3}
					  <div class="checkbox">
						<label for="vat-exemption">
						  <input
								  type="checkbox"
								  name="vat_exemption"
								  id="vat-exemption"
								  value="1"
								  {if (isset($address->vat_exemption) && $address->vat_exemption)
								  || (isset($address->vat_number) && strlen($address->vat_number))}
									checked="checked"
								  {/if}
						  >
						  {l s='Yes, I qualify for VAT Relief!'}
						</label>
					  </div>
					  <p id="vat-exemption-hint" class="help-block" style="display: none;">
						{l s='You\'ll get asked to verify your qualification.'}
					  </p>
					{/if}
					<div id="vat_number_block_invoice" style="display:none;">
					  <div class="input-group mb-3">
						<span class="input-group-text">{l s='VAT number'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
						<input type="text" class="form-control" id="vat_number_invoice" name="vat_number_invoice" value="{if isset($smarty.post.vat_number_invoice) && $smarty.post.vat_number_invoice}{$smarty.post.vat_number_invoice}{/if}">
					  </div>
					</div>
				  {elseif $field_name eq "dni"}
					{assign var=dniExist value=true}
					<div class="required input-group mb-3">
					  <span class="input-group-text">{l s='Identification number'} <sup>*</sup></span>
					  <input type="text" class="text form-control" name="dni_invoice" id="dni_invoice" value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}" aria-describedby="dniHelpBlock">
					  <div id="dniHelpBlock" class="form-text ms-2"><small>{l s='DNI / NIF / NIE'}</small></div>
					</div>
				  {elseif $field_name eq "firstname"}
				    <div class="required input-group mb-3">
				      <span class="input-group-text">{l s='First name'} <sup>*</sup></span>
					  <input type="text" class="form-control" id="firstname_invoice" name="firstname_invoice" value="{if isset($smarty.post.firstname_invoice) && $smarty.post.firstname_invoice}{$smarty.post.firstname_invoice}{/if}">
					</div>
				  {elseif $field_name eq "lastname"}
					<div class="required input-group mb-3">
					  <span class="input-group-text">{l s='Last name'} <sup>*</sup></span>
					  <input type="text" class="form-control" id="lastname_invoice" name="lastname_invoice" value="{if isset($smarty.post.lastname_invoice) && $smarty.post.lastname_invoice}{$smarty.post.lastname_invoice}{/if}">
					</div>
				  {elseif $field_name eq "address1"}
					<div class="required input-group mb-3">
					 <span class="input-group-text">{l s='Address'} <sup>*</sup></span>
					  <input type="text" class="form-control" name="address1_invoice" id="address1_invoice" value="{if isset($smarty.post.address1_invoice) && $smarty.post.address1_invoice}{$smarty.post.address1_invoice}{/if}">
					</div>
				  {elseif $field_name eq "address2"}
					<div class="input-group mb-3 is_customer_param">
					  <span class="input-group-text">{l s='Address (Line 2)'}{if in_array($field_name, $required_fields)} <sup>*</sup>{/if}</span>
					  <input type="text" class="form-control" name="address2_invoice" id="address2_invoice" value="{if isset($smarty.post.address2_invoice) && $smarty.post.address2_invoice}{$smarty.post.address2_invoice}{/if}">
					</div>
				  {elseif $field_name eq "postcode"}
					{$postCodeExist = true}
					<div class="required input-group mb-3">
					  <span class="input-group-text">{l s='Zip/Postal Code'} <sup>*</sup></span>
					  <input type="text" class="validate form-control" name="postcode_invoice" id="postcode_invoice" data-validate="isPostCode" value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}">
					</div>
				  {elseif $field_name eq "city"}
					<div class="required input-group mb-3">
					  <span class="input-group-text">{l s='City'} <sup>*</sup></span>
					  <input type="text" class="form-control" name="city_invoice" id="city_invoice" value="{if isset($smarty.post.city_invoice) && $smarty.post.city_invoice}{$smarty.post.city_invoice}{/if}">
					</div>
				  {elseif $field_name eq "country" || $field_name eq "Country:name"}
					<div class="required input-group mb-3">
					  <span class="input-group-text">{l s='Country'} <sup>*</sup></span>
					  <select name="id_country_invoice" id="id_country_invoice" class="form-control">
						<option value="">-</option>
						{foreach from=$countries item=v}
						  <option value="{$v.id_country}"{if (isset($smarty.post.id_country_invoice) && $smarty.post.id_country_invoice == $v.id_country) OR (!isset($smarty.post.id_country_invoice) && $sl_country == $v.id_country)} selected="selected"{/if}>{$v.name|escape:'html':'UTF-8'}</option>
						{/foreach}
					  </select>
					</div>
				  {elseif $field_name eq "state" || $field_name eq 'State:name'}
					{$stateExist = true}
					<div class="required input-group mb-3" style="display:none;">
					  <span class="input-group-text">{l s='State'} <sup>*</sup></span>
					  <select name="id_state_invoice" id="id_state_invoice" class="form-control">
						<option value="">-</option>
					  </select>
					</div>
				  {/if}
				{/foreach}
				{if !$postCodeExist}
				  <div class="required input-group mb-3 unvisible">
					<span class="input-group-text">{l s='Zip/Postal Code'} <sup>*</sup></span>
					<input type="text" class="form-control" name="postcode_invoice" id="postcode_invoice" value="{if isset($smarty.post.postcode_invoice) && $smarty.post.postcode_invoice}{$smarty.post.postcode_invoice}{/if}">
				  </div>
				{/if}
				{if !$stateExist}
				  <div class="required input-group mb-3 unvisible">
					<label for="id_state_invoice">{l s='State'} <sup>*</sup></label>
					<select name="id_state_invoice" id="id_state_invoice" class="form-control">
					  <option value="">-</option>
					</select>
				  </div>
				{/if}
				{if $dniExist eq false}
				  <div class="required input-group mb-3">
					<span class="input-group-text">{l s='Identification number'} <sup>*</sup></span>
					<input type="text" class="text form-control" name="dni_invoice" id="dni_invoice" value="{if isset($smarty.post.dni_invoice) && $smarty.post.dni_invoice}{$smarty.post.dni_invoice}{/if}" aria-describedby="dniHelpBlock">
					<div id="dniHelpBlock" class="form-text ms-2"><small>{l s='DNI / NIF / NIE'}</small></div>
				  </div>
				{/if}
				<div class="input-group mb-3 is_customer_param">
				  <span class="input-group-text">{l s='Additional information'}</span>
				  <textarea class="form-control" name="other_invoice" id="other_invoice" cols="26" rows="3"></textarea>
				</div>
				{if isset($one_phone_at_least) && $one_phone_at_least}
				  <p class="help-block required is_customer_param">{l s='You must register at least one phone number.'}</p>
				{/if}
				<div class="input-group mb-3 is_customer_param">
				  <span class="input-group-text">{l s='Home phone'}</span>
				  <input type="text" class="form-control" name="phone_invoice" id="phone_invoice" value="{if isset($smarty.post.phone_invoice) && $smarty.post.phone_invoice}{$smarty.post.phone_invoice}{/if}">
				</div>
				<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}input-group mb-3">
				  <span class="input-group-text">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>*</sup>{/if}</span>
				  <input type="text" class="form-control" name="phone_mobile_invoice" id="phone_mobile_invoice" value="{if isset($smarty.post.phone_mobile_invoice) && $smarty.post.phone_mobile_invoice}{$smarty.post.phone_mobile_invoice}{/if}">
				</div>
				<input type="hidden" name="alias_invoice" id="alias_invoice" value="{l s='My Invoice address'}">
			  </div>
			</div>
			{$HOOK_CREATE_ACCOUNT_FORM}
		  </div>
		  <p class="cart_navigation required submit clearfix">
			<input type="hidden" name="display_guest_checkout" value="1">
			<button type="submit" class="btn btn-lg btn-dark" name="submitGuestAccount" id="submitGuestAccount">
				  <span>
					{l s='Proceed to checkout'}
					<i class="fa fa-chevron-right"></i>
				  </span>
			</button>
		  </p>
		</form>
	  </div>
	</div>
</div>