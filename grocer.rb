require "pry"

# code here

def consolidate_cart(cart)
  consolidate_cart_hash = {}
  cart.each do |element|
    element.each do |item_key, item_hash|
      if consolidate_cart_hash.has_key?(item_key) == false
          consolidate_cart_hash[item_key] = item_hash
          consolidate_cart_hash[item_key][:count] = 1
      else
          consolidate_cart_hash[item_key][:count] += 1
      end
    end
  end
cart = consolidate_cart_hash
cart
end

def apply_coupons(cart, coupons)
  coupon_cart_hash = {}
  cart.each do |key, cart_hash|
    cart_hash.each do |attribute, attribute_value|
      if coupons != []
        coupons.each do |element|
            if element[:item] == key && cart[key][:count] - element[:num] >= 0
              coupon_cart_hash[key + " W/COUPON"] = {price: element[:cost], clearance: cart[key][:clearance], count: cart[key][:count]/element[:num]}
              coupon_cart_hash[key] = cart_hash
              coupon_cart_hash[key][:count] = cart[key][:count] % element[:num]
            else
              coupon_cart_hash[key] = cart_hash
            end
          end
      else
        coupon_cart_hash[key] = cart_hash
      end
    end
  end
cart = coupon_cart_hash
cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, cart_hash|
      if cart[key][:clearance] == true
        cart[key][:price] = (cart[key][:price] * 0.8).round(2)
      end
  end
  cart
end

def checkout(cart, coupons)
  # code here

cart = consolidate_cart(cart)
cart = apply_coupons(cart, coupons)
cart = apply_clearance(cart)

cart_total = 0
  cart.each do |item, item_hash|
    cart_total += cart[item][:price] * cart[item][:count]
  end
  if cart_total > 100.00
    cart.each do |item, item_hash|
      cart[item][:price] = (cart[item][:price] * 0.9).round(2)
    end
    cart_total = 0
      cart.each do |item, item_hash|
        cart_total += cart[item][:price] * cart[item][:count]
      end
  end
  cart_total
end
