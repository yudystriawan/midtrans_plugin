package com.deytri.midtrans_android.models

data class CustomerDetails(
    val firstName: String?,
    val lastName: String?,
    val email: String?,
    val phone: String?,
    val shippingAddress: Address?,
    val billingAddress: Address?,
)