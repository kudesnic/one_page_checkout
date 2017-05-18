<?php
class ModelCheckoutOnepagecheckout extends Model {
    public function addOrder($data) {
        $this->db->query("INSERT INTO `" . DB_PREFIX . "order` SET  store_id = '" . (int)$data['store_id'] . "', store_name = '" . $this->db->escape($data['store_name']) . "', store_url = '" . $this->db->escape($data['store_url']) . "', customer_id = '" . (int)$data['customer_id'] . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', firstname = '" . $this->db->escape($data['firstname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "',  payment_firstname = '" . $this->db->escape($data['firstname']) . "', payment_address_1 = '" . $this->db->escape($data['address_1']) . "',payment_city = '" . $this->db->escape($data['city']) . "', shipping_address_1 = '" . $this->db->escape($data['address_1']) . "', shipping_city = '" . $this->db->escape($data['city']) . "',shipping_method = '" . $this->db->escape($data['shipping_method']['title']) . "', shipping_code = '" . $this->db->escape($data['shipping_method']['code']) . "',payment_method = '" . $this->db->escape($data['payment_method']['title']) . "', payment_code = '" . $this->db->escape($data['payment_method']['code']) . "',payment_country='',payment_country_id = '0' ,payment_zone_id = '0',shipping_country_id = '0' ,shipping_zone_id = '0', comment = '" . $this->db->escape($data['comment']) . "', total = '" . (float)$data['cart_total'] . "', affiliate_id = '" . (int)$data['affiliate_id'] . "',language_id = '" . (int)$data['language_id'] . "', currency_id = '" . (int)$data['currency_id'] . "', currency_code = '" . $this->db->escape($data['currency_code']) . "', currency_value = '" . (float)$data['currency_value'] . "',  order_status_id = '" . (int)$data['order_status_id'] . "', ip = '" . $this->db->escape($data['ip']) . "', forwarded_ip = '" .  $this->db->escape($data['forwarded_ip']) . "', user_agent = '" . $this->db->escape($data['user_agent']) . "', accept_language = '" . $this->db->escape($data['accept_language']) . "', date_added = NOW(), date_modified = NOW()");

        $order_id = $this->db->getLastId();

        // Products
        if (isset($data['products'])) {
            foreach ($data['products'] as $product) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET order_id = '" . (int)$order_id . "', product_id = '" . (int)$product['product_id'] . "', name = '" . $this->db->escape($product['name']) . "', model = '" . $this->db->escape($product['model']) . "', quantity = '" . (int)$product['quantity'] . "', price = '" . (float)$product['price'] . "', total = '" . (float)$product['total'] . "', tax = '', reward = '" . (int)$product['reward'] . "'");

                $order_product_id = $this->db->getLastId();

                foreach ($product['option'] as $option) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "order_option SET order_id = '" . (int)$order_id . "', order_product_id = '" . (int)$order_product_id . "', product_option_id = '" . (int)$option['product_option_id'] . "', product_option_value_id = '" . (int)$option['product_option_value_id'] . "', name = '" . $this->db->escape($option['name']) . "', `value` = '" . $this->db->escape($option['value']) . "', `type` = '" . $this->db->escape($option['type']) . "'");
                }
            }
        }

        // Gift Voucher
        $this->load->model('extension/total/voucher');

        // Vouchers
        if (isset($data['vouchers'])) {
            foreach ($data['vouchers'] as $voucher) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "order_voucher SET order_id = '" . (int)$order_id . "', description = '" . $this->db->escape($voucher['description']) . "', code = '" . $this->db->escape($voucher['code']) . "', from_name = '" . $this->db->escape($voucher['from_name']) . "', from_email = '" . $this->db->escape($voucher['from_email']) . "', to_name = '" . $this->db->escape($voucher['to_name']) . "', to_email = '" . $this->db->escape($voucher['to_email']) . "', voucher_theme_id = '" . (int)$voucher['voucher_theme_id'] . "', message = '" . $this->db->escape($voucher['message']) . "', amount = '" . (float)$voucher['amount'] . "'");

                $order_voucher_id = $this->db->getLastId();

                $voucher_id = $this->model_extension_total_voucher->addVoucher($order_id, $voucher);

                $this->db->query("UPDATE " . DB_PREFIX . "order_voucher SET voucher_id = '" . (int)$voucher_id . "' WHERE order_voucher_id = '" . (int)$order_voucher_id . "'");
            }
        }

        // Totals this is netver used
        if (isset($data['cart_total']) && false ) {

            $this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = 'total', title = 'Total', `value` = '" . (float)$data['cart_total']."', sort_order = ''");
            $this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = 'sub_total', title = 'Total', `value` = '" . (float)$data['cart_total']."', sort_order = ''");

        }
        $totals = array();
        $taxes = array();
        // ex4 mod for totals
        $total_data = array(
            'totals' => &$totals,
            'taxes'  => &$taxes,
            'total'  => &$total
        );
        $sort_order = array();

        $results = $this->model_extension_extension->getExtensions('total');

        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }

        array_multisort($sort_order, SORT_ASC, $results);

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('extension/total/' . $result['code']);

                // We have to put the totals in an array so that they pass by reference.
                $this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
            }
        }

        $sort_order = array();
        foreach ($totals as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $totals);
        $i = 10;
        $total_sum = 0;
        foreach ($totals as $total) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = '".$total['code']."', title = '".$total['title']."', `value` = '" . (float)$total['value']."', sort_order = '".$i."'");
            $i += 10;
            $total_sum =  $total['value'];
        }
        // Last row in totals should be final sum...
        $this->db->query("UPDATE " . DB_PREFIX . "order SET total='".$total_sum."' WHERE order_id = '" . (int)$order_id . "'");

        return $order_id;
    }
}
