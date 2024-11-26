package com.deytri.midtrans_android.models

data class CreditCard(
    val secure: Boolean?,
    val bank: String?,
    val channel: String?,
    val type: String?,
    val whitelistBins: List<String>?,
    val installment: Installment?,
    val dynamicDescriptor: DynamicDescriptor,
)

data class Installment(
    val required: Boolean?,
)

data class DynamicDescriptor(
    val merchantName: String?,
    val cityName: String?,
    val countryCode: String?,
)
