<?php echo $header; ?>
<div class="container">
<ul class="breadcrumb">
<?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
        </ul>
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>
                <div class="row"><?php echo $column_left; ?>
                <?php if ($column_left && $column_right) { ?>
                    <?php $class = 'col-sm-6'; ?>
                        <?php } elseif ($column_left || $column_right) { ?>
                            <?php $class = 'col-sm-9'; ?>
                                <?php } else { ?>
                                    <?php $class = 'col-sm-12'; ?>
                                        <?php } ?>
                                        <div id="content">
                                        <h1 style="text-align: center"><?=$heading_title?></h1>

                                        <div class="">
                                        <div class="checkout checkout-checkout">

                                        <?=$content_top; ?>

                                        <div class="payment">

                                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 payment-data">
                                        <div class="t-head">
                                        <?=$text_customer?>
                                        </div>
                                        <?php if(!$c_logged) {?>
                                        <div id="login_warning" class='checkout-content note'>
                                            <?=$text_notlogged?>

                                        </div>

                                        <?php } ?>
                                        <div id="payment-address">
                                        <div class="checkout-content" style="overflow: hidden; display: block;">
                                        <div class="fields-group">
                                        <?php if($c_logged) {?>
                                        <label for="firstname-ch"> <?=$text_full_name?> :</label><br>
                                        <input type="text" class="form-control large-field" id="firstname-ch" name="firstname"  value="<?php echo $c_name; ?>" readonly="true" />
                                        <?php } else { ?>
                                        <label for="firstname-ch"><span class="required">*</span>   <?=$text_full_name?> :</label><br>
                                        <input type="text" id="firstname-ch" name="firstname" value="" class="form-control large-field">
                                        <span class="error"></span>
                                        <?php }?>
                                        </div>
                                        <div class="fields-group">
                                        <label for="telephone-ch"><span class="required">*</span>   <?=$text_telephone?>:</label><br>
                                        <input type="tel" id="telephone-ch" name="telephone"
                                        value="<?php echo $telephone; ?>" class="form-control large-field">
                                        <span class="error"></span>

                                        </div>

                                        <div class="fields-group">
                                        <label for="email-ch">   <?=$text_email?>:</label><br>
                                        <input type="text" id="email-ch" name="email" value="<?php echo $email; ?>"
                                        class="form-control large-field">
                                        <span class="error"></span>

                                        </div>

                                        <div class="fields-group">
                                        <label for="city-ch"><span class="required">*</span>   <?=$text_town?>:</label><br>
                                        <input type="text" id="city-ch" name="city" value="<?php echo $city; ?>"
                                        class="form-control large-field">
                                        <span class="error"></span>
                                        </div>

                                        <div class="fields-group">
                                        <label for="delivery">  <?=$text_delivery_method?>:</label><br>
                                        <select onChange="updateShipping(this)" name="shipping_method" id="shipping-method" class="form-control large-field">
                                        <?php foreach ($shippig_methods as $shipping_method) { ?>
                                            <option

                                            value='{"title": "<?php echo $shipping_method['title'] ?>", "code": "<?php echo $shipping_method['value'] ?>", "comment":"", "shipping_method":"<?php echo $shipping_method['value'] ?>", "cost":"<?php echo $shipping_method['cost'] ?>","tax_class_id":""}'
                                                class="form-control large-field <?= substr($shipping_method['value'], strpos($shipping_method['value'], '.')+1 )?>"><?php echo $shipping_method['title'] ?></option>

                                                <?php } ?>
                                                </select>
                                                <br>
                                                <!--
                                                <div class="group-check">
                                                <label><input id="to-office" class="delivery-type" type="radio"
                                                name="delivery-type" checked="checked"
                                                value=" <?=$text_delivery_type_1?>">   <?=$text_delivery_type_1?></label> &nbsp;&nbsp;
                                                <label><input id="to-address" class="delivery-type" type="radio"
                                                name="delivery-type" value=" <?=$text_delivery_type_2?>">   <?=$text_delivery_type_2?></label>
                                                </div>
                                                -->
                                                <input type='hidden' name='delivery-type' value='delivery' />
                                                <label for='address_1'> <?=$text_delivery_type_2?>:</label><br/>
                                                <input type="text" name="address_1" id="address_1" value="<?php echo $address_1 ?>"
                                                class="form-control large-field" placeholder="  <?=$text_delivery_placeholder?>">
                                                <span class="error"></span>

                                                </div>
                                                <div class="fields-group" style="">
                                                <label for="payment_select">  <?=$text_payment_method?>:</label><br>
                                                <select id="payment_select" name="payment_method" class="form-control large-field">
                                                <?php foreach ($payment_methods as $payment_method) { ?>
                                                    <option
                                                        value='{"title": "<?php echo $payment_method['title'] ?>", "code": "<?php echo $payment_method['code'] ?>"}'
                                                        class="payment_method_value <?php echo $payment_method['code']?>"
                                                        style=""><?php echo $payment_method['title'] ?></option>
                                                        <?php } ?>
                                                        </select>
                                                        </div>

                                                        <div class="fields-group">
                                                        <label for="comment_field">  <?=$text_comment?>:</label><br>
                                                        <input type="text" id="comment_field" class="form-control large-field" name="comment"
                                                        value="<?php echo $comment ?>">
                                                        </div>
                                                        </div>
                                                        <div class="fields-group">
                                                        <?php if ($modules) { ?>
                                                            <div>
                                                                <?php foreach ($modules as $module) { ?>
                                                                    <?php echo $module; ?>
                                                                        <?php } ?>
                                                                        </div>
                                                                        <?php } ?>
                                                                        </div>

                                                                        </div>
                                                                       </div>
                                                                        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 checkout-data">
                                                                        <div class="cart-info table-responsive">
                                                                        <table class="table">
                                                                        <thead>
                                                                        <tr>
                                                                        <td class="name t-head">  <?=$text_product?></td>
                                                                        <td class="price t-head"><?=$text_price?></td>
                                                                        <td class="quantity t-head"><?=$text_quantity?></td>
                                                                        </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                        <?php foreach ($products as $product) { ?>
                                                                            <tr>
                                                                                <td class="name">
                                                                                <a href="/index.php?route=product/product&product_id=<?php echo $product['product_id'] ?>"><?php echo $product['name'] ?></a>
                                                                                <div class="p-model">
                                                                                <?php echo $product['model'] ?>                                </div>
                                                                                <div class="cart-option">
                                                                                <?php foreach ($product['option'] as $option) { ?>
                                                                                    -
                                                                                        <small><?php echo $option['name']; ?>
                                                                                        : <?php echo $option['value']; ?></small><br/>
                                                                                        <?php } ?>
                                                                                        <?php if ($product['recurring']): ?>
                                                                                        -
                                                                                        <small><?php echo $text_payment_profile ?>
                                                                                        : <?php echo $product['profile_name'] ?></small>
                                                                                        <?php endif; ?>
                                                                                        </div>
                                                                                        </td>
                                                                                        <td class="price"><?php echo $product['price'] ?>   </td>
                                                                                        <td class="quantity"><?php echo $product['quantity'] ?>   </td>
                                                                                        </tr>

                                                                                        <?php } ?>
                                                                                        </table>
                                                                                        <hr/>
                                                                                        <table id='totals' class='table'>
                                                                                        <tbody>
            <?php foreach ($totals as $total) { ?>
            <tr class="subtotal">
              <td class="name subtotal"><strong><?php echo $total['title']; ?>:</strong></td>
              <td class="price"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
 
                                                                                        </tbody>
                                                                                        </table>                                                                        <div id="confirm">
                                                                        <div class="payment">
                                                                        <div id="ajax-button-confirm" class=" btn btn-lg btn-success">
                                                                        <?=$text_confirm?>
                                                                        </div>
                                                                        <a href='index.php?route=checkout/cart'>
                                                                        <div id="button-modify" class=" btn btn-lg btn-cancel">
                                                                        <?=$text_cart?>
                                                                        </div>
                                                                        </a>
                                                                        </div>

                                                                        </div>
 
                                                                                        </div>
                                                                                                                                                                                <div class="col-xs-12 checkout-subinfo">
                                                                                        <?=$content_bottom?>
                                                                                        </div>
                                                                                        </div>
                                                                                        </div>
                                                                                        </div>
                                                                                        <?php echo $column_right; ?></div>
                                                                                        </div>
                    <div id="LoginModal" class="modal fade" role="dialog">
                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h3><?php echo $text_returning_customer; ?></h3>
                                </div>
                                <div class="modal-body">

                                    <p><strong><?php echo $text_i_am_returning_customer; ?></strong></p>
                                    <form  method="post" enctype="multipart/form-data">
                                        <div class="form-group">
                                            <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                                            <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                                            <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                                            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></div>
                                        <div class="btn btn-primary submit-login-form" ><?php echo $button_login; ?></div>
                                        <div>
                                            <a href="<?php echo $register ?>"> <?=$text_register;?></a>
                                            <br>
                                            <a href="<?php echo $forgotten ?>"> <?=$text_forgotten;?></a>

                                        </div>

                                    </form>
                                    <div class="errors-block"></div>
                                </div>
                                </div>

                            </div>

                        </div>
                    </div>
    <div class="hiden_payment_info"  style="display:none;"></div>

    <script type="text/javascript"><!--

function updateShipping(s) {
    shp = JSON.parse(s.value)
    $.ajax({
        url: 'index.php?route=checkout/shipping_method/save',
        type: 'post',
        data: shp,
        dataType: 'json',
        beforeSend: function() {
            $('#shipping-method').addClass('loading');
		},
        success: function(json) {
            $('.alert, .text-danger').remove();

            //if (json['redirect']) {
            //    location = json['redirect'];
            //}
            if (json['error']) {
                if (json['error']['warning']) {
                 // Error ylanyrkkaan....
                 alert(json['error']['warning']);
                }
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/onepagecheckout/totals',
                    type: 'get',
                    success: function(json) {
                        $('#totals tbody').remove();
                        $('#totals').append('<tbody></tbody');
                        for (t in json['totals']) {
                            $('#totals tbody').append('<tr class="name subtotal"><td class="name subtotal"><strong>'+json['totals'][t]['title']+'</strong></td><td class="price">'+json['totals'][t]["text"]+'</td></tr>');
                            }
                    }
                    });
                // Update Totalsi!
            }
            $('#shipping-method').removeClass('loading');
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
        }
        ); //ajax
}

