<div class="row my-3">
  <div class="authblock col-xs-12 col-md-6 pe-lg-5">
    <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="login_form" class="box">
      <h3 class="page-subheading">{l s='Already registered?'}</h3>
      <div class="form_content">
        <div class="mb-3">
          <label for="email" class="form-label">{l s='Email address'}</label>
          <input class="is_required validate account_input form-control" data-validate="isEmail" type="email" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" required>
        </div>
        <div class="mb-3">
          <label for="passwd" class="form-label">{l s='Password'}</label>
          <input class="is_required validate account_input form-control" type="password" data-validate="isPasswd" id="passwd" name="passwd" value="" required>
        </div>
        <div class="lost_password small mb-3">
			<a href="{$link->getPageLink('password')|escape:'html':'UTF-8'}" title="{l s='Recover your forgotten password'}" rel="nofollow">{l s='Forgot your password?'}</a>
		</div>
        <div class="submit mb-5">
          {if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}">{/if}
          <button type="submit" id="SubmitLogin" name="SubmitLogin" class="btn btn-lg btn-dark">
            <i class="fa fa-sign-in-alt"></i> {l s='Sign in'}
          </button>
        </div>
      </div>
    </form>
  </div>
    <div class="col-xs-12 col-md-6 ps-lg-5">
    <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="create-account_form" class="box">
      <h3 class="page-subheading">{l s='Create an account'}</h3>
      <div class="form_content mb-5">
        <p>{l s='Want to be a new customer? Please create your account.'}</p>
        <a class="btn btn-lg btn-outline-dark" href="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}?create_account=1" type="button">
			<i class="fa fa-user-plus"></i> {l s='Create an account'}
		</a>
      </div>
    </form>
  </div>
  {if isset($inOrderProcess) && $inOrderProcess && $PS_GUEST_CHECKOUT_ENABLED}
    {include './authentication-create-opc.tpl'}
  {/if}
</div>
