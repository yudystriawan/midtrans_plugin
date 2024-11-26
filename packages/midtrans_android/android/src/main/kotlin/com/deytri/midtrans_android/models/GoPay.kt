package com.deytri.midtrans_android.models

data class GoPay(
    val enableCallback: Boolean?,
    val callbackUrl: String?,
    val tokenization: Boolean?,
    val phoneNumber: String?,
    val countryCode: String?,
)