$(document).ready(function () {

    $(' #LoginModal .submit-login-form ').on('click', function(){
        $.ajax({
                url: 'index.php?route=checkout/onepagecheckout/AjaxLogin',
                type: 'post',
                data: $('#LoginModal #input-email, #LoginModal #input-password '),
                dataType: 'json',
                beforeSend: function() {

                },
                success: function(json) {
                    console.log(json);
                   if(json.errors!=0){
                       if(typeof json.errors.warning!='undefined' && json.errors.warning!='')
                       $('#LoginModal .errors-block').html(json.errors.warning) ;
                       if(typeof json.errors.errors!='undefined'&& json.errors.errors!='')
                       $('#LoginModal .errors-block').append( '<br>' + json.errors.error ) ;
                   }
                   else if(json.errors==0){
                       $('#firstname-ch').prop('value',json.c_name);
                       $('#city-ch').prop('value',json.city);
                       $('#address_1').prop('value',json.address_1);
                       $('#email-ch').prop('value',json.email);
                       $('#telephone-ch').prop('value',json.telephone);
                       $('#LoginModal').modal('hide');
                       $('#login_warning').html('');
                   }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            }
        ); //ajax
        return false;
    });

            $('#ajax-button-confirm').on('click', function () {

$.ajax({
url: 'index.php?route=checkout/onepagecheckout',
type: 'post',
data: $('.checkout-checkout .payment-data input[type=\'text\'], .checkout-checkout .payment-data input[type=\'tel\'], .checkout-checkout .payment-data input[type=\'radio\']:checked, .checkout-checkout .payment-datainput input[type=\'checkbox\']:checked, .checkout-checkout .payment-data  select '),
dataType: 'json',
beforeSend: function () {
$('#ajax-button-confirm').addClass('preloader');

},
complete: function () {
$('#ajax-button-confirm').removeClass('preloader');

},
success: function (json) {
console.log(json);

if (json.error) {
if (json['error']['firstname']) {
$('#firstname-ch+.error').html(json['error']['firstname']);
}


if (json['error']['email']) {
    $('#email-ch+.error').html(json['error']['email']);
}

if (json['error']['telephone']) {
    $('#telephone-ch+.error').html(json['error']['telephone']);
}

if (json['error']['address_1']) {
    $('#address_1+.error').html(json['error']['address_1']);
}

if (json['error']['city']) {
    $('#city-ch+.error').html(json['error']['city']);
}
}

else if(json['cod']) {
    $.ajax({
        type: 'get',
        url: 'index.php?route=extension/payment/cod/confirm',
        cache: false,
        beforeSend: function() {
            $('#ajax-button-confirm').button('loading');
        },
        complete: function() {
            $('#ajax-button-confirm').button('reset');
        },
        success: function() {
            location = 'index.php?route=checkout/success';
        }
    });
}

else if(json['payment']) {
    $('.hiden_payment_info').html(json['payment']);
    console.log($('.hiden_payment_info a').attr('href'));
    location = $('.hiden_payment_info a').attr('href');
}
else {
    if (json.credit)
        credit_confirm('/index.php?route=checkout/part_payment_cart/getResult&from_privat24=true');
   /* else
        location = 'index.php?route=checkout/success'*/

}
},
error: function (xhr, ajaxOptions, thrownError) {
           alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
       }
});


});


});
//--></script>

<?php echo $footer; ?>
